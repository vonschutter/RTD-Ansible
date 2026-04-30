# Role: server_meta_postgresql

This wrapper role installs the PostgreSQL server package.

It imports `server_metapackage_base` and sets:

```yaml
server_task: postgresql-server
```

Use this role when a playbook should request PostgreSQL server capability
through the shared base role.
