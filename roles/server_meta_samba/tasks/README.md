# server_meta_samba Tasks

This directory contains the task entry point for `server_meta_samba`.

`main.yml` imports `server_metapackage_base` and passes `server_task:
samba-server`. The base role performs validation, package resolution, and the
actual apt/tasksel installation.
