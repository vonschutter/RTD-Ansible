# Role: server_meta_ubuntu

This wrapper role installs the Ubuntu server baseline package.

It imports `server_metapackage_base` and sets:

```yaml
server_task: ubuntu-server
```

Use this role when a playbook should request the standard Ubuntu server baseline
through the shared base role.
