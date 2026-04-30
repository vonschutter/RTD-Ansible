# RTD-Ansible Scripts

This directory contains helper automation for generating RTD-Ansible roles,
building playbooks, documenting generated roles, and running selected
maintenance playbooks.

## Recommended entry point

Use `rtd-rolegen` for normal role and playbook automation:

```bash
./scripts/rtd-rolegen help
./scripts/rtd-rolegen generate-roles
./scripts/rtd-rolegen generate-playbook
./scripts/rtd-rolegen list
```

`rtd-rolegen` wraps the lower-level generator scripts and provides a consistent
operator interface.


rtd-rolegen
  └── generate_roles.sh

generate_roles.sh OR create_roles.sh
  └── writes roles/

generate_playbook.sh
  └── reads roles/
  └── writes playbooks/site.yml

rtd-rolegen generate-playbook/site/install-role/build-docs/list/lint
  └── reads roles/
  └── writes playbooks/*.yml or ROLES.md

update-all-server-software.sh
  └── runs playbooks/update-all-server-software.yml

## Script index

| Script                            | Purpose                                                                                                                                                                     |
| --------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `rtd-rolegen`                   | Main RTD role CLI for generating roles, generating playbooks, listing roles, linting roles, building role docs, running a single role, and resetting generated role output. |
| `generate_roles.sh`             | Generates Ansible role directories from RTD recipe functions in the upstream `_rtd_recipies.info` file.                                                                   |
| `generate_playbook.sh`          | Generates `playbooks/site.yml` from the role directories currently present in `roles/`.                                                                                 |
| `create_roles.sh`                      | Alternate role creator that extracts recipe function blocks without sourcing the downloaded recipe file.                                                                    |
| `update-all-server-software.sh` | Runs the Ansible playbook that updates software on hosts in the `all_servers` inventory group.                                                                            |

## Common workflows

Generate roles from the upstream RTD recipe source:

```bash
./scripts/rtd-rolegen generate-roles
```

Generate the master site playbook:

```bash
./scripts/rtd-rolegen generate-playbook
```

Generate a group-specific playbook from role tags:

```bash
./scripts/rtd-rolegen site cloud
```

List generated roles and tags:

```bash
./scripts/rtd-rolegen list
```

Build the role index:

```bash
./scripts/rtd-rolegen build-docs
```

Run server software updates through Ansible:

```bash
./scripts/update-all-server-software.sh
```

## Requirements

- Bash 4+.
- Ansible for playbook execution.
- `ansible-lint` for `rtd-rolegen lint`.
- `curl` for scripts that fetch `_rtd_recipies.info`.
- Standard GNU userland tools such as `awk`, `sed`, `grep`, `tr`, and `mktemp`.
- Write access to generated output paths such as `roles/`, `playbooks/`, and
  `ROLES.md`.

## Generated output

These scripts can create or overwrite generated files under:

- `roles/<role>/tasks/main.yml`
- `roles/<role>/defaults/main.yml`
- `roles/<role>/README.md`
- `playbooks/site.yml`
- `playbooks/site-<group>.yml`
- `playbooks/install-<role>.yml`
- `ROLES.md`

Review generated changes before committing them.

## Notes

Scripts are path-location aware. They can be launched from outside the
repository, but generated output is written relative to this RTD-Ansible
repository.

`rtd-rolegen reset-all` removes generated roles and generated site/install
playbooks before recreating roles and `site.yml`.
