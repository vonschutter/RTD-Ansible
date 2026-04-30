# Inventories

This directory contains Ansible inventory definitions for RTD-Ansible.

Inventories define which machines Ansible can target and how those machines are
grouped. The default inventory lives in `default/` and is selected by the
repository `ansible.cfg`.

Use this directory for additional environments if needed, for example separate
home, lab, production, or customer inventories.
