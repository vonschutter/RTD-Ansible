# llm_server Defaults

This directory contains default variables for the `llm_server` role.

`main.yml` defines which LLM stack to install and the settings consumed by the
variant task files:

- `llm_variant`
- `ollama_models`
- `textgen_root`
- `textgen_repo`
- `textgen_venv`
- `textgen_port`
- `textgen_git_version`

Defaults can be overridden from playbooks, inventory variables, host/group
variables, or command-line extra vars.
