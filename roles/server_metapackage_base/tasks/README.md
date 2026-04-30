# server_metapackage_base Tasks

This directory contains the task entry point for `server_metapackage_base`.

`main.yml` validates the target platform, resolves `server_task` through
`server_task_package_map`, checks package availability with an apt dry-run, and
installs the resolved server package or task.

This role is shared by the `server_meta_*` wrapper roles.
