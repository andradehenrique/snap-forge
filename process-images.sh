#!/bin/bash

# Verifica se foram passados três parâmetros
if [ "$#" -ne 3 ]; then
  echo "Uso: $0 <caminho_das_imagens> <caminho_da_marca_dagua> <largura>x<altura>"
  exit 1
fi

# Caminho das imagens, marca d'água e tamanho desejado
IMAGE_DIR="$1"
WATERMARK="$2"
SIZE="$3"

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

# Cria as pastas de saída
OUTPUT_DIR="${IMAGE_DIR}/watermarks"
THUMBNAIL_DIR="${IMAGE_DIR}/thumbnails"
WEBP_DIR="${IMAGE_DIR}/webp"
WEBP_THUMB_DIR="${IMAGE_DIR}/webp_thumbnails"
mkdir -p "$OUTPUT_DIR"
mkdir -p "$THUMBNAIL_DIR"
mkdir -p "$WEBP_DIR"
mkdir -p "$WEBP_THUMB_DIR"

# Passo 1: Adiciona a marca d'água
echo "Adicionando marca d'água..."
for IMAGE in "$IMAGE_DIR"/*.{jpg,jpeg,png,webp}; do
  if [ ! -f "$IMAGE" ]; then
    continue
  fi
  OUTPUT_FILE="$OUTPUT_DIR/$(basename "$IMAGE")"
  magick composite -gravity south -dissolve 30% "$WATERMARK" "$IMAGE" "$OUTPUT_FILE"
  echo "Imagem com marca d'água: $OUTPUT_FILE"
done

# Passo 2: Gera thumbnails
echo "Gerando thumbnails..."
for IMAGE in "$OUTPUT_DIR"/*.{jpg,jpeg,png,webp}; do
  if [ ! -f "$IMAGE" ]; then
    continue
  fi
  THUMBNAIL_FILE="$THUMBNAIL_DIR/$(basename "$IMAGE")"
  magick "$IMAGE" -resize "$SIZE" "$THUMBNAIL_FILE"
  echo "Thumbnail gerado: $THUMBNAIL_FILE"
done

# Passo 3: Converte imagens com marca d'água para WebP
echo "Convertendo imagens com marca d'água para WebP..."
for IMAGE in "$OUTPUT_DIR"/*.{jpg,jpeg,png,webp}; do
  if [ ! -f "$IMAGE" ]; then
    continue
  fi
  cwebp -q 90 "$IMAGE" -o "$WEBP_DIR/$(basename "${IMAGE%.*}").webp"
  echo "Imagem WebP gerada: $WEBP_DIR/$(basename "${IMAGE%.*}").webp"
done

# Passo 4: Converte thumbnails para WebP
echo "Convertendo thumbnails para WebP..."
for IMAGE in "$THUMBNAIL_DIR"/*.{jpg,jpeg,png,webp}; do
  if [ ! -f "$IMAGE" ]; then
    continue
  fi
  cwebp -q 90 "$IMAGE" -o "$WEBP_THUMB_DIR/$(basename "${IMAGE%.*}").webp"
  echo "Thumbnail WebP gerado: $WEBP_THUMB_DIR/$(basename "${IMAGE%.*}").webp"
done

echo "Processamento concluído!"
echo "Imagens com marca d'água: $OUTPUT_DIR"
echo "Thumbnails: $THUMBNAIL_DIR"
echo "Imagens WebP: $WEBP_DIR"
echo "Thumbnails WebP: $WEBP_THUMB_DIR"
