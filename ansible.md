# Example setup
## Inventory file
eg inventory.ini:
```
[qaservers]
10.10.12.16 name=server1
10.10.9.10 ansible_user=johnh
[bare-metal]
10.10.12.50 ansible_user=root name=bay3
10.10.12.10 ansible_user=root name=bay5
```

## Playbook
Sample playbook, eg ping.yaml
```
---
- name: Ping server
  hosts: qaservers bare-metal

  tasks:
  - name: Ensure ping is working
    ping:
```
## Run playbook
```
ansible-playbook ping.yaml  -i inventory.ini
```

## Module index
These are the preinstalled modules that ship with ansible:

https://docs.ansible.com/ansible/2.9/modules/modules_by_category.html
Note the "2.9" in the URL above is the ansible version. Use the correct docs for the version you have installed (ansible --version)

## Adhoc commands
Use -m modues and -a module arguments
```
ansible localhost -m find -a "paths=/tmp file_type=file"
```

## Specify a task to start at:
ansible-playbook tags.yaml --start-at-task 'Install NTP'

## step through each task:
ansible-playbook tags.yaml --step

## check a playbook
This will run the playbook but not make any changes:

ansible-playbook tags.yaml --check

# variable

## pass variable to playbook
ansible-playbook tags.yaml -e var_name=var_value

in playbook access variables as follows:
'{{var_name}}'

## conditional use of variables:
when var_name is defined

```
  tasks:                                   
    - name: Upgrade in Redhat              
      when: ansible_os_family == "Redhat"  
      yum: name=* state=latest             
```

## loops
"packages" variable below is a list which is looped
```
---                                        
- hosts: webservers                        
  become: yes                              
  vars:                                    
    packages: [git,vim,ruby]               
                                           
  tasks:                                   
    - name: Install packages               
      apt:                                 
       name: '{{packages}}'                
       state: latest                       
                                           
```

## dictionaries
"websites below is a dictionary"
```
---                                                                             
- hosts: webservers                                                             
  become: yes                                                                   
  vars:                                                                         
    websites:                                                                   
      aws_sites:                                                                
        author: asequeira                                                       
        author_id: as001                                                        
      ms_sites:                                                                 
        author: bsmith                                                          
        author_id: bs002                                                        
      google_sites:                                                             
        author: psmith                                                          
        author_id: ps001                                                        
      misc_sites:                                                               
        author: asequeira                                                       
        author_id: as001                                                        
                                                                                
  tasks:                                                                        
    - name: Print data                                                          
      debug:                                                                    
        msg: "Here are the results: {{item.value.author_id}}"                   
      with_dict: '{{websites}}'                                                 
      when: 'item.value.author_id == "as001"'                                   

```

## Roles
Role is a way of packaging files, tasks, handlers, etc together to do a specific function
Typical directory structure of a role:
```
roles/
  common/
    tasks/
    handlers/
    library/
    files/
    templates/
    vars/
    defaults/
    meta
```
Ansible Galaxy is a way of sharing roles
Use this command to create a role:
```
ansible-galaxy init testrole1
```
Role is installed in the ~/.ansible directory


## Secrets

### Create a password protected encrypted file:
ansible-vault create test1.yml

If using the file in a playbook then add the argument --ask-value-pass

### encrypt an existing file
ansible-vault encrypt test1.yml

ansible-vault edit test1.yml

## Filters
Filters can modify values, eg convert an ip address to a new format using the ipaddr filter
```
  - set_fact: ip2="{{ip1|ipaddr('network/prefix')}}"
```
