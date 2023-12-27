#!/usr/bin/bash


main_file=$(cat $WD/src/templates/controller.yaml)
prefix=ubuntu-
template=$(cat $WD/src/templates/ubuntu.yaml)
hosts=$WD/working/hosts

echo "[ubuntu]" > $hosts
echo "ubuntu-[1:$1]" >> $hosts

for i in $(eval echo "$prefix{1..$1}");
do
	export CONTAINER_HOSTNAME=$i
	should_append=$(echo "$template" | envsubst)
	main_file=$(printf "$main_file\n\n$should_append")
done

echo "$main_file" | tee docker-compose.yaml
