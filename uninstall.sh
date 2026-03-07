#!/bin/bash

echo "════════════════════════════════════════════════════════════"
echo "  CYBERSKILLS LAB - Desinstalação"
echo "════════════════════════════════════════════════════════════"
echo ""

# Parar plataforma
echo "[1/4] Parando plataforma..."
if [ -f /tmp/cyberskills.pid ]; then
    PID=$(cat /tmp/cyberskills.pid)
    if ps -p $PID > /dev/null 2>&1; then
        kill $PID 2>/dev/null
        echo "OK: Plataforma parada"
    fi
    rm -f /tmp/cyberskills.pid
fi

# Matar processo na porta 5000
PORT_PID=$(lsof -ti:5000 2>/dev/null)
if [ -n "$PORT_PID" ]; then
    kill -9 $PORT_PID 2>/dev/null
    echo "OK: Porta 5000 liberada"
fi
echo ""

# Remover containers
echo "[2/4] Removendo containers..."
CONTAINERS=$(docker ps -a | grep cyberskills | awk '{print $1}')
if [ -n "$CONTAINERS" ]; then
    echo "$CONTAINERS" | xargs docker rm -f 2>/dev/null
    echo "OK: Containers removidos"
else
    echo "OK: Nenhum container encontrado"
fi
echo ""

# Remover imagens
echo "[3/4] Removendo imagens Docker..."
IMAGES=$(docker images 'cyberskills-lab/*' -q)
if [ -n "$IMAGES" ]; then
    echo "$IMAGES" | xargs docker rmi -f 2>/dev/null
    echo "OK: Imagens removidas"
else
    echo "OK: Nenhuma imagem encontrada"
fi
echo ""

# Remover diretório
echo "[4/4] Removendo diretório..."
if [ -d "$HOME/cyberskills-lab" ]; then
    rm -rf "$HOME/cyberskills-lab"
    echo "OK: Diretório removido"
else
    echo "OK: Diretório não encontrado"
fi
echo ""

echo "════════════════════════════════════════════════════════════"
echo "  DESINSTALAÇÃO COMPLETA"
echo "════════════════════════════════════════════════════════════"
