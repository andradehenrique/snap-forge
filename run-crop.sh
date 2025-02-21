#!/bin/bash

# Check if two parameters were passed
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <image_directory> <width>x<height>"
    exit 1
fi

# Execute the Docker container
docker run -v "$1:/workspace/input" \
           -e USER_ID=$(id -u) \
           -e GROUP_ID=$(id -g) \
           --user "$(id -u):$(id -g)" \
           snap-forge \
           crop.sh /workspace/input "$2"