# server_meta_mail Tasks

This directory contains the task entry point for `server_meta_mail`.

`main.yml` imports `server_metapackage_base` and passes `server_task:
mail-server`. The base role performs validation, package resolution, and the
actual apt/tasksel installation.
