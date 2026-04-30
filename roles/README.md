# Roles

This directory contains RTD-Ansible roles.

Roles group reusable Ansible defaults and tasks under a named capability. Top
level playbooks include these roles directly, and wrapper roles can import a
shared base role with fixed variables.

Current role families:

- `llm_server`: installs either Ollama or text-generation-webui.
- `server_metapackage_base`: installs selected Ubuntu/Debian server
  meta-packages or tasksel tasks.
- `server_meta_*`: small wrapper roles that call `server_metapackage_base` with
  a specific `server_task` value.

Generated desktop/software roles may also be placed here by scripts in
`scripts/`.
