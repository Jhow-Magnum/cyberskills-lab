#!/bin/bash

set -e

echo "═══════════════════════════════════════════════════════════"
echo "  CYBERSKILLS LAB - Instalação Automática"
echo "═══════════════════════════════════════════════════════════"
echo ""

# Verificar Docker
echo "[1/4] Verificando Docker..."
if ! command -v docker &> /dev/null; then
    echo "ERRO: Docker não encontrado"
    echo "Instale com: curl -fsSL https://get.docker.com | sudo bash"
    exit 1
fi
echo "OK: Docker instalado"
echo ""

# Garantir diretório válido
INSTALL_DIR="$HOME/cyberskills-lab"

# Clonar repositório
echo "[2/4] Clonando repositório..."
if [ -d "$INSTALL_DIR" ]; then
    echo "Diretório existente, atualizando..."
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
echo "OK: Repositório pronto"
echo ""

# Instalar Python e dependências
echo "[3/4] Instalando dependências Python..."
pip3 install Flask flask-cors flask-sock pyyaml docker --break-system-packages --quiet 2>/dev/null || pip3 install Flask flask-cors flask-sock pyyaml docker --quiet
echo "OK: Dependências instaladas"
echo ""

# Spinner com tempo
spin() {
    local -a spinner=('⠋' '⠙' '⠹' '⠸' '⠼' '⠴' '⠦' '⠧' '⠇' '⠏')
    local i=0
    local pid=$1
    local msg=$2
    local start=$(date +%s)
    while kill -0 $pid 2>/dev/null; do
        local elapsed=$(($(date +%s) - start))
        printf "\r   ${spinner[$i]} $msg (${elapsed}s)"
        i=$(( (i+1) % 10 ))
        sleep 0.1
    done
    local total=$(($(date +%s) - start))
    printf "\rOK: $msg - ${total}s\n"
}

# Construir imagens sequencialmente
echo "[4/4] Construindo imagens Docker..." 
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
    docker build -t cyberskills-lab/$lab_id scenarios/$lab_id/ > /tmp/build-$lab_id.log 2>&1 &
    spin $! "Construindo: $lab_id"
done

echo ""

echo "═══════════════════════════════════════════════════════════"
echo "  INSTALAÇÃO COMPLETA"
echo "═══════════════════════════════════════════════════════════"
echo ""
echo "Iniciando plataforma..."
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
    echo "OK: Plataforma iniciada com sucesso"
    echo ""
    echo "Acesse: http://localhost:5000"
    echo ""
    echo "Para parar: bash ~/cyberskills-lab/stop.sh"
    echo ""
    
    sleep 2
    xdg-open http://localhost:5000 2>/dev/null || open http://localhost:5000 2>/dev/null || echo "Abra manualmente: http://localhost:5000"
else
    echo "ERRO: Falha ao iniciar. Execute manualmente: bash start.sh"
fi
