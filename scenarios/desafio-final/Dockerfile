FROM debian:12-slim

LABEL maintainer="CyberSkills Lab" description="Desafio Final - 1 Desafio Especial"

# Instalar apenas o essencial
RUN apt-get update && apt-get install -y --no-install-recommends \
    openssh-server \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# SSH config
RUN mkdir -p /var/run/sshd && echo 'root:root' | chpasswd \
    && sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# Criar README com o desafio
RUN printf '=== CYBERSKILLS LAB - DESAFIO FINAL ===\n\n🏆 PARABÉNS POR COMPLETAR TODOS OS DESAFIOS! 🏆\n\nAgora você enfrenta o DESAFIO FINAL para ultrapassar o primeiro colocado.\n\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n\nDESAFIO:\n\nO primeiro colocado no ranking é: Tryg_Gelt\n\nPara ultrapassá-lo, descubra quem ele realmente é.\n\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n\n💡 DICAS:\n\n1. Pense em Cifras de César...\n2. Tryg usa rotação 16\n3. Gelt usa rotação 23\n4. Combine os resultados com underscore\n\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n\nComandos úteis:\n- echo "Tryg" | tr A-Za-z P-ZA-Op-za-o\n- echo "Gelt" | tr A-Za-z D-ZA-Cd-za-c\n\nTempo limite: 30 minutos\nPontos: 100\n\nBoa sorte, hacker!\n' > /root/README

# Auto-exibir README ao logar
RUN echo '' >> /root/.bashrc && \
    echo '[ -f /root/README ] && cat /root/README' >> /root/.bashrc && \
    echo '' >> /root/.bashrc

# Script de inicialização
RUN printf '#!/bin/bash\n/usr/sbin/sshd -D\n' > /usr/local/bin/start.sh && chmod +x /usr/local/bin/start.sh

# Limpar historico de comandos
RUN rm -f /root/.bash_history /home/user/.bash_history 2>/dev/null || true

WORKDIR /root
EXPOSE 22
CMD ["/usr/local/bin/start.sh"]
