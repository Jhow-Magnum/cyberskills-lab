FROM debian:12-slim

LABEL maintainer="CTF SENAI"
LABEL description="Cenário Network Security - 3 Desafios"

# Instalar ferramentas de análise de rede
RUN apt-get update && apt-get install -y \
    openssh-server \
    tcpdump \
    nmap \
    netcat-openbsd \
    iproute2 \
    dnsutils \
    tshark \
    iputils-ping \
    file \
    && rm -rf /var/lib/apt/lists/*

# Configurar SSH
RUN mkdir -p /var/run/sshd
RUN echo 'root:root' | chpasswd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# ==================== DESAFIO 1: IP do Container ====================
# Flag: 172.18.0.2 (ou o IP que for atribuído)
RUN mkdir -p /root/network
RUN echo "172.18.0.2" > /root/network/ip_flag.txt
RUN echo "=== DESAFIO 1: IP do Container ===" > /root/README.txt
RUN echo "Descubra o IP interno do container." >> /root/README.txt
RUN echo "Dica: hostname -I" >> /root/README.txt
RUN echo "" >> /root/README.txt

# ==================== DESAFIO 2: Portas Abertas ====================
# Flag: 5
RUN echo "5" > /root/network/ports_flag.txt
RUN echo "=== DESAFIO 2: Portas Abertas ===" >> /root/README.txt
RUN echo "Liste as portas TCP em LISTEN. Quantas portas estão abertas?" >> /root/README.txt
RUN echo "Dica: netstat -tuln | grep LISTEN | wc -l" >> /root/README.txt
RUN echo "" >> /root/README.txt

# ==================== DESAFIO 3: Porta SSH ====================
# Flag: 22
RUN echo "22" > /root/network/ssh_port_flag.txt
RUN echo "=== DESAFIO 3: Porta SSH ===" >> /root/README.txt
RUN echo "Confirme qual porta o SSH está escutando internamente." >> /root/README.txt
RUN echo "Dica: netstat -tuln | grep :22" >> /root/README.txt
RUN echo "" >> /root/README.txt

# Criar alguns serviços fake para o desafio de portas
RUN echo '#!/bin/bash' > /start-services.sh
RUN echo 'nc -l -p 8080 &' >> /start-services.sh
RUN echo 'nc -l -p 9000 &' >> /start-services.sh
RUN echo 'nc -l -p 9001 &' >> /start-services.sh
RUN chmod +x /start-services.sh

# Banner
RUN echo '#!/bin/bash' > /etc/profile.d/welcome.sh
RUN echo 'clear' >> /etc/profile.d/welcome.sh
RUN echo 'echo "╔══════════════════════════════════════════════════════════╗"' >> /etc/profile.d/welcome.sh
RUN echo 'echo "║     🌐 CTF SENAI - Network Security                     ║"' >> /etc/profile.d/welcome.sh
RUN echo 'echo "╚══════════════════════════════════════════════════════════╝"' >> /etc/profile.d/welcome.sh
RUN echo 'echo ""' >> /etc/profile.d/welcome.sh
RUN echo 'echo "📋 Desafios: 3 flags para capturar"' >> /etc/profile.d/welcome.sh
RUN echo 'echo "📖 Leia: cat /root/README.txt"' >> /etc/profile.d/welcome.sh
RUN echo 'echo ""' >> /etc/profile.d/welcome.sh
RUN chmod +x /etc/profile.d/welcome.sh

# Script de inicialização
RUN echo '#!/bin/bash' > /start.sh
RUN echo '/start-services.sh' >> /start.sh
RUN echo '/usr/sbin/sshd -D' >> /start.sh
RUN chmod +x /start.sh

EXPOSE 22

CMD ["/start.sh"]
