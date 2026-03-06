FROM debian:12-slim

LABEL maintainer="CTF SENAI" description="Cenário Linux Básico - 14 Desafios"

# Instalar ferramentas
RUN apt-get update && apt-get install -y --no-install-recommends \
    openssh-server bash coreutils grep sed gawk findutils less vim procps sudo cron file netcat-openbsd binutils \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# SSH config
RUN mkdir -p /var/run/sshd && echo 'root:root' | chpasswd \
    && sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# Desafio 2: Pasta com flag invertida
RUN mkdir -p '/root/data' \
    && echo '4tSap' > '/root/data/secret.txt'

# Desafio 3: Script oculto SEM permissão de execução
RUN printf '#!/bin/bash\necho "flag{h1dd3n_scr1pt}"\n' > /root/.flag_script.sh \
    && chmod 644 /root/.flag_script.sh

# Desafio 4: Histórico com comandos misturados
RUN mkdir -p /root && cat > /root/.bash_history << 'EOF'
ls -la
cd /tmp
whoami
cat /etc/passwd
find / -name "*.conf"
grep -r "password" /etc
ps aux
netstat -tuln
flag{h1st0ry_m4tt3rs}
cat /var/log/syslog
df -h
free -m
top
uname -a
EOF

# Desafio 6: Criar EXATAMENTE 5 arquivos ocultos
# .bash_history + .flag_script.sh + .bashrc + .profile + .flag_hidden = 5
RUN touch /root/.flag_hidden

# Desafio 7: EXATAMENTE 3 binários SUID (remover SUID dos outros)
RUN chmod u-s /usr/bin/* 2>/dev/null || true \
    && chmod 4755 /usr/bin/find /usr/bin/chown /usr/bin/chmod

# Desafio 8: Cron job
RUN mkdir -p /etc/cron.d \
    && echo "# CTF Cron Job" > /etc/cron.d/ctf-cron \
    && echo "# flag{cr0n_m4st3r}" >> /etc/cron.d/ctf-cron \
    && echo "*/5 * * * * root echo 'Cron executado' >> /tmp/cron.log" >> /etc/cron.d/ctf-cron \
    && chmod 644 /etc/cron.d/ctf-cron

# Desafio 9: ACL
RUN mkdir -p /opt/secure \
    && groupadd ctfgroup \
    && usermod -aG ctfgroup root \
    && echo "flag{acl_m4st3r}" > /opt/secure/secret.txt \
    && chgrp ctfgroup /opt/secure/secret.txt \
    && chmod 640 /opt/secure/secret.txt

# Desafio 10: PATH hijacking
RUN printf '#!/bin/bash\nls\n' > /usr/local/bin/check && chmod +x /usr/local/bin/check

# Desafio 11: Variável de ambiente
RUN echo 'export FLAG_ENV="flag{3nv_s3cr3t}"' >> /root/.bashrc

# Desafio 12: Processo temporário
RUN printf '#!/bin/bash\nwhile true; do echo "flag{t3mp_hunt3r}" > /tmp/.flag_temp_$$; sleep 30; rm -f /tmp/.flag_temp_*; sleep 30; done\n' > /usr/local/bin/temp_generator.sh \
    && chmod +x /usr/local/bin/temp_generator.sh

# Desafio 13: Socket Unix
RUN printf '#!/bin/bash\nwhile true; do echo "flag{s0ck3t_m4g1c}" | nc -l -U /var/run/ctf.sock; done\n' > /usr/local/bin/socket_server.sh \
    && chmod +x /usr/local/bin/socket_server.sh

# Desafio 14: Binário com strings
RUN mkdir -p /opt/mystery \
    && printf 'ELF_HEADER\nflag{b1n_r3v3rs3d}\nOTHER_DATA\n' > /opt/mystery/binary \
    && chmod +x /opt/mystery/binary

# README
RUN cat > /root/README << 'EOF'
=== CYBERSKILLS LAB - LINUX BASICO ===

14 desafios de comandos Linux

Comandos uteis:
- whoami, pwd, ls, ls -la
- cd, cat, rev
- find, grep
- ps, env, history
- chmod, bash
- netstat, nc
- strings

Explore: /root, /etc, /tmp, /opt, /var

Boa sorte!
EOF

# Script de inicialização
RUN printf '#!/bin/bash\n/usr/local/bin/temp_generator.sh &\n/usr/local/bin/socket_server.sh &\n/usr/sbin/sshd -D\n' > /usr/local/bin/start.sh \
    && chmod +x /usr/local/bin/start.sh

WORKDIR /root
EXPOSE 22
CMD ["/usr/local/bin/start.sh"]
