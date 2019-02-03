#!/bin/sh

IP_FLOTTANTE_BASTION="10.29.244.44"
HOSTNAME_BASTION="ubuntu"
ssh-keygen -f ~/.ssh/known_hosts -R $IP_FLOTTANTE_BASTION
scp -o StrictHostKeyChecking=no -i mykey mykey $HOSTNAME_BASTION@$IP_FLOTTANTE_BASTION:/home/$HOSTNAME_BASTION
