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
  handlers:
    - name: restart nginx
      service:name=nginx state=restarted
```


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
