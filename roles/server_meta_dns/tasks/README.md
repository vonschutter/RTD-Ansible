# server_meta_dns Tasks

This directory contains the task entry point for `server_meta_dns`.

`main.yml` imports `server_metapackage_base` and passes `server_task:
dns-server`. The base role performs validation, package resolution, and the
actual apt/tasksel installation.
