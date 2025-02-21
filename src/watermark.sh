#!/bin/bash

# Check if two parameters were passed
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <image_directory> <watermark_file>"
  exit 1
fi

# Image directory and watermark file
IMAGE_DIR="$1"
WATERMARK="$2"

# Check if the image directory exists
if [ ! -d "$IMAGE_DIR" ]; then
  echo "The image directory $IMAGE_DIR does not exist."
  exit 1
fi

# Check if the watermark file exists
if [ ! -f "$WATERMARK" ]; then
  echo "The watermark file $WATERMARK does not exist."
  exit 1
fi

# Create the output directory
OUTPUT_DIR="${IMAGE_DIR}/watermarks"
mkdir -p "$OUTPUT_DIR"

# Process the images
for IMAGE in "$IMAGE_DIR"/*.{jpg,jpeg,png,webp}; do
  # Check if it's a file
  if [ ! -f "$IMAGE" ]; then
    continue
  fi

  # Get image dimensions
  IMAGE_WIDTH=$(identify -format "%w" "$IMAGE")

  # Calculate watermark width as 50% of the image width
  WM_WIDTH=$((IMAGE_WIDTH / 2))

  # Create a temporary resized watermark
  TEMP_WATERMARK="/tmp/watermark_resized.png"
  convert "$WATERMARK" -resize ${WM_WIDTH}x "$TEMP_WATERMARK"

  # Output file name
  OUTPUT_FILE="$OUTPUT_DIR/$(basename "$IMAGE")"

  # Add the resized watermark
  composite -gravity south -dissolve 30% "$TEMP_WATERMARK" "$IMAGE" "$OUTPUT_FILE"
  echo "Processed image: $OUTPUT_FILE"

  # Clean up temporary watermark
  rm -f "$TEMP_WATERMARK"
done

echo "Processing complete! The images with watermarks are in: $OUTPUT_DIR"
