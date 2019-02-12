#!/bin/bash
source 201901_MSCS-container-security-openrc.sh
openstack --insecure stack delete MYSTACK
openstack --insecure keypair delete MYKEY
sleep 5
openstack --insecure keypair create --private-key ./mykey MYKEY
sleep 120
openstack --insecure stack create --template clair-stack.yml --parameter key=MYKEY MYSTACK
sleep 120
IP_FLOTTANTE_BASTION="10.29.244.44"
HOSTNAME_BASTION="ubuntu"
ssh-keygen -f ~/.ssh/known_hosts -R $IP_FLOTTANTE_BASTION
ssh-keygen -f ~/.ssh/known_hosts -R 192.168.2.3
ssh-keygen -f ~/.ssh/known_hosts -R 192.168.2.4
ssh-keygen -f ~/.ssh/known_hosts -R 192.168.2.5
scp -o StrictHostKeyChecking=no -i mykey mykey $HOSTNAME_BASTION@$IP_FLOTTANTE_BASTION:/home/$HOSTNAME_BASTION
cd ansible/
ansible-playbook -i inventory -u ubuntu --private-key ../mykey docker.yml
ansible-playbook -i inventory -u ubuntu --private-key ../mykey gitlab.yml
echo "OK ! :D"

