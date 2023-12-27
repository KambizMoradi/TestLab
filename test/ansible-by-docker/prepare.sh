#!/usr/bin/bash

export WD=$(pwd)
source ./src/build_images.sh
source ./src/generate_compose_file.sh $1
