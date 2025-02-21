#!/bin/bash

# Check if two parameters were passed
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <image_directory> <watermark_file>"
  exit 1
fi

# Run the Docker container
docker run -v "$1:/workspace/input" \
           -v "$2:/workspace/watermark.png" \
           -e USER_ID=$(id -u) \
           -e GROUP_ID=$(id -g) \
           --user "$(id -u):$(id -g)" \
           snap-forge \
           watermark.sh /workspace/input /workspace/watermark.png