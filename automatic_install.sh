#!/bin/bash

#Ce script permet de créer toute l'architecture automatiquement. 

# --- Partie OpenStack ---

#Le source initial pour les variables d'environement : attention à l'étoile !
source *-openrc.sh

#Nettoyage : la stack MYSTACK et la clé MYKEY sont supprmimées.
openstack --insecure stack delete MYSTACK
openstack --insecure keypair delete MYKEY
sleep 5

#On crée une nouvelle clé car les vieilles clés périment au bout de quelques jours.
openstack --insecure keypair create --private-key ./mykey MYKEY
sleep 10

#On crée la stack en elle-même à partir du tempalte Heat clair-stack.yml
openstack --insecure stack create --template clair-stack.yml --parameter key=MYKEY MYSTACK
sleep 180

#On nettoie le fichier ~/.ssh/known_hosts car les clés changent à chaque fois.
IP_FLOTTANTE_BASTION="10.29.244.44"
HOSTNAME_BASTION="ubuntu"
ssh-keygen -f ~/.ssh/known_hosts -R $IP_FLOTTANTE_BASTION
ssh-keygen -f ~/.ssh/known_hosts -R 192.168.2.3
ssh-keygen -f ~/.ssh/known_hosts -R 192.168.2.4
ssh-keygen -f ~/.ssh/known_hosts -R 192.168.2.5

#On envoie la clé de connexion SSH sur le bastion pour pouvoir se connecter depuis ce dernier
# vers les autres machines : personnel, gitlab et registre.
scp -o StrictHostKeyChecking=no -i mykey mykey $HOSTNAME_BASTION@$IP_FLOTTANTE_BASTION:/home/$HOSTNAME_BASTION


# --- Partie Ansible ---
cd ansible/

#On installe gitlab sur la machine gitlab à partir du playbook ansible galaxy pour 
# gitlab de geerlingguy
ansible-playbook -i inventory -u ubuntu --private-key ../mykey gitlab.yml

#On installe gitlab-runner pour la CI sur la machine gitlab à partir du playbook 
# ansible galaxy pour gitlab-runner de lean_delivery
ansible-playbook -i inventory -u ubuntu --private-key ../mykey gitlabrunner.yml

#Pour enrgister un nouveau runner, il nous faut le registration token de gitlab et c'est l'utilisateur qui doit le fournir.
read -p "Connecter vous à https://10.29.244.29/admin/runners, changer le mot de passe de root sur le gitlab, se connecter en tant que root avec le mot de passe choisi et copier le registration token du runner ici : " TOKEN

#On réinitialise le playbook de l'enregistrement du runner pour y introduire le registration token obtenu.
cp registrationrunner.yml.clean registrationrunner.yml
sed -i "s/TOKENHERE/$TOKEN/g" registrationrunner.yml 

#On peut maintenant enregistrer un runner shell sans tag
ansible-playbook -i inventory -u ubuntu --private-key ../mykey registrationrunner.yml

#On installe docker sur le registre, le gitlab et le personnel à partir du playbook 
# ansible galaxy pour docker de geerlingguy, les utilisateur ubuntu et gitlab-runner
# sont dans le groupe docker.
ansible-playbook -i inventory -u ubuntu --private-key ../mykey docker.yml

#On pull les images nécéssaires à clair pour son utilisation sur la machine gitlab.
ansible-playbook -i inventory -u ubuntu --private-key ../mykey clair_pull.yml

#On pull et run un registre docker sur la machine docker.
ansible-playbook -i inventory -u ubuntu --private-key ../mykey registrypull.yml
