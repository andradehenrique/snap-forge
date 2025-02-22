#!/bin/bash

# Check if the path was passed as an argument
if [ -z "$1" ]; then
  echo "Usage: $0 <directory_path>"
  exit 1
fi

INPUT_DIR="$1"
OUTPUT_DIR="${INPUT_DIR}/webp"

# Create the output directory, if it doesn't exist
mkdir -p "$OUTPUT_DIR"

# Check if the cwebp tool is installed
if ! command -v cwebp &> /dev/null; then
  echo "The cwebp utility is not installed."
  echo "To install on Ubuntu/Debian: sudo apt-get install webp"
  echo "To install on Fedora: sudo dnf install libwebp-tools"
  exit 1
fi

# Function to convert images
convert_image() {
  local input_file="$1"
  local output_file="$OUTPUT_DIR/$(basename "${input_file%.*}").webp"
  
  echo "Converting: $input_file -> $output_file"
  cwebp -q 90 "$input_file" -o "$output_file"
}

# Iterate through the directory and subdirectories
find "$INPUT_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" -o -iname "*.bmp" -o -iname "*.tiff" \) | while read -r file; do
  convert_image "$file"
done

echo "Conversion complete! The WebP images are in: $OUTPUT_DIR"
