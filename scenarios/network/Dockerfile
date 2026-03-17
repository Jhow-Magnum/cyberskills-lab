FROM debian:12-slim

LABEL maintainer="Jhow-Magnum" description="Cenário Network Security - 3 Desafios"

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

# Script de inicialização
RUN printf '#!/bin/bash\n/start-services.sh\n/usr/sbin/sshd -D\n' > /usr/local/bin/start.sh && chmod +x /usr/local/bin/start.sh

# Limpar historico de comandos
RUN rm -f /root/.bash_history /home/user/.bash_history 2>/dev/null || true

WORKDIR /home/user
EXPOSE 22
CMD ["/usr/local/bin/start.sh"]
