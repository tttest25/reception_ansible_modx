# Reception project automation infrastructure
0. Prepare VM with Debian 9 strech (astra) - 

0.1 Example on vmbox
& 'C:\Program Files\Oracle\VirtualBox\VBoxManage.exe' list vms
& 'C:\Program Files\Oracle\VirtualBox\VBoxManage.exe' startvm --type=separate "reception_prod_astra_ce"
& 'C:\Program Files\Oracle\VirtualBox\VBoxManage.exe' list -l runningvms


1. prepare OS - remove not needed X application and upgrade CA

apt remove firefox thunderbird x11-common 
apt autoremove && apt autoclean
apt update && apt upgrade


2. run ansible playbooks

3. prepare database and restore dump
```
create database modx_reception;
CREATE USER 'test32'@'%' IDENTIFIED BY 'test32test32';
grant all privileges on modx_reception.* TO test32@'%';

grant all privileges on modx_reception.* TO modx@'%';

flush privileges;
```
4. install docker gittify
``` /docker/docker-gitify ```
5. rsync files + restore db from backup

6. gittify backup
