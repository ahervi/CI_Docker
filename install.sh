sudo apt install python3-pip
sudo -H pip3 install python-openstackclient 
sudo -H pip3 install openstack-heat
sudo -H pip3 install cmd2==0.7.3
source 201901_MSCS-container-security-openrc.sh
openstack --insecure
  keypair create --private-key ~/mykey MYKEY
  stack create --template clair-stack.yml --parameter key=MYKEY MYSTACK
