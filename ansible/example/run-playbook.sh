#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

ansible-playbook --list-tasks ${SCRIPT_DIR}/example-playbook.yml
ansible-playbook -i ${SCRIPT_DIR}/inventory.ini ${SCRIPT_DIR}/example-playbook.yml
