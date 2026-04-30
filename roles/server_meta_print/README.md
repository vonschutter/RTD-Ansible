# Role: server_meta_print

This wrapper role installs the Ubuntu/Debian print server task.

It imports `server_metapackage_base` and sets:

```yaml
server_task: print-server
```

Use this role when a playbook should request print server capability through the
shared base role.
