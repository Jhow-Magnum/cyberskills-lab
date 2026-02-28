#!/bin/bash

echo "🚀 Iniciando CYBERSKILLS LAB..."
echo ""

# Matar processos anteriores
pkill -f ctf-simple.py 2>/dev/null

# Iniciar API em background
nohup python3 ctf-simple.py > /tmp/ctf-api.log 2>&1 &
API_PID=$!

# Spinner
spin() {
    local -a spinner=('⠋' '⠙' '⠹' '⠸' '⠼' '⠴' '⠦' '⠧' '⠇' '⠏')
    local i=0
    while true; do
        printf "\r⚙️  Aguardando inicialização... ${spinner[$i]}"
        i=$(( (i+1) % 10 ))
        sleep 0.1
        
        if curl -s http://localhost:5000/ > /dev/null 2>&1; then
            printf "\r⚙️  Aguardando inicialização... ✓\n"
            break
        fi
    done
}

spin

sleep 0.5

echo ""
echo "✅ Plataforma iniciada"
echo "📡 Acesse: http://localhost:5000"
echo ""
echo "Para parar: bash stop.sh"
echo ""

# Abrir navegador automaticamente
if command -v xdg-open &> /dev/null; then
    xdg-open http://localhost:5000 2>/dev/null &
elif command -v firefox &> /dev/null; then
    firefox http://localhost:5000 2>/dev/null &
fi
