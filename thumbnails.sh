#!/bin/bash

# Verifica se foram passados dois parâmetros
if [ "$#" -ne 2 ]; then
  echo "Uso: $0 <caminho_das_imagens> <largura>x<altura>"
  exit 1
fi

# Caminho das imagens e tamanho desejado
IMAGE_DIR="$1"
SIZE="$2"

# Verifica se o diretório existe
if [ ! -d "$IMAGE_DIR" ]; then
  echo "O diretório $IMAGE_DIR não existe."
  exit 1
fi

# Cria a pasta de saída
THUMBNAIL_DIR="${IMAGE_DIR}/thumbnails"
mkdir -p "$THUMBNAIL_DIR"

# Processa as imagens
for IMAGE in "$IMAGE_DIR"/*.{jpg,jpeg,png,webp}; do
  # Verifica se é um arquivo
  if [ ! -f "$IMAGE" ]; then
    continue
  fi

  # Nome do arquivo de saída
  THUMBNAIL_FILE="$THUMBNAIL_DIR/$(basename "$IMAGE")"

  # Gera o thumbnail proporcional
  magick "$IMAGE" -resize "$SIZE" "$THUMBNAIL_FILE"

  echo "Thumbnail gerado: $THUMBNAIL_FILE"
done

echo "Processamento concluído! Os thumbnails estão em: $THUMBNAIL_DIR"