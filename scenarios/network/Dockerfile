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

# Criar desafios dinâmicos
RUN mkdir -p /opt/network \
    && printf '#!/bin/bash\necho "Desafio 1: Descubra o IP do container"\necho "Use: ip addr, hostname -I ou ifconfig"\necho ""\necho "Sua resposta (IP):"\nread answer\nmy_ip=$(hostname -I | awk '\''{print $1}'\'' | tr -d '\'' \n'\'' | tr -d '\''\r'\'' | xargs)\nif [ "$answer" = "$my_ip" ]; then\n  echo "Correto! Flag: N3TW0RK_1P"\nelse\n  echo "Incorreto. Tente novamente."\nfi\n' > /opt/network/challenge1.sh && chmod +x /opt/network/challenge1.sh \
    && printf '#!/bin/bash\necho "Desafio 2: Conte portas TCP em LISTEN"\necho "Use: netstat -tuln | grep LISTEN | wc -l"\necho ""\necho "Sua resposta (número):"\nread answer\nports=$(netstat -tuln 2>/dev/null | grep LISTEN | wc -l)\nif [ "$answer" = "$ports" ]; then\n  echo "Correto! Flag: P0RT_C0UNT"\nelse\n  echo "Incorreto. Resposta: $ports"\nfi\n' > /opt/network/challenge2.sh && chmod +x /opt/network/challenge2.sh \
    && printf '#!/bin/bash\necho "Desafio 3: Porta do SSH"\necho "Use: netstat -tuln | grep ssh ou ss -tuln"\necho ""\necho "Sua resposta (porta):"\nread answer\nif [ "$answer" = "22" ]; then\n  echo "Correto! Flag: SSH_P0RT_22"\nelse\n  echo "Incorreto. Verifique com: netstat -tuln | grep :22"\nfi\n' > /opt/network/challenge3.sh && chmod +x /opt/network/challenge3.sh

# Serviços fake
RUN printf '#!/bin/bash\nnc -l -p 8080 &\nnc -l -p 9000 &\nnc -l -p 9001 &\n' > /start-services.sh && chmod +x /start-services.sh

# Criar README educativo estilo Bandit
RUN printf '=== CYBERSKILLS LAB - NETWORK ANALYSIS ===\n\nBem-vindo aos desafios de Análise de Rede!\nVocê está logado como '\''user'\''. Explore a rede.\n\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n\n3 DESAFIOS DE ANÁLISE DE REDE\n\nComandos úteis:\n• /opt/network/challenge1.sh\n• /opt/network/challenge2.sh\n• /opt/network/challenge3.sh\n• ip addr\n• ip a\n• hostname -I\n• ifconfig\n• netstat -tuln\n• netstat -tuln | grep LISTEN\n• ss -tuln\n• ss -tuln | wc -l\n• nmap localhost\n• nmap -p- localhost\n• ps aux\n• ps aux | grep ssh\n\nDicas gerais:\n1. Serviços de rede escutam em portas específicas\n2. SSH geralmente usa porta 22\n3. HTTP usa porta 80, HTTPS usa 443\n4. Portas LISTEN indicam serviços ativos\n5. Containers têm IPs internos\n6. Contar linhas ajuda a quantificar resultados\n\nRecursos:\n• Comandos de rede: ip, netstat, ss, nmap\n• Processos: ps, grep\n• Arquivos: /root/network\n\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n\n💡 Usando Google/IA:\n\n✅ Pergunte: "Como ver portas abertas no Linux?"\n✅ Pergunte: "Diferença entre netstat e ss?"\n✅ Pergunte: "Como descobrir IP do container?"\n\n❌ Não peça soluções diretas!\n\nAPRENDA networking, não apenas resolva!\n\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n\nLembre-se: A melhor forma de aprender é tentando sozinho primeiro!\nUse as dicas apenas se estiver realmente travado.\n\nBoa sorte, hacker!\n' > /home/user/README.txt \
    && chown user:user /home/user/README.txt

# Script de inicialização
RUN printf '#!/bin/bash\n/start-services.sh\n/usr/sbin/sshd -D\n' > /start.sh && chmod +x /start.sh

EXPOSE 22
CMD ["/start.sh"]
