#!/bin/bash
#ansible-playbook -l dockers  ./ansible-playbooks/setup_ubuntu1804/playbook.yml
#ansible-playbook -l dockers  ./ansible-playbooks/docker_ubuntu1804/playbook.yml

#ansible-playbook -l dockers  ./04_swarm.yaml

#ansible-playbook ./04d_swarm_workers.yaml  --extra-vars '{"join_token":"SWMTKN-1-62572j4d594zdpogdxzk9t82ygq2ksjnwpcz0owmzcimp67vei-dra3pozxfmh2v05hgt74tn8yk","remote_addrs":"10.59.4.71:2377"}'