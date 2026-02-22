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
RUN echo -e '#!/bin/bash\nnc -l -p 8080 &\nnc -l -p 9000 &\nnc -l -p 9001 &' > /start-services.sh && chmod +x /start-services.sh

# Script de inicialização
RUN echo -e '#!/bin/bash\n/start-services.sh\n/usr/sbin/sshd -D' > /start.sh && chmod +x /start.sh

EXPOSE 22
CMD ["/start.sh"]
