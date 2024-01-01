#!/usr/bin/bash
function write_in_hosts_file() {
	for vm in $1
	do
		private_ip=$(vagrant ssh $vm -c "hostname -I" | cut --delimiter=" " --field=1)
		ssh_private_key=$(vagrant ssh-config $vm | grep "^  IdentityFile" | sed "s/  IdentityFile //g")
		echo $vm ansible_host=$private_ip
		echo $vm ansible_host=$private_ip ansible_ssh_private_key_file=$ssh_private_key >> $2
	done
	echo "" >> $2
}

source ./vars.sh

vagrant up


header=$(cat <<EOF
[all:vars]
ansible_user=vagrant
EOF
)
echo "$header"> $hosts_file
echo "" >> $hosts_file

managers=$(vagrant status | grep "(libvirt)" | cut --delimiter=" " --field=1 |grep manager-| sort)
workers=$(vagrant status | grep "(libvirt)" | cut --delimiter=" " --field=1 |grep worker-| sort)

echo "[managers]" >> $hosts_file
write_in_hosts_file "${managers[@]}" $hosts_file

echo "[workers]" >> $hosts_file
write_in_hosts_file "${workers[@]}" $hosts_file

echo "============================================="
echo hosts file successfully generated and stored in $target_directory

ansible-playbook playbooks/initialization.yaml
echo "============================================="
echo ansible initialization completed
