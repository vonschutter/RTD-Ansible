# RTD-Ansible

## Repository layout

- `inventories/` – environment specific inventories (default hosts file under `default/`).
- `playbooks/` – all top-level playbooks including workstation/server updates and generated sites.
- `roles/` – generated Ansible roles (populate via scripts in `scripts/`).
- `scripts/` – helper automation such as role/playbook generators (`rtd-rolegen`, `generate_roles.sh`, etc.).

## New server roles
- `llm_server`: deploys an Ubuntu LLM stack (`ollama` by default, `text-generation-webui` optional).
- `server_metapackage_base`: installs a chosen Ubuntu server meta-package (tasksel tasks such as `lamp-server`, `dns-server`, etc.).
- Wrapper roles for common server tasks: `server_meta_openssh`, `server_meta_lamp`, `server_meta_dns`, `server_meta_mail`, `server_meta_samba`, `server_meta_print`, `server_meta_postgresql`, `server_meta_ubuntu`.

Quick pull example for a fresh VM:
```bash
ansible-pull -U https://github.com/vonschutter/RTD-Ansible.git playbooks/server-auto-config.yml \
  -e '{"server_tasks":["openssh-server","lamp-server"],"llm_enable":true,"llm_variant":"ollama","ollama_models":["llama3"]}'
```
