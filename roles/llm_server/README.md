# Role: llm_server

Configures an Ubuntu host as an LLM server. Supports multiple variants via `llm_variant`.

## Supported variants
- `ollama` (default): installs via the official install script and optionally pulls models via `ollama_models`.
- `text-generation-webui`: clones the upstream repo, builds a venv, and runs a systemd service listening on `0.0.0.0:{{ textgen_port }}`.

## Variables
- `llm_variant`: `ollama` or `text-generation-webui`.
- `ollama_models`: list of models to pre-pull (empty by default).
- `textgen_root`: install path for text-generation-webui (`/opt/text-generation-webui`).
- `textgen_git_version`: git ref to deploy (`main`).
- `textgen_port`: listening port (`7860`).

## Example
```yaml
- hosts: localhost
  become: true
  roles:
    - role: llm_server
      vars:
        llm_variant: ollama
        ollama_models:
          - llama3
          - mistral
```
