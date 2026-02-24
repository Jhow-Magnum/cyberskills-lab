FROM debian:12-slim

LABEL maintainer="CTF SENAI" description="Cenário Network Security - 3 Desafios"

# Instalar apenas ferramentas essenciais
RUN apt-get update && apt-get install -y --no-install-recommends \
    openssh-server nmap netcat-openbsd iproute2 iputils-ping file \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# SSH config
RUN mkdir -p /var/run/sshd && echo 'root:root' | chpasswd \
    && sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# Criar desafios
RUN mkdir -p /root/network \
    && echo "172.18.0.2" > /root/network/ip_flag.txt \
    && echo "5" > /root/network/ports_flag.txt \
    && echo "22" > /root/network/ssh_port_flag.txt

# Serviços fake
RUN printf '#!/bin/bash\nnc -l -p 8080 &\nnc -l -p 9000 &\nnc -l -p 9001 &\n' > /start-services.sh && chmod +x /start-services.sh

# Criar README educativo
RUN printf '=== CYBERSKILLS LAB - NETWORK ANALYSIS ===\n\nBem-vindo aos desafios de Análise de Rede!\nVocê está logado como '\''user'\'' Explore a rede.\n\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n\n3 DESAFIOS DE ANÁLISE DE REDE\n\nObjetivo: Identificar serviços, portas e configurações de rede.\n\nComandos essenciais:\n• ip addr                  - Mostra endereços IP\n• hostname -I              - IP do host\n• netstat -tuln            - Portas abertas (TCP/UDP)\n• ss -tuln                 - Alternativa ao netstat\n• nmap localhost           - Scan de portas\n• ps aux                   - Processos rodando\n\nDicas gerais:\n1. Serviços de rede escutam em portas específicas\n2. SSH geralmente usa porta 22\n3. HTTP usa porta 80, HTTPS usa 443\n4. Portas LISTEN indicam serviços ativos\n\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n\n💡 Usando Google/IA:\n\n✅ Pergunte: "Como ver portas abertas no Linux?"\n✅ Pergunte: "Diferença entre netstat e ss?"\n✅ Pergunte: "Como descobrir IP do container?"\n\n❌ Não peça soluções diretas!\n\nAPRENDA networking, não apenas resolva!\n\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n\nComece explorando! Digite: ip addr\n' > /home/user/README.txt \
    && chown user:user /home/user/README.txt

# Script de inicialização
RUN printf '#!/bin/bash\n/start-services.sh\n/usr/sbin/sshd -D\n' > /start.sh && chmod +x /start.sh

EXPOSE 22
CMD ["/start.sh"]
