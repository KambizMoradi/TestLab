#!/usr/bin/bash

# copy source.list to current directory
cp $WD/../../configs/package-managers/ubuntu/jammy/etc/apt/sources.list $WD/src/

nexus_ip="192.168.3.2"

# create a temp container to extract ssh authorized key from ubuntu_controller
temp_container_name=$(echo $RANDOM | md5sum | cut --delimiter=" " --fields=1 | head -c 10)

controller_name="ubuntu-controller"
docker build --tag $controller_name --add-host nexus.local:$nexus_ip --file $WD/src/dockerfiles/$controller_name.dockerfile $WD/src
docker create --name $temp_container_name $controller_name
docker cp $temp_container_name:/root/.ssh/id_ed25519.pub $WD/src/authorized_keys
docker rm --force $temp_container_name

controller_name="ubuntu-worker"
docker build --tag $controller_name --add-host nexus.local:$nexus_ip --file $WD/src/dockerfiles/$controller_name.dockerfile $WD/src
