#!/bin/bash

# Nome do arquivo de log
LOG_FILE="/var/log/deploy/beta.log"

# Variável para o nome da imagem
IMAGE="beta"
TAG="$(date +"%y%m%d_%H%M%S")"
IMAGE_NAME="$IMAGE:$TAG"

# Função para verificar o status de um comando e registrar em log
function check_status() {
    if [ $? -ne 0 ]; then
        echo "$(date +"%Y-%m-%d %H:%M:%S") - Erro ao executar o comando: $1" >> "$LOG_FILE"
        echo "Detalhes do erro: ${!}" >> "$LOG_FILE"
        exit 1
    fi
}

# Construir a imagem
docker build -t "$IMAGE_NAME" .
check_status "docker build"

# Alterando .env
echo TAG="$IMAGE_NAME" > .env


## Executar o novo container

echo executando container
docker compose up -d

check_status "docker compose"

sleep 1
docker ps


echo "$(date +"%Y-%m-%d %H:%M:%S") - Script executado com sucesso! - Usando a seguinte: $IMAGE_NAME" >> "$LOG_FILE"
