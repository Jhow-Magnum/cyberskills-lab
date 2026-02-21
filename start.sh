#!/bin/bash

# CYBERSKILLS LAB - Start
# Inicia API e abre navegador automaticamente

echo "🚀 Iniciando CYBERSKILLS LAB..."

# Matar processos anteriores
pkill -f ctf-simple.py 2>/dev/null

# Iniciar API em background
nohup python3 ctf-simple.py > /tmp/ctf-api.log 2>&1 &
API_PID=$!

# Aguardar API iniciar
sleep 3

# Verificar se API está rodando
if curl -s http://localhost:5000/ > /dev/null; then
    echo "✅ API iniciada (PID: $API_PID)"
    echo "📡 Acesse: http://localhost:5000"
    echo ""
    echo "Para parar: bash stop.sh"
    
    # Abrir navegador automaticamente
    if command -v xdg-open &> /dev/null; then
        xdg-open http://localhost:5000 2>/dev/null &
    elif command -v firefox &> /dev/null; then
        firefox http://localhost:5000 2>/dev/null &
    fi
else
    echo "❌ Erro ao iniciar API"
    cat /tmp/ctf-api.log
    exit 1
fi
