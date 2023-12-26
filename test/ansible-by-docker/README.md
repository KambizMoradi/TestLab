# Test Lab: Ansible by using Docker
This tool helps you to prepare a test environment to practice [Ansible](https://www.ansible.com) commands by using [Docker](https://www.docker.com).

## prerequisites
- you should have [nexus.local](../nexus.local/README.md) running (change [Dockerfiles](./ansible-by-docker/src/dockerfiles) manually).
    - prepare an apt proxy repo on port 8081
    - prepare a docker proxy repo on port 8082
- docker and docker-compose


# How to use
assume you need 30 worker instance
```bash
# this will create docker-compose.yaml file and also build images (if needed)
./prepare.sh 30

# run all containers to gether
docker compose up -d

# go to controller node to write and test your ansible examples
docker exec -it controller bash

# check connections
ansible-playbook ping.yaml
```
