# server_metapackage_base Defaults

This directory contains default variables for the `server_metapackage_base`
role.

`main.yml` defines:

- `server_task`: the logical server capability requested by a playbook or
  wrapper role.
- `server_task_package_map`: the mapping from logical task names to apt or
  tasksel install strings.

Wrapper roles override `server_task` and reuse the package map from this
directory.
