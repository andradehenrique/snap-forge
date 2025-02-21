#!/bin/bash

# Check if two parameters were passed
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <image_directory> <width>x<height>"
  exit 1
fi

# Image directory and desired size
IMAGE_DIR="$1"
SIZE="$2"
WIDTH=${SIZE%x*}
HEIGHT=${SIZE#*x}

# Check if the image directory exists
if [ ! -d "$IMAGE_DIR" ]; then
  echo "The image directory $IMAGE_DIR does not exist."
  exit 1
fi

# Create the output directory
CROP_DIR="${IMAGE_DIR}/crops"
mkdir -p "$CROP_DIR"

# Process the images
for IMAGE in "$IMAGE_DIR"/*.{jpg,jpeg,png,webp}; do
  # Check if it's a file
  if [ ! -f "$IMAGE" ]; then
    continue
  fi

  # Get original dimensions
  ORIGINAL_SIZE=$(identify -format "%w %h" "$IMAGE")
  ORIGINAL_WIDTH=$(echo "$ORIGINAL_SIZE" | cut -d ' ' -f 1)
  ORIGINAL_HEIGHT=$(echo "$ORIGINAL_SIZE" | cut -d ' ' -f 2)

  # Output file name
  CROP_FILE="$CROP_DIR/$(basename "$IMAGE")"

  # Determine whether to resize or keep original size
  if [ "$ORIGINAL_WIDTH" -gt "$WIDTH" ] || [ "$ORIGINAL_HEIGHT" -gt "$HEIGHT" ]; then
    # Resize only if both dimensions are larger than the desired size
    convert "$IMAGE" -resize "$SIZE" "$CROP_FILE"
    echo "Resized image generated: $CROP_FILE"
  else
    # Keep the original size if resizing is not possible without upscaling
    cp "$IMAGE" "$CROP_FILE"
    echo "Original size kept (no upscaling): $CROP_FILE"
  fi

done

echo "Processing complete! The cropped images are in: $CROP_DIR"
