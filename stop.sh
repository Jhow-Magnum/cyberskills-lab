#!/bin/bash

echo "🛑 Parando CYBERSKILLS LAB..."

# Parar API
pkill -f ctf-simple.py

# Parar todos os containers CTF
docker ps -a | grep cyberskills | awk '{print $1}' | xargs -r docker stop
docker ps -a | grep cyberskills | awk '{print $1}' | xargs -r docker rm

echo "✅ Plataforma parada"
