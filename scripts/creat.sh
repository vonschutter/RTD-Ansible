#!/usr/bin/env bash

# Description:
#   Auto-generates Ansible role directories and inserts stub files
#   based on Bash recipe functions in a remote _rtd_recipies.info file.
#   Optionally parses the content of each function and maps snap/flatpak/native
#   installs to YAML.
#
# Author: RTD Automation Assistant

set -euo pipefail
shopt -s extglob

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# Constants
RECIPE_URL="https://raw.githubusercontent.com/vonschutter/RTD-Setup/main/core/_rtd_recipies.info"
ROLE_BASE="${SCRIPT_DIR}/../roles"
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Functions

fetch_recipes() {
    local raw
    if ! raw=$(curl -fsSL "$RECIPE_URL"); then
        printf "${YELLOW}Error: Cannot fetch recipe source from %s${NC}\n" "$RECIPE_URL" >&2
        return 1
    fi
    printf "%s\n" "$raw"
}

extract_function_blocks() {
    awk '
        /^recipe:_[a-zA-Z0-9_(): -]+[[:space:]]*\(\)[[:space:]]*\{/ {
            funcname = $0
            body = ""
            depth = 1
            getline
            while (depth > 0) {
                body = body $0 "\n"
                if ($0 ~ /\{/) depth++
                if ($0 ~ /\}/) depth--
                getline
            }
            print funcname "\n" body "\nEND_FUNC"
        }
    '
}

sanitize_role_name() {
    printf "%s" "$1" | sed -E 's/[^a-zA-Z0-9]+/_/g' | tr '[:upper:]' '[:lower:]' | sed -E 's/^_+|_+$//g'
}

create_role_files() {
    local role="$1"
    local dest="${ROLE_BASE}/${role}"

    mkdir -p "${dest}/tasks" "${dest}/defaults"

    cat > "${dest}/tasks/main.yml" <<EOF
---
# Tasks for role: ${role}

- name: Install ${role} related tools
  ansible.builtin.debug:
    msg: "Installing ${role}..."
EOF

    cat > "${dest}/defaults/main.yml" <<EOF
---
# Default vars for ${role}
${role}_enabled: true
EOF

    cat > "${dest}/README.md" <<EOF
# Role: ${role}

This Ansible role was auto-generated from _rtd_recipies.info function: ${role}

## Usage

\`\`\`yaml
- hosts: localhost
  roles:
    - ${role}
\`\`\`
EOF
}

parse_software_lines_to_yaml_tasks() {
    local role="$1"
    local content="$2"
    local taskfile="${ROLE_BASE}/${role}/tasks/main.yml"

    {
        printf "\n- name: Install packages for %s\n  block:\n" "$role"

        grep -Eo 'software::(from_snapcraft.io|from_flathub.org|add_native_package)[[:space:]]+[^\$]+' <<<"$content" |
        while read -r line; do
            case "$line" in
                software::from_snapcraft.io*)
                    pkg=$(awk '{print $2}' <<<"$line")
                    printf "    - name: Install %s via Snap\n      community.general.snap:\n        name: %s\n        state: present\n" "$pkg" "$pkg"
                    ;;
                software::from_flathub.org*)
                    pkg=$(awk '{print $2}' <<<"$line")
                    printf "    - name: Install %s via Flatpak\n      community.general.flatpak:\n        name: %s\n        state: present\n        remote: flathub\n" "$pkg" "$pkg"
                    ;;
                software::add_native_package*)
                    pkg=$(awk '{print $2}' <<<"$line")
                    printf "    - name: Install native package %s\n      ansible.builtin.package:\n        name: %s\n        state: present\n" "$pkg" "$pkg"
                    ;;
            esac
        done

        printf "\n    - name: Display completion\n      ansible.builtin.debug:\n        msg: \"Done installing tools for %s\"\n" "$role"
    } >> "$taskfile"
}

main() {
    mkdir -p "$ROLE_BASE"
    local raw
    raw=$(fetch_recipes)
    local block funcname content role_name

    while IFS= read -r block; do
        if [[ $block == recipe:* ]]; then
            funcname=$(awk '{print $1}' <<<"$block" | sed 's/recipe:_//; s/().*//')
            role_name=$(sanitize_role_name "$funcname")
            content=""
        elif [[ $block == END_FUNC ]]; then
            create_role_files "$role_name"
            parse_software_lines_to_yaml_tasks "$role_name" "$content"
            printf "${GREEN}✔ Created role: %s${NC}\n" "$role_name"
        else
            content+=$'\n'"$block"
        fi
    done < <(printf "%s" "$raw" | extract_function_blocks)
}

main "$@"
