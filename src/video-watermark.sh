#!/bin/bash

# Check if two parameters were passed
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <video_directory> <watermark_file>"
  exit 1
fi

# Video directory and watermark file
VIDEO_DIR="$1"
WATERMARK="$2"

# Check if the video directory exists
if [ ! -d "$VIDEO_DIR" ]; then
  echo "The video directory $VIDEO_DIR does not exist."
  exit 1
fi

# Check if the watermark file exists
if [ ! -f "$WATERMARK" ]; then
  echo "The watermark file $WATERMARK does not exist."
  exit 1
fi

# Create the output directory
OUTPUT_DIR="${VIDEO_DIR}/watermarks"
mkdir -p "$OUTPUT_DIR"

# Enable extended globbing for multiple file types
shopt -s nullglob
for VIDEO in "$VIDEO_DIR"/*.{mp4,mov,avi,mkv}; do
  # Check if it's a file
  if [ ! -f "$VIDEO" ]; then
    continue
  fi

  # Output file name
  OUTPUT_FILE="$OUTPUT_DIR/$(basename "$VIDEO")"

  # Add the watermark using ffmpeg with transparency and positioning, preserving high quality
  ffmpeg -i "$VIDEO" -i "$WATERMARK" \
  -filter_complex "[1:v]format=rgba,colorchannelmixer=aa=0.3[wm_transparent];[wm_transparent][0:v]scale2ref=w=iw*0.50:h=ow/mdar[wm][vid];[vid][wm]overlay=(main_w-overlay_w)/2:(main_h-overlay_h)/2" \
  -c:v libx264 -crf 23 -preset slow -c:a aac -b:a 128k -movflags +faststart "$OUTPUT_FILE"

  echo "Processed video: $OUTPUT_FILE"
done

echo "Processing complete! The videos with watermarks are in: $OUTPUT_DIR"
