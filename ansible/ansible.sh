ansible all -i inventory -u ubuntu --private-key ../mykey -a "/bin/echo hello"
ansible-galaxy install geerlingguy.docker

ansible-playbook -i inventory -u ubuntu --private-key ../mykey docker.yml
