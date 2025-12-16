#!/usr/bin/env bash

# RTD Role Generator – Corrected loop context (no subshells)

set -euo pipefail

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
RECIPE_URL="https://raw.githubusercontent.com/vonschutter/RTD-Setup/main/core/_rtd_recipies.info"
ROLE_BASE="${SCRIPT_DIR}/../roles"
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

sanitize_role_name() {
	local raw="$1"
	printf "%s" "$raw" | tr '[:upper:]' '[:lower:]' | sed -E 's/[^a-zA-Z0-9]+/_/g; s/^_+|_+$//g'
}

generate_role() {
	local func="$1"
	local role group_tag content

	# printf "↪ Generating from: %s\n" "$func"

	if ! declare -f "$func" >/dev/null; then
		printf "${YELLOW}⚠ Function missing: %s${NC}\n" "$func" >&2
		return
	fi

	role=$(sanitize_role_name "${func#recipe___}")
	group_tag=$(cut -d_ -f1 <<<"$role")

	if ! content=$(declare -f "$func"); then
		printf "${YELLOW}⚠ Skipping %s: function not found${NC}\n" "$func" >&2
		return
	fi

	mkdir -p "$ROLE_BASE/$role/tasks" "$ROLE_BASE/$role/defaults"

	local taskfile="$ROLE_BASE/$role/tasks/main.yml"

	cat > "$taskfile" <<EOF
---
- name: Install ${role} related tools
  block:
EOF

	while read -r line; do
		case "$line" in
			software::from_snapcraft.io*)
				pkg=$(awk '{print $2}' <<< "$line")
				printf "    - name: Install %s via Snap\n      community.general.snap:\n        name: %s\n        state: present\n" "$pkg" "$pkg"
				;;
			software::from_flathub.org*)
				pkg=$(awk '{print $2}' <<< "$line")
				printf "    - name: Install %s via Flatpak\n      community.general.flatpak:\n        name: %s\n        state: present\n        remote: flathub\n" "$pkg" "$pkg"
				;;
			software::add_native_package*)
				pkg=$(awk '{print $2}' <<< "$line")
				printf "    - name: Install native package %s\n      ansible.builtin.package:\n        name: %s\n        state: present\n" "$pkg" "$pkg"
				;;
		esac
	done < <(grep -E 'software::(from_snapcraft.io|from_flathub.org|add_native_package)[[:space:]]+[a-zA-Z0-9._:-]+' <<< "$content") >> "$taskfile"

	printf "    - name: Display completion\n      ansible.builtin.debug:\n        msg: \"Done installing tools for %s\"\n" "$role" >> "$taskfile"
	printf "  tags: [%s]\n" "$group_tag" >> "$taskfile"

	cat > "$ROLE_BASE/$role/defaults/main.yml" <<EOF
---
${role}_enabled: true
EOF

	cat > "$ROLE_BASE/$role/README.md" <<EOF
# Role: ${role}

Auto-generated from RTD recipe function.

## Usage

\`\`\`yaml
- hosts: localhost
  roles:
    - ${role}
\`\`\`
EOF

	printf "${GREEN}✔ Created role: %s${NC}\n" "$role"
}

main() {
	mkdir -p "$ROLE_BASE"

	local rawfile normfile
	rawfile=$(mktemp)
	normfile=$(mktemp)

	if ! curl -fsSL "$RECIPE_URL" -o "$rawfile"; then
		printf "${RED}✘ Failed to download recipe file${NC}\n" >&2
		exit 1
	fi

	sed -e 's/recipe:_/recipe___/g' -e 's/:/__/g' "$rawfile" > "$normfile"

	source "$normfile"

	declare -a funcs
	mapfile -t funcs < <(compgen -A function | grep '^recipe___')

	for func in "${funcs[@]}"; do
		if declare -f "$func" &>/dev/null; then
			generate_role "$func"
		else
			printf "${YELLOW}⚠ Skipping: %s (not declared)\n" "$func"
		fi
	done

	rm -f "$rawfile" "$normfile"
}

main "$@"
