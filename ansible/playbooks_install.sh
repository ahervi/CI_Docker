#!/bin/bash

#Test si la connectivité est correcte pour ansible.
ansible all -i inventory -u ubuntu --private-key ../mykey -a "/bin/echo hello"

#Installation des playbooks de ansible galaxy.
ansible-galaxy install geerlingguy.docker
ansible-galaxy install geerlingguy.gitlab
ansible-galaxy install lean_delivery.gitlab_runner

#Exemple d'utilisation de ansible-playbook.
ansible-playbook -i inventory -u ubuntu --private-key ../mykey docker.yml
