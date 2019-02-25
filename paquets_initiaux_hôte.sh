#!/bin/bash

#Ce script décrit les commandes à utiliser pour installer les outils nécéssaires pour travailler 
# sur ce projet

#Installation de la CLI pour OpenStack :
sudo apt update
sudo apt install python3-pip
sudo -H pip3 install python-openstackclient 
sudo -H pip3 install openstack-heat
sudo -H pip3 install cmd2==0.7.3

#Installation de Ansible
sudo apt update
sudo apt-get install software-properties-common
sudo apt-add-repository ppa:ansible/ansible
sudo apt update
sudo apt install ansible

#Misc :
#  Dans le dossier ansible, il y a un dossier group_vars qui contient docker.yml contenant :
#  ansible_ssh_common_args: '-o StrictHostKeyChecking=no -o ProxyCommand="ssh -o StrictHostKeyChecking=no -i ../mykey -W %h:%p -q ubuntu@10.29.244.44"
#  Cela permet d'utiliser ansible depuis l'hôte via le bastion.
