# Test Lab: Docker Swarm Config By Using Ansible
This tool helps you to config a test cluster by using [Ansible](https://www.ansible.com)

## Requirements
- Inventory file (`hosts`) should be present in the repository directory. (you can generate it by using [this script](../../infrastructures/create-cluster-by-vagrant/ansible_inventory.sh)
    - It should contain:
        1. IP Addresses
        2. ansible\_user
        3. ssh\_private\_key address
- [Ansible](https://www.ansible.com)

## How To Use
```bash
# initiate vms
./vm-initiate.sh

# remove vms
./vm-destroy.sh
```
