#!/bin/bash

echo "╔══════════════════════════════════════════════════════════╗"
echo "║     🏗️  Construindo Imagens CTF Platform                ║"
echo "╚══════════════════════════════════════════════════════════╝"
echo ""

SCENARIOS=("linux-basic" "web-security" "crypto" "pentest" "network" "code-review")
SUCCESS=0
FAILED=0

for scenario in "${SCENARIOS[@]}"; do
    echo "📦 Construindo: $scenario"
    
    if [ -d "scenarios/$scenario" ]; then
        cd "scenarios/$scenario"
        
        if docker build -t "cyberskills-lab/$scenario:latest" . > /dev/null 2>&1; then
            echo "✅ $scenario construído com sucesso!"
            ((SUCCESS++))
        else
            echo "❌ Erro ao construir $scenario"
            ((FAILED++))
        fi
        
        cd ../..
        echo ""
    else
        echo "⚠️  Diretório scenarios/$scenario não encontrado"
        ((FAILED++))
        echo ""
    fi
done

echo "╔══════════════════════════════════════════════════════════╗"
echo "║     📊 RESUMO                                            ║"
echo "╚══════════════════════════════════════════════════════════╝"
echo "✅ Sucesso: $SUCCESS"
echo "❌ Falhas: $FAILED"
echo ""
echo "Para listar as imagens:"
echo "  docker images | grep cyberskills-lab"
