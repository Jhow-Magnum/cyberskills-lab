#!/bin/bash

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

LABS=(
    "linux-basic"
    "crypto"
    "web-security"
    "network"
    "code-review"
    "pentest"
    "desafio-final"
)

# Construir todas as imagens em paralelo
echo "🏗️  Construindo imagens Docker em paralelo..."
echo "   (isso pode levar alguns minutos na primeira vez)"
echo ""

BUILD_START=$(date +%s)
declare -A PIDS

for lab_id in "${LABS[@]}"; do
    docker build -t cyberskills-lab/$lab_id scenarios/$lab_id/ \
        > /tmp/build-$lab_id.log 2>&1 &
    PIDS[$lab_id]=$!
    echo "   🔄 $lab_id — iniciado (PID ${PIDS[$lab_id]})"
done

echo ""
echo "   Aguardando conclusão..."
echo ""

SUCCESS=0
FAILED=0
FAILED_LABS=()

for lab_id in "${LABS[@]}"; do
    if wait ${PIDS[$lab_id]}; then
        echo "   ✅ $lab_id"
        SUCCESS=$((SUCCESS + 1))
    else
        echo "   ❌ $lab_id (ver /tmp/build-$lab_id.log)"
        FAILED=$((FAILED + 1))
        FAILED_LABS+=("$lab_id")
    fi
done

BUILD_END=$(date +%s)
BUILD_TIME=$((BUILD_END - BUILD_START))
BUILD_MIN=$((BUILD_TIME / 60))
BUILD_SEC=$((BUILD_TIME % 60))

echo ""
echo "   📊 $SUCCESS construídos com sucesso, $FAILED falhas — tempo: ${BUILD_MIN}m${BUILD_SEC}s"

if [ ${#FAILED_LABS[@]} -gt 0 ]; then
    echo ""
    echo "   ⚠️  Labs com falha: ${FAILED_LABS[*]}"
    echo "   Execute para ver o erro: cat /tmp/build-<lab>.log"
fi
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
    
    # Instalar serviço systemd para auto-start
    echo "🔧 Configurando auto-start..."
    mkdir -p ~/.config/systemd/user/
    cp cyberskills-lab.service ~/.config/systemd/user/
    systemctl --user daemon-reload
    systemctl --user enable cyberskills-lab.service 2>/dev/null
    systemctl --user start cyberskills-lab.service 2>/dev/null
    echo "✅ Auto-start configurado (iniciará automaticamente no boot)"
    echo ""
    
    sleep 2
    xdg-open http://localhost:5000 2>/dev/null || open http://localhost:5000 2>/dev/null || echo "🌐 Abra manualmente: http://localhost:5000"
else
    echo "❌ Erro ao iniciar. Execute manualmente: bash start.sh"
fi
