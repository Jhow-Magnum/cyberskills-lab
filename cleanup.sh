#!/bin/bash

echo "🧹 Limpando containers CYBERSKILLS LAB..."

# Contar containers
CONTAINERS=$(docker ps -a | grep cyberskills | awk '{print $1}')

if [ -z "$CONTAINERS" ]; then
    echo "✅ Nenhum container encontrado"
    exit 0
fi

# Remover containers
echo "$CONTAINERS" | xargs docker rm -f

echo "✅ Limpeza concluída"
