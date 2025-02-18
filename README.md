# Image Processing Scripts

This repository contains a collection of Bash scripts for automating common image processing tasks. You can add watermarks, convert images to WebP format, resize images, and even perform all these operations at once!

## Features

- **Add watermark**: Overlays an image as a watermark.
- **Convert to WebP**: Converts images to WebP format, optimizing size without losing quality.
- **Resize images**: Creates thumbnails with custom dimensions.
- **Complete processing**: A single script that runs all the above operations in sequence.

## Repository Structure

- `watermark.sh`: Adds a watermark to images.
- `convert-to-webp.sh`: Converts images to WebP format.
- `thumbnails.sh`: Resizes images, creating thumbnails.
- `process-images.sh`: Runs all three operations in sequence.

## Requirements

- Linux or macOS with Bash installed.
- CLI tools: `imagemagick`, `libwebp`.

To install dependencies on Ubuntu:

```bash
sudo apt update
sudo apt install imagemagick webp
```

To install dependencies on Fedora:

```bash
sudo dnf install imagemagick libwebp-tools
```

## Usage

1. **Add watermark:**

```bash
./watermark.sh path/to/image/folder path/to/watermark.png
```

2. **Convert to WebP:**

```bash
./convert-to-webp.sh path/to/image/folder
```

3. **Resize image:**

```bash
./thumbnails.sh path/to/image/folder widthxheight
```

4. **Complete processing:**

```bash
./process-images.sh path/to/image/folder path/to/watermark.png widthxheight
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

