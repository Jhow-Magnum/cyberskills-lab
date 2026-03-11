#!/bin/bash

echo "🛑 Parando CYBERSKILLS LAB..."

# Parar serviço systemd
if systemctl --user is-active --quiet cyberskills-lab.service 2>/dev/null; then
    systemctl --user stop cyberskills-lab.service
    echo "✅ Serviço systemd parado"
fi

# Parar processos manuais
pkill -f ctf-simple.py

# Parar todos os containers CTF
docker ps -a | grep cyberskills | awk '{print $1}' | xargs -r docker stop
docker ps -a | grep cyberskills | awk '{print $1}' | xargs -r docker rm

echo "✅ Plataforma parada"
