# reception_ansible_modx - Ansible Astra auto configure MISOJ for modx - based on Ubuntu 20.04#

## First STEP password for vault/archive/
1. remember for EU...59 .....!SERVO
2. create vault_pass
3. unflate archive in ./files


## Using
```Bash
# extra space before cmd in zsh to not store cmd in history
$  ansible-playbook ./00_user.yaml -l misojtestpub -vv --extra-vars "ansible_ssh_user=!SET! ansible_password=!SET!  ansible_become_pass=!SET!"
# set vault password in vault_pass
$  ansible-playbook ./main.yaml
```
 
## Test
```bash
# SSH into remote server
ansible@local:~$ ssh mea@0.0.0.0
# Docker compose version
ubuntu@remote:~$ docker-compose --version
# Docker version
ubuntu@remote:~$ docker -v 
# Check if "ubuntu" user member of "docker" group
ubuntu@remote:~$ groups
# Check if "ubuntu" user can run "docker" commands
ubuntu@remote:~$ docker ps
```

 * install ansible
```
python3 -mvenv venv
source venv/bin/activate
pip3 install -r requirements.txt
```

```bash
# ! Remember to put " " before command to skip from history in zsh
# check before start , if now work see bellow
$  ansible-playbook main.yml --tags "initial"  --check -vv --step --extra-vars "ansible_user=tmp ansible_become_pass=!set!" 
$  ansible-playbook main.yml --tags "initial"  --extra-vars "ansible_user=tmp ansible_become_pass=!SET!" # create user
```

```bash
# ansible test
# only check and list , don`t do anything
ansible-playbook main.yml --check -vv --list-tasks
ansible-playbook main.yml --check -vv --list-hosts
ansible-playbook main.yml --check -vv --list-tags
# limit to  server1
ansible-playbook -l server1 main.yml 
```

## Ansible.Inventory
```bash
./inventory.py --list | tr "'" "\"" | jq
ansible-inventory --graph --vars  # --vault-password-file=.vault_pass   # ordinary in 
```

## Ansible.Structure inventory
```bash
./inventory
├── group_vars              # vars file for group variables
│   └── dockerreception
│       ├── vars            # group variable
│       └── vault           # encrypted vaulted data for variables in inventory
└── hosts -> /etc/ansible/hosts # main config hosts
```



## Ansible.Vault
```bash
ansible-vault edit ./inventory/group_vars/dockerreception/vault
ansible-inventory --graph --vars --vault-password-file=.vault_pass
```
## Ansible.debug
```bash
ANSIBLE_DEBUG=true ANSIBLE_VERBOSITY=4  ansible ....
```

## Proxmox
```bash
sudo journalctl --since today -t qm
sudo journalctl -p err --since yesterday  # from boot -b

sudo qm start 135
sudo qm monitor 135
  ->  info name
  ->  info network
!sudo!qm clone 126 135 --name MISOJ-test-pub
```

## Prepare os
```bash
ssh-copy-id tmp@10.59.20.71
#if create user by youself
$ adduser mea
$ usermod -aG sudo mea
$ ssh-copy-id mea@10.59.20.71
```


## Ansible create user set hostname configure os
```bash
# set vaultpass
export ANSIBLE_VAULT_PASSWORD_FILE=./.vault_pass
# create user
ansible-playbook --extra-vars "ansible_ssh_user=!SET! ansible_password=!SET!  ansible_become_pass=!SET!"  --vault-password-file=.vault_pass 00_user.yaml
# set hostname
ansible-playbook --vault-password-file=.vault_pass 02_hostname.yaml

```

---


### Swarm ###

  For test uses account
  admin : adminadmin


# Ansible playbook for docker swarm

# reboot all machines
 ansible swarm_workers  -b -B 1 -P 0 -m shell -a "sleep 5 && reboot"

# get nodes from swarm-manager
 docker node ls -q

#  last lines of DOCKERD journal desc time order 
 journalctl  -r -t dockerd
 ansible proxmox -l swarm_manager -a " journalctl  -r -t dockerd 

# last 100 lines of journal desc time order 
 journalctl -n 100 -r

# get docker swarm nodes
 ansible  proxmox  -l swarm_manager -a "docker node ls -q" -b

# get logs from traefic
 ansible  proxmox  -l swarm_manager -a "docker service logs traefik-consul_traefik" -b

# get dockers ps
 ansible  proxmox  -l swarm_manager -a "docker ps" -b

# check ping
  ansible proxmox -l swarm_manager -m ping

# ls stack
  ansible proxmox -l swarm_manager -b -a  "docker stack ls"

# stop service from stack
  docker service scale portainer_portainer=1

# Start container for debug backup/restore 
 docker run -it --rm -e "DOCKER_HOST=swarm-manager-01" --name cont_bckp --rm `docker volume list -q | \
 egrep -v '^.{64}$' | awk '{print "-v " $1 ":/mnt/" $1}'` -v /opt/docker_bckp/:/mnt/bckp  alpine /bin/ash





 ## Links
   - https://medium.com/swlh/deploying-docker-compose-applications-with-ansible-and-github-actions-7f1740392507
   - http://www.inanzzz.com/index.php/post/lvwk/installing-docker-and-docker-compose-on-remote-server-with-ansible
   - https://github.com/nickjj/ansible-docker


 - docker - https://diveintodocker.com/?utm_source=ansibledocker&utm_medium=github&utm_campaign=readmetop

 - network managing not netplan o ifupdown https://medium.com/opsops/screw-netplan-screw-ifupdown-f6042de0b12d