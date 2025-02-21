#!/bin/bash

# Check if the path was passed as an argument
if [ -z "$1" ]; then
    echo "Usage: $0 <directory_path>"
    exit 1
fi

# Execute the Docker container
docker run -v "$1:/workspace/input" \
           -e USER_ID=$(id -u) \
           -e GROUP_ID=$(id -g) \
           --user "$(id -u):$(id -g)" \
           snap-forge \
           convert-to-webp.sh /workspace/input