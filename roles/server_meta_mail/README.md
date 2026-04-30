# Role: server_meta_mail

This wrapper role installs the Ubuntu/Debian mail server task.

It imports `server_metapackage_base` and sets:

```yaml
server_task: mail-server
```

Use this role when a playbook should request mail server capability through the
shared base role.
