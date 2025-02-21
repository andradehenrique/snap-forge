#!/bin/bash

# Check if the path was passed as an argument
if [ "$#" -ne 3 ]; then
  echo "Usage: $0 <image_directory> <watermark_file> <width>x<height>"
  exit 1
fi

# Execute the Docker container
docker run -v "$1:/workspace/input" \
           -v "$2:/workspace/watermark.png" \
           -e USER_ID=$(id -u) \
           -e GROUP_ID=$(id -g) \
           --user "$(id -u):$(id -g)" \
           snap-forge \
           process-images.sh /workspace/input /workspace/watermark.png "$3"