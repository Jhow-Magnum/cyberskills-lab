FROM debian:12-slim

LABEL maintainer="CTF SENAI" description="Cenário Linux Básico - 14 Desafios"

# Instalar ferramentas minimalistas
RUN apt-get update && apt-get install -y --no-install-recommends \
    openssh-server bash coreutils grep sed gawk findutils less vim procps sudo cron file \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# SSH config
RUN mkdir -p /var/run/sshd && echo 'root:root' | chpasswd \
    && sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# Criar todos os desafios em uma camada
RUN mkdir -p /root/SENAI /root/scripts/1 /root/.hidden /root/linux /etc/cron.d \
    && echo "pa\$t4" > /root/SENAI/flag \
    && echo -e '#!/bin/bash\necho "==================================="\necho "  Script executado com sucesso!"\necho "==================================="\necho ""\necho "Código encontrado: cOdi6o"\necho ""' > /root/scripts/1/script.sh && chmod +x /root/scripts/1/script.sh \
    && echo "echo 'Flag do histórico: h1st0ry_m4tt3rs'" >> /root/.bash_history \
    && echo "H1DD3N_F1L3" > /root/.hidden/.secret_flag \
    && echo "SU1D_B1N4RY" > /root/linux/suid_flag.txt && chmod 4755 /usr/bin/find \
    && echo -e "# CTF Cron Job\n# Flag: cr0n_m4st3r\n*/5 * * * * root echo 'Cron executado' >> /tmp/cron.log" > /etc/cron.d/ctf-cron && chmod 644 /etc/cron.d/ctf-cron

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
