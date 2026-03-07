#!/bin/bash

set -e

echo "╔══════════════════════════════════════════════════════════╗"
echo "║     🎯 CYBERSKILLS LAB - Instalação Automática          ║"
echo "╚══════════════════════════════════════════════════════════╝"
echo ""

# Verificar Docker
echo "🔍 Verificando Docker..."
if ! command -v docker &> /dev/null; then
    echo "❌ Docker não encontrado!"
    echo "📦 Instale com: curl -fsSL https://get.docker.com | sudo bash"
    exit 1
fi
echo "✅ Docker já instalado"
echo ""

# Garantir diretório válido
INSTALL_DIR="$HOME/cyberskills-lab"

# Clonar repositório
echo "📥 Clonando repositório..."
if [ -d "$INSTALL_DIR" ]; then
    echo "⚠️  Diretório já existe, atualizando..."
    cd "$INSTALL_DIR"
    git pull --quiet 2>/dev/null || {
        cd "$HOME"
        rm -rf "$INSTALL_DIR"
        git clone https://github.com/Jhow-Magnum/cyberskills-lab.git "$INSTALL_DIR" --quiet
        cd "$INSTALL_DIR"
    }
else
    git clone https://github.com/Jhow-Magnum/cyberskills-lab.git "$INSTALL_DIR" --quiet
    cd "$INSTALL_DIR"
fi
echo "✅ Repositório clonado"
echo ""

# Instalar Python e dependências
echo "📦 Instalando dependências Python..."
pip3 install Flask flask-cors flask-sock pyyaml docker --break-system-packages --quiet 2>/dev/null || pip3 install Flask flask-cors flask-sock pyyaml docker --quiet
echo "✅ Dependências instaladas"
echo ""

# Construir imagens sequencialmente
echo "🏗️  Construindo imagens Docker..."
echo ""

LABS=(
    "linux-basic"
    "crypto"
    "web-security"
    "network"
    "code-review"
    "pentest"
    "desafio-final"
)

BUILD_SUCCESS=0
BUILD_FAILED=0

for lab_id in "${LABS[@]}"; do
    echo "📦 Construindo: $lab_id..."
    if docker build -t cyberskills-lab/$lab_id scenarios/$lab_id/ > /tmp/build-$lab_id.log 2>&1; then
        echo "✅ $lab_id construído com sucesso"
        BUILD_SUCCESS=$((BUILD_SUCCESS + 1))
    else
        echo "❌ $lab_id falhou (veja /tmp/build-$lab_id.log)"
        BUILD_FAILED=$((BUILD_FAILED + 1))
    fi
    echo ""
done

echo "📊 Resultado: $BUILD_SUCCESS sucesso, $BUILD_FAILED falhas"
echo ""

echo "╔══════════════════════════════════════════════════════════╗"
echo "║     ✅ INSTALAÇÃO COMPLETA!                              ║"
echo "╚══════════════════════════════════════════════════════════╝"
echo ""
echo "🚀 Iniciando plataforma..."
echo ""

# Parar instância anterior se existir
if [ -f /tmp/cyberskills.pid ]; then
    OLD_PID=$(cat /tmp/cyberskills.pid)
    if ps -p $OLD_PID > /dev/null 2>&1; then
        kill $OLD_PID 2>/dev/null
        sleep 1
    fi
fi

nohup python3 ctf-simple.py > /tmp/cyberskills.log 2>&1 &
echo $! > /tmp/cyberskills.pid

sleep 3

if ps -p $(cat /tmp/cyberskills.pid 2>/dev/null) > /dev/null 2>&1; then
    echo "✅ Plataforma iniciada com sucesso!"
    echo ""
    echo "📡 Acesse: http://localhost:5000"
    echo ""
    echo "⚠️  Para parar: bash ~/cyberskills-lab/stop.sh"
    echo ""
    
    sleep 2
    xdg-open http://localhost:5000 2>/dev/null || open http://localhost:5000 2>/dev/null || echo "🌐 Abra manualmente: http://localhost:5000"
else
    echo "❌ Erro ao iniciar. Execute manualmente: bash start.sh"
fi
