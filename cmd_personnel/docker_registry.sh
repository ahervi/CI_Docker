#!/bin/bash

#commande à exécuter pour push une image sur le registre.
docker pull debian
docker tag debian 192.168.2.4:5000/debian
docker push 192.168.2.4:5000/debian
