FROM debian:12-slim

LABEL maintainer="CyberSkills Lab" description="Cenário Linux Básico - 14 Desafios"

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

# Criar README educativo
RUN printf '=== CYBERSKILLS LAB - LINUX BÁSICO ===\n\nBem-vindo aos desafios de Linux!\nVocê está logado como '\''root'\'' Explore o sistema de arquivos.\n\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n\n14 DESAFIOS DE COMANDOS LINUX\n\nObjetivo: Dominar navegação, busca e manipulação de arquivos no Linux.\n\nComandos essenciais:\n• ls, ls -la              - Lista arquivos (inclusive ocultos)\n• cd <diretorio>          - Navega entre pastas\n• cat <arquivo>           - Exibe conteúdo de arquivo\n• find / -name <arquivo>  - Busca arquivos no sistema\n• grep <texto> <arquivo>  - Procura texto dentro de arquivos\n• whoami                  - Mostra usuário atual\n• ps aux                  - Lista processos rodando\n\nDicas gerais:\n1. Arquivos ocultos começam com ponto (.)\n2. Use TAB para autocompletar comandos\n3. Explore diretórios: /root, /home, /etc, /tmp\n4. Leia arquivos de configuração e scripts\n\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n\n💡 Usando Google/IA:\n\n✅ Pergunte: "Como listar arquivos ocultos no Linux?"\n✅ Pergunte: "O que faz o comando find?"\n✅ Pergunte: "Como buscar texto dentro de arquivos?"\n\n❌ Não peça: "Me dê a resposta do desafio X"\n\nAPRENDA os comandos, não apenas copie!\n\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n\nComece explorando! Digite: ls -la\n' > /root/README.txt

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
