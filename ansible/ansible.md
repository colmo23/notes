# Overview

ansible-playbook webservers.yml

Playbooks are made up of multiple tasks and handlers. Sample webserver.yml:
```
---
- name: Configure Webservers
  hosts: webservers
  tasks:
    - name: Install nginx
      package: name=nginx
      notify: Restart nginx
  handlers:
    - name: Restart nginx
      service:name=nginx state=restarted
```
The handler called "Restart nginx" is only called if there is a change done by the "Install nginx" task which has a "notify:" operation in it.


```
  tasks:
    - name: Install nginx
      package:                   <-- module being used by task
        name: nginx              <-- argument to module (see above for alternative syntax)
```


Can have variables
```
vars:
 tls_dir: /etc/nginx/ssl/
```

Above variable can be used in task or templates as follows: "{{ tls_dir }}"

Template task can modify and then copy a config file 
```
- name: Manage nginx config template
 template:
   src: nginx.conf.j2
   dest: /etc/nginx.conf
   mode: '0644'
```

 "notify:" can call a handler when a task has finished

Ansible "roles" are attributes you assign to one or more hosts. Eg database role, OAM role.

```
ansible-playbook --check webservers.yml

ansible-playbook -i inventory.ini -m ping
ansible -i inventory.ini -m command -a uptime
ansible -i inventory.ini -m command -a "tail /var/log/dmesg"
run the same as privelged (add -b):
ansible -i inventory.ini -b -m command -a "tail /var/log/dmesg"
ansible-inventory --graph
ansible-doc <module name> - info on a module
```

print out ansible facts - system variables that can be used by playbooks
ansible <hostname> -m ansible.builtin.setup
- example of fact variable - {{ hostvars['asdf.example.com']['ansible_facts']['os_family'] }}



Use "register" keyword to store output of an ansible task as follows:
```
tasks:
 - name: Capture output of id command
 command: id -un
 register: login
 - debug: var=login
 - debug: msg="Logged in as user {{ login.stdout }}"
```

List tasks in a playbook
```
ansible-playbook --list-tasks mezzanine.yml
```

Debugger
```
- name: deploy mezzanine on web
  hosts: web
  debugger: always
```

Assertions - check something and fail if it is not present
```
- name: Assert that the enp0s3 ethernet interface exists
  assert:
    that: ansible_enp0s3 is defined
```

For example, check if file exists
```
- name: Stat /boot/grub
  stat:
    path: /boot/grub
  register: st
- name: Assert that /boot/grub is a directory
  assert:
    that: st.stat.isdir
```

Can tag roles or tasks and then use the --tags or --skip-tags command line args to only run or skip those tags

Can use --limit argument to only run playbook on certain hosts.

Below if the variable database_host does not exist then "localhost" is used
```
host: "{{ database_host | default('localhost') }}"
```

Create a blank role directory structure:
```
ansible-galaxy role init my-role
```

Only run playbook on certain types of server (eg webservers):
```
ansible-playbook playbook.yml --limit webservers
```

# Testing

## Hierarchy of checking
* yamllint
* ansible-playbook --syntax-check
* ansible-lint
* molecule test
* ansible-playbook --check


Use debug module to output details
Use fail and assert modules to check
