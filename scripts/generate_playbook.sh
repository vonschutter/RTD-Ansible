#!/usr/bin/env bash
#
#::                                   A D M I N   C O M M A N D
#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
#::::::::::::::::::::::::::::// Generate RTD Site Playbook //::::::::::::::::::::::::::// Ansible / Linux //:::::::::::::
#:: Author(s):    RTD
#:: Version:      1.00
#::
#:: Script:       generate_playbook.sh
#::
#:: Purpose:      Generate the RTD-Ansible master site.yml playbook from the
#::               role directories currently present in roles/.
#::
#:: Description:  This script scans the repository roles/ directory and writes
#::               playbooks/site.yml with each discovered role listed in the
#::               playbook roles section. The generated playbook targets
#::               localhost, enables privilege escalation, and gathers facts.
#::
#:: Value:        Provides a quick way to rebuild the master site playbook after
#::               roles have been generated, added, removed, or renamed.
#::
#:: Usage:        Run this script directly from any directory:
#::
#::                 ./scripts/generate_playbook.sh
#::                 scripts/generate_playbook.sh
#::                 /full/path/to/RTD-Ansible/scripts/generate_playbook.sh
#::
#::               A broader playbook generator is also available through:
#::
#::                 scripts/rtd-rolegen generate-playbook
#::
#:: Requirements: - Bash 4+ is recommended for consistency with the rest of
#::                 the RTD-Ansible script set.
#::               - roles/ must exist and contain role directories.
#::               - The user must have write access to playbooks/site.yml.
#::
#:: Behavior:     - Determines repository paths from this script's location.
#::               - Creates playbooks/ if it does not already exist.
#::               - Overwrites playbooks/site.yml on each run.
#::               - Adds every immediate directory under roles/ to the playbook
#::                 roles list.
#::               - Prints the generated playbook path after writing the file.
#::               - Exits immediately on failed commands because strict mode is
#::                 enabled.
#::
#:: Related:      Helper scripts and callers:
#::
#::                 scripts/rtd-rolegen
#::                 scripts/generate_roles.sh
#::                 scripts/create_roles.sh
#::
#:: Notes:        Role ordering follows the shell's expansion order for
#::               roles/*/. Paths are based on this script's location, not on
#::               the directory from which the user launched it.
#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
#

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
