FROM debian:12-slim

# Metadados
LABEL maintainer="CTF SENAI"
LABEL description="Cenário Linux Básico - 8 Desafios"

# Instalar ferramentas Linux básicas (minimalista)
RUN apt-get update && apt-get install -y \
    openssh-server \
    bash \
    coreutils \
    grep \
    sed \
    gawk \
    findutils \
    less \
    vim \
    procps \
    sudo \
    cron \
    file \
    && rm -rf /var/lib/apt/lists/*

# Configurar SSH
RUN mkdir -p /var/run/sshd
RUN echo 'root:root' | chpasswd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

# ==================== DESAFIO 1: whoami ====================
# Flag: ROOT
RUN echo "=== DESAFIO 1: Primeiro Contato ===" > /root/README.txt
RUN echo "Descubra qual usuário você é usando um comando Linux." >> /root/README.txt
RUN echo "" >> /root/README.txt

# ==================== DESAFIO 2: Pasta SENAI ====================
# Flag: pa$t4
RUN mkdir -p /root/SENAI
RUN echo "pa\$t4" > /root/SENAI/flag
RUN echo "=== DESAFIO 2: Pasta SENAI ===" >> /root/README.txt
RUN echo "Encontre a pasta SENAI e leia o arquivo flag." >> /root/README.txt
RUN echo "" >> /root/README.txt

# ==================== DESAFIO 3: Script Oculto ====================
# Flag: cOdi6o
RUN mkdir -p /root/scripts/1
RUN echo '#!/bin/bash' > /root/scripts/1/script.sh
RUN echo 'echo "==================================="' >> /root/scripts/1/script.sh
RUN echo 'echo "  Script executado com sucesso!"' >> /root/scripts/1/script.sh
RUN echo 'echo "==================================="' >> /root/scripts/1/script.sh
RUN echo 'echo ""' >> /root/scripts/1/script.sh
RUN echo 'echo "Código encontrado: cOdi6o"' >> /root/scripts/1/script.sh
RUN echo 'echo ""' >> /root/scripts/1/script.sh
RUN chmod +x /root/scripts/1/script.sh
RUN echo "=== DESAFIO 3: Script Oculto ===" >> /root/README.txt
RUN echo "Execute o script em /root/scripts/1/script.sh" >> /root/README.txt
RUN echo "" >> /root/README.txt

# ==================== DESAFIO 4: Histórico ====================
# Flag: h1st0ry_m4tt3rs
RUN echo "echo 'Flag do histórico: h1st0ry_m4tt3rs'" >> /root/.bash_history
RUN echo "ls -la" >> /root/.bash_history
RUN echo "cd /root" >> /root/.bash_history
RUN echo "cat /etc/passwd" >> /root/.bash_history
RUN echo "=== DESAFIO 4: Histórico de Comandos ===" >> /root/README.txt
RUN echo "Verifique o histórico de comandos do bash." >> /root/README.txt
RUN echo "" >> /root/README.txt

# ==================== DESAFIO 5: Processos ====================
# Flag: 1
RUN echo "=== DESAFIO 5: Processos Ativos ===" >> /root/README.txt
RUN echo "Liste todos os processos. O PID do processo init é a flag." >> /root/README.txt
RUN echo "" >> /root/README.txt

# ==================== DESAFIO 6: Arquivo Oculto ====================
# Flag: H1DD3N_F1L3
RUN mkdir -p /root/.hidden
RUN echo "H1DD3N_F1L3" > /root/.hidden/.secret_flag
RUN echo "=== DESAFIO 6: Arquivo Oculto ===" >> /root/README.txt
RUN echo "Encontre o arquivo oculto em /root/.hidden/" >> /root/README.txt
RUN echo "" >> /root/README.txt

# ==================== DESAFIO 7: SUID Binaries ====================
# Flag: SU1D_B1N4RY
RUN mkdir -p /root/linux
RUN echo "SU1D_B1N4RY" > /root/linux/suid_flag.txt
RUN chmod 4755 /usr/bin/find  # Adiciona SUID ao find
RUN echo "=== DESAFIO 7: SUID Binaries ===" >> /root/README.txt
RUN echo "Encontre binários com permissão SUID." >> /root/README.txt
RUN echo "A flag está em /root/linux/suid_flag.txt" >> /root/README.txt
RUN echo "" >> /root/README.txt

# ==================== DESAFIO 8: Cron Jobs ====================
# Flag: cr0n_m4st3r
RUN mkdir -p /etc/cron.d
RUN echo "# CTF Cron Job" > /etc/cron.d/ctf-cron
RUN echo "# Flag: cr0n_m4st3r" >> /etc/cron.d/ctf-cron
RUN echo "*/5 * * * * root echo 'Cron executado' >> /tmp/cron.log" >> /etc/cron.d/ctf-cron
RUN chmod 644 /etc/cron.d/ctf-cron
RUN echo "=== DESAFIO 8: Cron Jobs ===" >> /root/README.txt
RUN echo "Encontre tarefas agendadas (cron jobs) no sistema." >> /root/README.txt
RUN echo "" >> /root/README.txt

# Banner de boas-vindas (SEM README.txt - usuário deve descobrir sozinho)
RUN rm -f /root/README.txt
RUN echo '#!/bin/bash' > /etc/profile.d/welcome.sh
RUN echo 'clear' >> /etc/profile.d/welcome.sh
RUN echo 'echo "╔══════════════════════════════════════════════════════════╗"' >> /etc/profile.d/welcome.sh
RUN echo 'echo "║     🎯 CTF SENAI - Linux Básico                         ║"' >> /etc/profile.d/welcome.sh
RUN echo 'echo "╚══════════════════════════════════════════════════════════╝"' >> /etc/profile.d/welcome.sh
RUN echo 'echo ""' >> /etc/profile.d/welcome.sh
RUN echo 'echo "📋 Desafios: 8 flags para capturar"' >> /etc/profile.d/welcome.sh
RUN echo 'echo "💡 Dica: Explore o sistema e use seus conhecimentos Linux"' >> /etc/profile.d/welcome.sh
RUN echo 'echo ""' >> /etc/profile.d/welcome.sh
RUN chmod +x /etc/profile.d/welcome.sh

# Expor porta SSH
EXPOSE 22

# Iniciar SSH
CMD ["/usr/sbin/sshd", "-D"]
