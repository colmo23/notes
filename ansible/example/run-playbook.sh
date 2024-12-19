#!/bin/bash

ansible-playbook --list-tasks example-playbook.yml
ansible-playbook -i inventory.ini example-playbook.yml
