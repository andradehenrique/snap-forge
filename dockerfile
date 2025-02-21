# Usar uma imagem base com ferramentas necessárias
FROM ubuntu:24.04

# Instalar dependências
RUN apt-get update && apt-get install -y \
    imagemagick \
    webp \
    ffmpeg \
    && rm -rf /var/lib/apt/lists/*

# Copiar os scripts para o contêiner
COPY src/watermark.sh /usr/local/bin/watermark.sh
COPY src/convert-to-webp.sh /usr/local/bin/convert-to-webp.sh
COPY src/process-images.sh /usr/local/bin/process-images.sh
COPY src/crop.sh /usr/local/bin/crop.sh
COPY src/video-watermark.sh /usr/local/bin/video-watermark.sh

# Tornar os scripts executáveis
RUN chmod +x /usr/local/bin/watermark.sh
RUN chmod +x /usr/local/bin/convert-to-webp.sh
RUN chmod +x /usr/local/bin/process-images.sh
RUN chmod +x /usr/local/bin/crop.sh
RUN chmod +x /usr/local/bin/video-watermark.sh

# Definir o diretório de trabalho
WORKDIR /workspace

# Definir o usuário e grupo dinamicamente (será sobrescrito ao executar o contêiner)
USER 1000:1000

# Comando padrão (pode ser sobrescrito ao executar o contêiner)
CMD ["bash"]