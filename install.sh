#!/bin/bash

# CYBERSKILLS LAB - Instalação Automática

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

# Instalar Python e dependências
echo "📦 Instalando dependências Python..."
pip3 install Flask flask-cors flask-sock pyyaml docker --break-system-packages --quiet 2>/dev/null || pip3 install Flask flask-cors flask-sock pyyaml docker --quiet

# Construir imagem de teste
echo "🏭  Construindo imagem de teste..."
cd scenarios/linux-basic && docker build -t ctf-senai/linux-basic:latest . > /dev/null 2>&1
cd ../..

echo ""
echo "╔══════════════════════════════════════════════════════════╗"
echo "║     ✅ INSTALAÇÃO COMPLETA!                              ║"
echo "╚══════════════════════════════════════════════════════════╝"
echo ""
echo "🚀 Para iniciar:"
echo "   bash start.sh"
echo ""
echo "📡 Acesse: http://localhost:5000"
echo ""
