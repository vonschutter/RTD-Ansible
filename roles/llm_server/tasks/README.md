# llm_server Tasks

This directory contains task files for the `llm_server` role.

`main.yml` is the role entry point. It validates the target OS family and
imports the correct installer based on `llm_variant`.

Variant task files:

- `ollama.yml`: installs Ollama through snap, creates a systemd service, and
  optionally pulls models.
- `textgen.yml`: installs text-generation-webui from Git, creates a Python
  virtual environment, and runs it as a systemd service.
