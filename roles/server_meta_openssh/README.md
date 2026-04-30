# Role: server_meta_openssh

This wrapper role installs the OpenSSH server package.

It imports `server_metapackage_base` and sets:

```yaml
server_task: openssh-server
```

Use this role when a playbook should enable SSH server access through the shared
base role.
