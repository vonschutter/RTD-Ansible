#!/usr/bin/env bash

# Description: Auto-generates or updates a master Ansible playbook (site.yml) from roles/ directory

set -euo pipefail

ROLE_DIR="./roles"
PLAYBOOK="./site.yml"

generate_playbook() {
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

