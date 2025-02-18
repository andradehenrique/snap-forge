#!/bin/bash

# Verifica se o caminho foi passado como argumento
if [ -z "$1" ]; then
  echo "Uso: $0 <caminho_da_pasta>"
  exit 1
fi

INPUT_DIR="$1"
OUTPUT_DIR="${INPUT_DIR}/converted_webp"

# Cria a pasta de saída, se não existir
mkdir -p "$OUTPUT_DIR"

# Verifica se a ferramenta cwebp está instalada
if ! command -v cwebp &> /dev/null; then
  echo "O utilitário cwebp não está instalado."
  echo "Para instalar no Ubuntu/Debian: sudo apt-get install webp"
  echo "Para instalar no Fedora: sudo dnf install libwebp-tools"
  exit 1
fi

# Função para converter imagens
convert_image() {
  local input_file="$1"
  local output_file="$OUTPUT_DIR/$(basename "${input_file%.*}").webp"
  
  echo "Convertendo: $input_file -> $output_file"
  cwebp -q 95 "$input_file" -o "$output_file"
}

# Percorre a pasta e subpastas
find "$INPUT_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" -o -iname "*.bmp" -o -iname "*.tiff" \) | while read -r file; do
  convert_image "$file"
done

echo "Conversão concluída! As imagens WebP estão em: $OUTPUT_DIR"