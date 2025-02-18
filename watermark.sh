#!/bin/bash

# Verifica se foram passados dois parâmetros
if [ "$#" -ne 2 ]; then
  echo "Uso: $0 <caminho_das_imagens> <caminho_da_marca_dagua>"
  exit 1
fi

# Caminho das imagens e da marca d'água
IMAGE_DIR="$1"
WATERMARK="$2"

# Verifica se o diretório existe
if [ ! -d "$IMAGE_DIR" ]; then
  echo "O diretório $IMAGE_DIR não existe."
  exit 1
fi

# Verifica se o arquivo da marca d'água existe
if [ ! -f "$WATERMARK" ]; then
  echo "O arquivo da marca d'água $WATERMARK não existe."
  exit 1
fi

# Cria a pasta de saída
OUTPUT_DIR="${IMAGE_DIR}/watermarks"
mkdir -p "$OUTPUT_DIR"

# Processa as imagens
for IMAGE in "$IMAGE_DIR"/*.{jpg,jpeg,png,webp}; do
  # Verifica se é um arquivo
  if [ ! -f "$IMAGE" ]; then
    continue
  fi

  # Nome do arquivo de saída
  OUTPUT_FILE="$OUTPUT_DIR/$(basename "$IMAGE")"

  # Adiciona a marca d'água
  composite -gravity south -dissolve 30% "$WATERMARK" "$IMAGE" "$OUTPUT_FILE"
  echo "Imagem processada: $OUTPUT_FILE"
done

echo "Processamento concluído! As imagens com marca d'água estão em: $OUTPUT_DIR"
