# server_meta_print Tasks

This directory contains the task entry point for `server_meta_print`.

`main.yml` imports `server_metapackage_base` and passes `server_task:
print-server`. The base role performs validation, package resolution, and the
actual apt/tasksel installation.
