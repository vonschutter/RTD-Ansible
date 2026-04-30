# Role: server_meta_lamp

This wrapper role installs the Ubuntu/Debian LAMP server task.

It imports `server_metapackage_base` and sets:

```yaml
server_task: lamp-server
```

Use this role when a playbook should request the standard Linux, Apache, MySQL,
and PHP server bundle through the shared base role.
