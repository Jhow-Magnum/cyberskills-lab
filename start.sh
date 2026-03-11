#!/bin/bash

echo "🚀 Iniciando CYBERSKILLS LAB..."
echo ""

# Verificar se já está rodando via systemd
if systemctl --user is-active --quiet cyberskills-lab.service 2>/dev/null; then
    echo "✅ Plataforma já está ativa (systemd)"
    echo "📡 Acesse: http://localhost:5000"
    echo ""
    xdg-open http://localhost:5000 2>/dev/null || open http://localhost:5000 2>/dev/null
    exit 0
fi

# Matar processos anteriores
pkill -f ctf-simple.py 2>/dev/null

# Tentar iniciar via systemd
if systemctl --user start cyberskills-lab.service 2>/dev/null; then
    echo "✅ Plataforma iniciada via systemd"
    sleep 2
else
    # Fallback: iniciar manualmente
    nohup python3 ctf-simple.py > /tmp/ctf-api.log 2>&1 &
    echo "✅ Plataforma iniciada manualmente"
    sleep 2
fi

echo "📡 Acesse: http://localhost:5000"
echo ""
echo "Para parar: bash stop.sh"
echo ""

# Abrir navegador automaticamente
xdg-open http://localhost:5000 2>/dev/null || open http://localhost:5000 2>/dev/null
