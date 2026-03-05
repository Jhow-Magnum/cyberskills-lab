FROM debian:12-slim

LABEL maintainer="CyberSkills Lab" description="Cenário Linux Básico - 14 Desafios"

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
RUN echo "echo 'Flag do histórico: h1st0ry_m4tt3rs'" >> /root/.bash_history

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

# Desafio 11: Variável de ambiente + Mostrar README ao logar
RUN echo 'export FLAG_ENV=3nv_s3cr3t' >> /root/.bashrc && \
    echo '' >> /root/.bashrc && \
    echo '[ -f /root/README ] && cat /root/README' >> /root/.bashrc && \
    echo '' >> /root/.bashrc

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

# README - VISIVEL NO /root (PT-BR)
RUN printf '=== CYBERSKILLS LAB - LINUX BASICO ===\n\nBem-vindo aos desafios de Linux!\nVoce esta logado como root. Explore o sistema de arquivos.\n\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n\n14 DESAFIOS DE COMANDOS LINUX\n\nComandos uteis:\n• whoami\n• ls, ls -la, ls -R\n• cd <diretorio>\n• cat <arquivo>\n• rev <arquivo>\n• find / -name <arquivo>\n• find / -type f -perm -4000\n• grep <texto> <arquivo>\n• grep -r "texto" /root\n• history\n• cat ~/.bash_history\n• ps aux\n• env\n• cat /etc/cron.d/*\n• nc -U /var/run/ctf.sock\n• strings <binario>\n\nDicas gerais:\n1. Arquivos ocultos comecam com ponto (.)\n2. Use TAB para autocompletar comandos\n3. Explore diretorios: /root, /etc, /tmp, /opt, /var\n4. Scripts executaveis tem permissao +x\n5. Historico de comandos guarda acoes anteriores\n6. Processos tem PIDs unicos\n7. SUID permite executar como outro usuario\n8. Cron jobs sao tarefas agendadas\n\nRecursos:\n• Diretorios: /root, /etc, /tmp, /opt, /var\n• Arquivos ocultos: comecam com .\n• Binarios SUID: find / -type f -perm -4000\n\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n\nUsando Google/IA como aliado:\n\nEsta travado? Tudo bem usar Google ou IA (ChatGPT, Claude, etc), MAS:\n\nFACA:\n  • Pergunte "Como listar arquivos ocultos no Linux?"\n  • Pergunte "O que faz o comando find?"\n  • Pergunte "Como inverter texto no Linux?"\n  • Use para APRENDER os conceitos e comandos\n\nNAO FACA:\n  • Copiar e colar comandos prontos sem entender\n  • Pedir "resolva o desafio X para mim"\n  • Pular o aprendizado so para pegar a flag\n\nO objetivo e APRENDER, nao apenas completar!\nEntenda cada comando que voce executa.\n\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n\nLembre-se: A melhor forma de aprender e tentando sozinho primeiro!\nUse as dicas apenas se estiver realmente travado.\n\nBoa sorte, hacker!\n' > /root/README && chmod 644 /root/README

# README em Ingles
RUN echo '=== CYBERSKILLS LAB - LINUX BASICS ===' > /root/README-EN && \
    echo '' >> /root/README-EN && \
    echo 'Welcome to Linux challenges!' >> /root/README-EN && \
    echo 'You are logged in as root. Explore the file system.' >> /root/README-EN && \
    echo '' >> /root/README-EN && \
    echo '================================================================' >> /root/README-EN && \
    echo '' >> /root/README-EN && \
    echo '14 LINUX COMMAND CHALLENGES' >> /root/README-EN && \
    echo '' >> /root/README-EN && \
    echo 'Useful commands:' >> /root/README-EN && \
    echo '- whoami' >> /root/README-EN && \
    echo '- ls, ls -la, ls -R' >> /root/README-EN && \
    echo '- cd <directory>' >> /root/README-EN && \
    echo '- cat <file>' >> /root/README-EN && \
    echo '- rev <file>' >> /root/README-EN && \
    echo '- find / -name <file>' >> /root/README-EN && \
    echo '- find / -type f -perm -4000' >> /root/README-EN && \
    echo '- grep <text> <file>' >> /root/README-EN && \
    echo '- grep -r "text" /root' >> /root/README-EN && \
    echo '- history' >> /root/README-EN && \
    echo '- cat ~/.bash_history' >> /root/README-EN && \
    echo '- ps aux' >> /root/README-EN && \
    echo '- env' >> /root/README-EN && \
    echo '- cat /etc/cron.d/*' >> /root/README-EN && \
    echo '- nc -U /var/run/ctf.sock' >> /root/README-EN && \
    echo '- strings <binary>' >> /root/README-EN && \
    echo '' >> /root/README-EN && \
    echo 'General tips:' >> /root/README-EN && \
    echo '1. Hidden files start with dot (.)' >> /root/README-EN && \
    echo '2. Use TAB to autocomplete commands' >> /root/README-EN && \
    echo '3. Explore directories: /root, /etc, /tmp, /opt, /var' >> /root/README-EN && \
    echo '4. Executable scripts have +x permission' >> /root/README-EN && \
    echo '5. Command history stores previous actions' >> /root/README-EN && \
    echo '6. Processes have unique PIDs' >> /root/README-EN && \
    echo '7. SUID allows execution as another user' >> /root/README-EN && \
    echo '8. Cron jobs are scheduled tasks' >> /root/README-EN && \
    echo '' >> /root/README-EN && \
    echo '================================================================' >> /root/README-EN && \
    echo '' >> /root/README-EN && \
    echo 'Using Google/AI:' >> /root/README-EN && \
    echo '' >> /root/README-EN && \
    echo 'Ask: "How to list hidden files in Linux?"' >> /root/README-EN && \
    echo 'Ask: "What does the find command do?"' >> /root/README-EN && \
    echo 'Ask: "How to reverse text in Linux?"' >> /root/README-EN && \
    echo '' >> /root/README-EN && \
    echo 'Do NOT ask: "Give me the answer to challenge X"' >> /root/README-EN && \
    echo '' >> /root/README-EN && \
    echo 'LEARN the commands, do not just copy!' >> /root/README-EN && \
    echo '' >> /root/README-EN && \
    echo '================================================================' >> /root/README-EN && \
    echo '' >> /root/README-EN && \
    echo 'Remember: The best way to learn is by trying on your own first!' >> /root/README-EN && \
    echo 'Use hints only if you are really stuck.' >> /root/README-EN && \
    echo '' >> /root/README-EN && \
    echo 'Good luck, hacker!' >> /root/README-EN && \
    chmod 644 /root/README-EN

# Script de inicialização
RUN printf '#!/bin/bash\n/usr/local/bin/temp_generator.sh\n/usr/local/bin/socket_server.sh\n/usr/sbin/sshd -D\n' > /usr/local/bin/start.sh \
    && chmod +x /usr/local/bin/start.sh

# Limpar historico de comandos
RUN rm -f /root/.bash_history /home/user/.bash_history 2>/dev/null || true

WORKDIR /root
EXPOSE 22
CMD ["/usr/local/bin/start.sh"]
