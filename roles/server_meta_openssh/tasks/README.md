# server_meta_openssh Tasks

This directory contains the task entry point for `server_meta_openssh`.

`main.yml` imports `server_metapackage_base` and passes `server_task:
openssh-server`. The base role performs validation, package resolution, and the
actual apt installation.
