# server_meta_ubuntu Tasks

This directory contains the task entry point for `server_meta_ubuntu`.

`main.yml` imports `server_metapackage_base` and passes `server_task:
ubuntu-server`. The base role performs validation, package resolution, and the
actual apt installation.
