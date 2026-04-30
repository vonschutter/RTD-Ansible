# Default Inventory

This directory contains the default RTD-Ansible inventory.

`hosts` defines local execution, workstation ranges, server ranges, and readable
alias groups such as `workstations`, `servers`, and `all_hosts`.

The repository `ansible.cfg` points Ansible at this inventory by default, so
commands run from the repository root use this file unless another inventory is
passed explicitly.
