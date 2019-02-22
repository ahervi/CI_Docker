#!/bin/bash
source *-openrc.sh
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
ansible-playbook -i inventory -u ubuntu --private-key ../mykey gitlab.yml
ansible-playbook -i inventory -u ubuntu --private-key ../mykey gitlabrunner.yml
read -p "Connecter vous à https://10.29.244.29/admin/runners, changer le mot de passe de root sur le gitlab et copier le registration token du runner ici : " TOKEN
cp registrationrunner.yml.clean registrationrunner.yml
sed -i "s/TOKENHERE/$TOKEN/g" registrationrunner.yml 
ansible-playbook -i inventory -u ubuntu --private-key ../mykey registrationrunner.yml
ansible-playbook -i inventory -u ubuntu --private-key ../mykey docker.yml
ansible-playbook -i inventory -u ubuntu --private-key ../mykey registrypull.yml
