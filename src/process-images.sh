#!/bin/bash

# Check if three parameters were passed
if [ "$#" -ne 3 ]; then
  echo "Usage: $0 <image_directory> <watermark_file> <width>x<height>"
  exit 1
fi

# Image directory, watermark file and desired size
IMAGE_DIR="$1"
WATERMARK="$2"
SIZE="$3"

# Check if the directory exists
if [ ! -d "$IMAGE_DIR" ]; then
  echo "The directory $IMAGE_DIR does not exist."
  exit 1
fi

# Check if the watermark file exists
if [ ! -f "$WATERMARK" ]; then
  echo "The watermark file $WATERMARK does not exist."
  exit 1
fi

# Create the output directories
CROP_DIR="${IMAGE_DIR}/crops"
WATERMARK_DIR="${CROP_DIR}/watermarks"
WEBP_DIR="${WATERMARK_DIR}/webp"
mkdir -p "$WEBP_DIR"

# Step 1: Generate crops
echo "Generating crops..."
crop.sh "$IMAGE_DIR" "$SIZE"

# Step 2: Add watermark to crops with proportional scaling
echo "Adding watermark to crops..."
watermark.sh "$CROP_DIR" "$WATERMARK"

# Step 3: Convert images with watermark to WebP
echo "Converting images with watermark to WebP..."
convert-to-webp.sh "$WATERMARK_DIR"

echo "Processing complete!"
echo "Crops: $CROP_DIR"
echo "Images with watermark: $WATERMARK_DIR"
echo "WebP images: $WEBP_DIR"
