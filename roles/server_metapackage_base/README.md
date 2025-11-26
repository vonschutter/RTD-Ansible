# Role: server_metapackage_base

Installs a selected Ubuntu server meta-package (tasksel task or apt meta) using `server_task` (e.g. `openssh-server`, `lamp-server`, `dns-server`, `mail-server`, `samba-server`, `print-server`, `postgresql-server`, `ubuntu-server`).

## Variables
- `server_task`: logical task name to install (required).
- `server_task_package_map`: mapping to the actual install string (includes the caret suffix for tasksel tasks).

## Example
```yaml
- hosts: localhost
  become: true
  roles:
    - role: server_metapackage_base
      vars:
        server_task: lamp-server
```
