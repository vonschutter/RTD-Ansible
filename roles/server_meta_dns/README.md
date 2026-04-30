# Role: server_meta_dns

This wrapper role installs the Ubuntu/Debian DNS server task.

It imports `server_metapackage_base` and sets:

```yaml
server_task: dns-server
```

Use this role when a playbook should request DNS server capability without
manually setting the base role variable.
