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
else
    echo "✅ Docker já instalado"
fi

# Garantir diretório válido
cd ~

# Clonar repositório
echo "📥 Clonando repositório..."
if [ -d "cyberskills-lab" ]; then
    echo "⚠️  Diretório já existe, removendo..."
    rm -rf cyberskills-lab
fi
git clone https://github.com/Jhow-Magnum/cyberskills-lab.git --quiet
cd cyberskills-lab
echo "✅ Repositório clonado"
echo ""

# Instalar Python e dependências
echo "📦 Instalando dependências Python..."
pip3 install Flask flask-cors flask-sock pyyaml docker --break-system-packages --quiet 2>/dev/null || pip3 install Flask flask-cors flask-sock pyyaml docker --quiet
echo "✅ Dependências instaladas"
echo ""

# Spinner
spin() {
    local -a spinner=('⠋' '⠙' '⠹' '⠸' '⠼' '⠴' '⠦' '⠧' '⠇' '⠏')
    local i=0
    local pid=$1
    while kill -0 $pid 2>/dev/null; do
        printf "\r   ${spinner[$i]} Construindo..."
        i=$(( (i+1) % 10 ))
        sleep 0.1
    done
    printf "\r\033[K"
}

# Construir imagens
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

for lab_id in "${LABS[@]}"; do
    echo "📦 Construindo: $lab_id"
    
    docker build -t cyberskills-lab/$lab_id scenarios/$lab_id/ > /tmp/build-$lab_id.log 2>&1 &
    BUILD_PID=$!
    spin $BUILD_PID
    wait $BUILD_PID
    
    echo "✅ $lab_id construído com sucesso!"
    echo ""
    
    sleep 1
done

echo "╔══════════════════════════════════════════════════════════╗"
echo "║     ✅ INSTALAÇÃO COMPLETA!                              ║"
echo "╚══════════════════════════════════════════════════════════╝"
echo ""
echo "🚀 Iniciando plataforma..."
echo ""

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
else
    echo "❌ Erro ao iniciar. Execute manualmente: bash start.sh"
fi
