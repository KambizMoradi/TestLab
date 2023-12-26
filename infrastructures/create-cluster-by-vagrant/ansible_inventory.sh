#!/usr/bin/bash

target_directory=$(realpath $1)
hosts_file=$target_directory/hosts

header=$(cat <<EOF
[all:vars]
ansible_user=vagrant

[vms]
EOF
)
echo "$header" > $hosts_file

vms=$(vagrant status | grep "(libvirt)" | cut --delimiter=" " --field=1 | sort)
for vm in $vms
do
	private_ip=$(vagrant ssh $vm -c "hostname -I" | cut --delimiter=" " --field=1)
	ssh_private_key=$(vagrant ssh-config $vm | grep "^  IdentityFile" | sed "s/  IdentityFile //g")
	echo $vm ansible_host=$private_ip ansible_ssh_private_key_file=$ssh_private_key
	echo $vm ansible_host=$private_ip ansible_ssh_private_key_file=$ssh_private_key >> $hosts_file
done

echo
echo "=============================="
if [ $? -eq 0 ]; then
    echo hosts file successfully generated and stored in $target_directory
else
	echo FAIL
fi
