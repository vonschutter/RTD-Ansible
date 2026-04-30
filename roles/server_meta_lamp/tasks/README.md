# server_meta_lamp Tasks

This directory contains the task entry point for `server_meta_lamp`.

`main.yml` imports `server_metapackage_base` and passes `server_task:
lamp-server`. The base role performs validation, package resolution, and the
actual apt/tasksel installation.
