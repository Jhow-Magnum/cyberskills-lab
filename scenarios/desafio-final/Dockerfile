FROM debian:12-slim

LABEL maintainer="CTF SENAI" description="Desafio Final - 1 Desafio Especial"

# Instalar apenas o essencial
RUN apt-get update && apt-get install -y --no-install-recommends \
    openssh-server \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# SSH config
RUN mkdir -p /var/run/sshd && echo 'root:root' | chpasswd \
    && sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# Criar README com o desafio
RUN printf '=== CYBERSKILLS LAB - DESAFIO FINAL ===\n\n🏆 PARABÉNS POR COMPLETAR TODOS OS DESAFIOS! 🏆\n\nAgora você enfrenta o DESAFIO FINAL para ultrapassar o primeiro colocado.\n\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n\nDESAFIO:\n\nO primeiro colocado no ranking é: Tryg_Gelt\n\nPara ultrapassá-lo, descubra quem ele realmente é.\n\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n\n💡 DICA ÚNICA:\n\nPense em Cifras....\n\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n\nTempo limite: 30 minutos\nPontos: 100\n\nBoa sorte, hacker!\n' > /root/README.txt

# Script de inicialização
RUN printf '#!/bin/bash\n/usr/sbin/sshd -D\n' > /start.sh && chmod +x /start.sh

EXPOSE 22
CMD ["/start.sh"]
