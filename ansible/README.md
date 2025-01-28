002_EKS
```
aws eks update-kubeconfig --region eu-west-3 --name cbertrand-eks
```




003_ECS

```
mv ansible/cbertrand-key.pem ~/.ssh/cbertrand-key.pem
ssh-add --apple-use-keychain ~/.ssh/cbertrand-key.pem
ansible-playbook -i ansible/hosts_jumphost.yml ansible/playbook.yml
```

In local Create file => ~/.ssh/config
```
Host jumphost
Hostname <ip-address or DNS name of your jumphost>
User ubuntu
IdentityFile ~/.ssh/cbertrand-key.pem
ForwardAgent yes
```

In the jumphost (ssh jumphost) :
```
ansible-playbook -i hosts.yml confluent.platform.all --skip-tags pip-package
```


The Ansible file playbook.yml do the following actions :
```
scp ansible/hosts.yml hosts.json jumphost:

sudo apt update
sudo apt upgrade
sudo apt install ansible
sudo apt install openjdk-21-jdk
ansible-galaxy collection install confluent.platform
```

Create file => ~/.ansible.cfg
```
[defaults]
host_key_checking = False
hash_behaviour = merge
```

To remove only jumphost module
```
terraform destroy -target module.ec2_instance_jumphost
```


