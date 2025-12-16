#!/usr/bin/env bash

# Description: Auto-generates or updates a master Ansible playbook (site.yml) from roles/ directory

set -euo pipefail

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ROLE_DIR="${SCRIPT_DIR}/../roles"
PLAYBOOK="${SCRIPT_DIR}/../playbooks/site.yml"

generate_playbook() {
	mkdir -p "$(dirname "$PLAYBOOK")"
	cat > "$PLAYBOOK" <<EOF
---
- name: Run all available roles
  hosts: localhost
  become: true
  gather_facts: true

  roles:
EOF

	for dir in "$ROLE_DIR"/*/; do
		role=$(basename "$dir")
		printf "    - %s\n" "$role" >> "$PLAYBOOK"
	done

	printf "\033[0;32m✔ Generated playbook: %s\033[0m\n" "$PLAYBOOK"
}

generate_playbook
