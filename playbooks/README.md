# Playbooks

This directory contains top-level Ansible playbooks for RTD-Ansible.

Playbooks are the entry points used by operators and scripts. They combine
inventory targets, variables, roles, and direct tasks to configure or maintain
systems.

Key playbooks:

- `server-auto-config.yml`: installs selected server meta-packages and can
  enable the `llm_server` role.
- `update-all-server-software.yml`: updates software on hosts in
  `all_servers`.
- `update-workstations.yml`: updates software on the local workstation target.
- `site.yml`: generated role runner built from available roles.
- `configure-workstations.yml`: workstation setup and package maintenance.
- `software-install.yaml`: software installation playbook for selected desktop
  applications.
- `documented_reference_playbook.yml`: reference material for playbook syntax
  and documentation style.

Generated playbooks may be overwritten by scripts in `scripts/`.
