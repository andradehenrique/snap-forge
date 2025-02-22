# SnapForge

Snap Forge is a versatile image and video processing toolkit designed to simplify common tasks like resizing, watermarking, and converting images to WebP format. Now with Docker support!

## Features

- **Add watermark to image**: Overlays an image as a watermark.
- **Convert to WebP**: Converts images to WebP format, optimizing size without losing quality.
- **Resize images**: Resize with custom dimensions.
- **Complete processing**: A single script that runs all the above operations in sequence.
- **Add watermark to video**: Overlays an video as a watermark.
- **Extract thumbnail of video**: Generate a thumbnail in webp of video.

## Repository Structure

- `watermark.sh`: Adds a watermark to images.
- `convert-to-webp.sh`: Converts images to WebP format.
- `crop.sh`: Resizes images, creating thumbnails.
- `process-images.sh`: Runs all three operations in sequence.
- `video-watermark.sh`: Adds a watermark to videos and creates a thumbnail in webp.


## Requirements

- Linux or macOS with Bash installed or Docker.
- CLI tools: `imagemagick`, `libwebp`, `ffmpeg`.

## Usage without docker

1. **Add watermark to image:**

```bash
./src/watermark.sh path/to/image/folder path/to/watermark.png
```

2. **Convert to WebP:**

```bash
./src/convert-to-webp.sh path/to/image/folder
```

3. **Resize image:**

```bash
./src/crop.sh path/to/image/folder widthxheight
```

4. **Complete processing:**

```bash
./src/process-images.sh path/to/image/folder path/to/watermark.png widthxheight
```

5. **Add watermark to video:**

```bash
./src/video-watermark.sh path/to/video/folder path/to/watermark.png
```

## Usage docker

1. **Add watermark to image:**

```bash
./run-image-watermark.sh path/to/image/folder path/to/watermark.png
```

2. **Convert to WebP:**

```bash
./run-convert-to-webp.sh path/to/image/folder
```

3. **Resize image:**

```bash
./run-crop.sh path/to/image/folder widthxheight
```

4. **Complete processing:**

```bash
./run-process-images.sh path/to/image/folder path/to/watermark.png widthxheight
```

5. **Add watermark to video:**

```bash
./run-video-watermark.sh path/to/video/folder path/to/watermark.png
```

## Contributing

Contributions are welcome! Feel free to open issues and submit pull requests.

1. Fork the repository.
2. Create a new branch:

```bash
git checkout -b my-new-feature
```

3. Make your changes and commit:

```bash
git commit -m "Add new feature X"
```

4. Push to the branch:

```bash
git push origin my-new-feature
```

5. Open a Pull Request!

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

✨ **Feel free to adapt and improve!** If you need help or have questions, open an issue! 🚀

