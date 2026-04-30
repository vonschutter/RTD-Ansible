# Role: server_meta_samba

This wrapper role installs the Ubuntu/Debian Samba server task.

It imports `server_metapackage_base` and sets:

```yaml
server_task: samba-server
```

Use this role when a playbook should request Samba file-sharing capability
through the shared base role.
