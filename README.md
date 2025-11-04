# RTD-Ansible

## Repository layout

- `inventories/` – environment specific inventories (default hosts file under `default/`).
- `playbooks/` – all top-level playbooks including workstation/server updates and generated sites.
- `roles/` – generated Ansible roles (populate via scripts in `scripts/`).
- `scripts/` – helper automation such as role/playbook generators (`rtd-rolegen`, `generate_roles.sh`, etc.).
