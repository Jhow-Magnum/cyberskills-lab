FROM debian:12-slim

LABEL maintainer="CTF SENAI" description="Cenário Linux Básico - 14 Desafios"

# Instalar ferramentas minimalistas
RUN apt-get update && apt-get install -y --no-install-recommends \
    openssh-server bash coreutils grep sed gawk findutils less vim procps sudo cron file netcat-openbsd binutils \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# SSH config
RUN mkdir -p /var/run/sshd && echo 'root:root' | chpasswd \
    && sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# Desafio 2: Pasta CyberSkills Lab com flag invertida (DICA: inverta o valor)
RUN mkdir -p '/root/CyberSkills Lab' \
    && echo '4tSap' > '/root/CyberSkills Lab/flag'

# Desafio 3: Script oculto em /root
RUN printf '#!/bin/bash\necho "h1dd3n_scr1pt"\n' > /root/.secret.sh && chmod +x /root/.secret.sh

# Desafio 4: Flag no histórico
RUN mkdir -p /root && echo "echo 'Flag do histórico: h1st0ry_m4tt3rs'" > /root/.bash_history

# Desafio 6: Criar EXATAMENTE 5 arquivos ocultos em /root
# .secret.sh (desafio 3) + .bash_history (desafio 4) + .bashrc (desafio 11) = 3
# Precisamos de mais 2: .profile (já existe) + 1 arquivo = 5 total
RUN touch /root/.hidden_file

# Desafio 7: SUID binaries (3 binários)
RUN chmod 4755 /usr/bin/find /usr/bin/chown /usr/bin/chmod

# Desafio 8: Cron job com flag
RUN mkdir -p /etc/cron.d \
    && echo -e "# CTF Cron Job\n# Flag: cr0n_m4st3r\n*/5 * * * * root echo 'Cron executado' >> /tmp/cron.log" > /etc/cron.d/ctf-cron \
    && chmod 644 /etc/cron.d/ctf-cron

# Desafio 9: ACL com grupo
RUN mkdir -p /opt/secure \
    && groupadd ctfgroup \
    && usermod -aG ctfgroup root \
    && echo "acl_m4st3r" > /opt/secure/secret.txt \
    && chgrp ctfgroup /opt/secure/secret.txt \
    && chmod 640 /opt/secure/secret.txt

# Desafio 10: PATH hijacking
RUN printf '#!/bin/bash\nls\n' > /usr/local/bin/check && chmod +x /usr/local/bin/check

# Desafio 11: Variável de ambiente
RUN echo 'export FLAG_ENV=3nv_s3cr3t' >> /root/.bashrc

# Desafio 12: Processo temporário
RUN printf '#!/bin/bash\nwhile true; do echo "t3mp_hunt3r" > /tmp/.flag_temp_$$; sleep 30; rm -f /tmp/.flag_temp_*; sleep 30; done &\n' > /usr/local/bin/temp_generator.sh \
    && chmod +x /usr/local/bin/temp_generator.sh

# Desafio 13: Socket Unix
RUN printf '#!/bin/bash\nwhile true; do echo "s0ck3t_m4g1c" | nc -l -U /var/run/ctf.sock; done &\n' > /usr/local/bin/socket_server.sh \
    && chmod +x /usr/local/bin/socket_server.sh

# Desafio 14: Binário com flag
RUN mkdir -p /opt/mystery \
    && printf '\x7fELF\x02\x01\x01\x00b1n_r3v3rs3d\x00\x00\x00' > /opt/mystery/binary \
    && chmod +x /opt/mystery/binary

# Script de inicialização
RUN printf '#!/bin/bash\n/usr/local/bin/temp_generator.sh\n/usr/local/bin/socket_server.sh\n/usr/sbin/sshd -D\n' > /usr/local/bin/start.sh \
    && chmod +x /usr/local/bin/start.sh

# Limpar arquivos temporários (manter .bash_history para desafio 4)
RUN rm -f /tmp/* /var/tmp/* 2>/dev/null || true

WORKDIR /root
EXPOSE 22
CMD ["/usr/local/bin/start.sh"]
