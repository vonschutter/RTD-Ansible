#!/usr/bin/env bash
#
#::                                   A D M I N   C O M M A N D
#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
#::::::::::::::::::::::::::::// Update All Server Software //::::::::::::::::::::::::::::::// Ansible / Linux //:::::::::
#:: Author(s):    RTD
#:: Version:      1.00
#::
#:: Script:       update-all-server-software.sh
#::
#:: Purpose:      Run the Ansible playbook that updates software on every host
#::               in the all_servers inventory group.
#::
#:: Description:  The playbook updates package metadata, upgrades installed
#::               packages through the target system package manager, refreshes
#::               Snap packages when Snap is installed, and applies common
#::               server configuration from:
#::
#::                 playbooks/update-all-server-software.yml
#::
#:: Value:        Provides the Ansible equivalent of RTD system-admin update
#::               helpers for managed server groups instead of a single local
#::               workstation.
#::
#:: Usage:        Run this script directly from any directory:
#::
#::                 ./scripts/update-all-server-software.sh
#::                 scripts/update-all-server-software.sh
#::                 /full/path/to/RTD-Ansible/scripts/update-all-server-software.sh
#::
#:: Requirements: - Ansible must be installed on the control machine.
#::               - Target hosts must be listed in inventories/default/hosts
#::                 under the all_servers group.
#::               - SSH access and privilege escalation must be configured for
#::                 the target hosts.
#::               - The user running the script must know the become password
#::                 when prompted.
#::
#:: Behavior:     - Determines the repository root from this script's location.
#::               - Temporarily changes to the repository root before running
#::                 Ansible so the repository ansible.cfg is loaded.
#::               - Uses ansible.cfg to locate inventories/default/hosts and
#::                 roles/.
#::               - Returns to the previous directory after Ansible completes.
#::               - Exits with the same status code as ansible-playbook.
#::
#:: Related:      RTD local admin scripts live in:
#::
#::                 /home/stephans/GIT/RTD-Setup/modules/oem-system-admin.mod/
#::
#::               Comparable local maintenance helpers include:
#::                 rtd-update-system
#::                 rtd-deb-cleanup
#::                 rtd-oem-old-kernel-remover
#::                 rtd-ppa-checker
#::                 rtd-script-menu
#::
#:: Notes:        Paths in this script are based on the script location, not on
#::               the directory from which the user launched the script. Paths
#::               in ansible.cfg are resolved by Ansible after that config file
#::               has been loaded.
#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
#
set -euo pipefail

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
repo_root="$(cd -- "${script_dir}/.." && pwd)"

pushd "${repo_root}" > /dev/null
if ansible-playbook --ask-become playbooks/update-all-server-software.yml; then
    status=0
else
    status=$?
fi
popd > /dev/null

exit "${status}"
