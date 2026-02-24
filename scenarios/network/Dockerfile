FROM debian:12-slim

LABEL maintainer="CTF SENAI" description="Cenário Network Security - 3 Desafios"

# Instalar ferramentas de análise de rede
RUN apt-get update && apt-get install -y --no-install-recommends \
    openssh-server nmap netcat-openbsd iproute2 iputils-ping file \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# SSH config
RUN mkdir -p /var/run/sshd && echo 'root:root' | chpasswd \
    && sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# Criar usuário padrão para terminal
RUN useradd -m -s /bin/bash user && echo 'user:user' | chpasswd

# Criar desafios
RUN mkdir -p /root/network \
    && echo "172.18.0.2" > /root/network/ip_flag.txt \
    && echo "5" > /root/network/ports_flag.txt \
    && echo "22" > /root/network/ssh_port_flag.txt

# Serviços fake
RUN printf '#!/bin/bash\nnc -l -p 8080 &\nnc -l -p 9000 &\nnc -l -p 9001 &\n' > /start-services.sh && chmod +x /start-services.sh

# Criar README educativo estilo Bandit
RUN printf '=== CYBERSKILLS LAB - NETWORK ANALYSIS ===\n\nBem-vindo aos desafios de Análise de Rede!\nVocê está logado como '\''user'\''. Explore a rede.\n\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n\n3 DESAFIOS DE ANÁLISE DE REDE\n\nComandos úteis:\n• ip addr\n• ip a\n• hostname -I\n• ifconfig\n• netstat -tuln\n• netstat -tuln | grep LISTEN\n• ss -tuln\n• ss -tuln | wc -l\n• nmap localhost\n• nmap -p- localhost\n• ps aux\n• ps aux | grep ssh\n\nDicas gerais:\n1. Serviços de rede escutam em portas específicas\n2. SSH geralmente usa porta 22\n3. HTTP usa porta 80, HTTPS usa 443\n4. Portas LISTEN indicam serviços ativos\n5. Containers têm IPs internos\n6. Contar linhas ajuda a quantificar resultados\n\nRecursos:\n• Comandos de rede: ip, netstat, ss, nmap\n• Processos: ps, grep\n• Arquivos: /root/network\n\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n\n💡 Usando Google/IA:\n\n✅ Pergunte: "Como ver portas abertas no Linux?"\n✅ Pergunte: "Diferença entre netstat e ss?"\n✅ Pergunte: "Como descobrir IP do container?"\n\n❌ Não peça soluções diretas!\n\nAPRENDA networking, não apenas resolva!\n\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n\nLembre-se: A melhor forma de aprender é tentando sozinho primeiro!\nUse as dicas apenas se estiver realmente travado.\n\nBoa sorte, hacker!\n' > /home/user/README.txt \
    && chown user:user /home/user/README.txt

# Script de inicialização
RUN printf '#!/bin/bash\n/start-services.sh\n/usr/sbin/sshd -D\n' > /start.sh && chmod +x /start.sh

EXPOSE 22
CMD ["/start.sh"]
