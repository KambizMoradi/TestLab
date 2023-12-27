# Test Lab: Cluster by using Vagrant
This tool helps you to prepare a test cluster environment by using [Vagrant](https://www.vagrantup.com)

## Requirements
- [libvirt](https://libvirt.org/) (Note: You can also use [VMware](https://www.vmware.com) or [VirtualBox](https://www.virtualbox.org), but in this repo we use use by [libvirt](https://libvirt.org/) default.)
- [Vagrant](https://www.vagrantup.com)

## How To Use
```bash
# assume you need 3 virtual machines
export vms_number=3

# create and start virtual machines
vagrant up

# generate hosts file to be used in ansible
./ansible_inventory.sh <target directory>
```

