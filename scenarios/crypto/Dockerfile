FROM debian:12-slim

LABEL maintainer="CyberSkills Lab"
LABEL description="Cenário Criptografia - 8 Desafios"

# Instalar ferramentas
RUN apt-get update && apt-get install -y \
    openssh-server \
    coreutils \
    xxd \
    zip \
    unzip \
    python3 \
    file \
    && rm -rf /var/lib/apt/lists/*

# Configurar SSH
RUN mkdir -p /var/run/sshd
RUN echo 'root:root' | chpasswd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# ==================== DESAFIO 1: Mensagem Codificada ====================
# Flag: GORD_Master_2025
RUN mkdir -p /opt/challenges/crypto
RUN echo "R09SRF9NYXN0ZXJfMjAyNQ==" > /opt/challenges/crypto/message.txt

# ==================== DESAFIO 2: MD5 Hash ====================
# Flag: 8c7dd922ad47494fc02c388e12c00eac (MD5 de "senai")
# Sem arquivo - usuário deve calcular

# ==================== DESAFIO 3: ROT13 Cipher ====================
# Flag: CIPHER_SIMPLE
RUN mkdir -p /var/log/ctf
RUN echo "PVCURE_FVZCYR" > /var/log/ctf/encrypted.log

# ==================== DESAFIO 4: SHA256 Truncado ====================
# Flag: 8f7e5b3a (primeiros 8 chars do SHA256 de "ctf2025")
# Sem arquivo - usuário deve calcular

# ==================== DESAFIO 5: XOR Byte Único ====================
# Flag: x0r_s1mpl3
RUN mkdir -p /tmp/backup
RUN printf "x0r_s1mpl3" | python3 -c "import sys; data=sys.stdin.buffer.read(); sys.stdout.buffer.write(bytes([b^0x42 for b in data]))" > /tmp/backup/data.enc

# ==================== DESAFIO 6: Hash Quebrável ====================
# Flag: password123
RUN mkdir -p /etc/ctf
RUN echo "482c811da5d5b4bc6d497ffa98491e38" > /etc/ctf/shadow.hash
RUN echo -e "password\npassword123\nadmin\nroot\n123456\nqwerty\nletmein\nwelcome" > /usr/share/dict/common.txt

# ==================== DESAFIO 7: Caesar Avançado ====================
# Flag: c43s4r_cr4ck3d
RUN mkdir -p /home/ctfuser/.secrets
RUN echo "j43z4y_jy4jr3k" > /home/ctfuser/.secrets/note.txt

# ==================== DESAFIO 8: Arquivo Corrompido ====================
# Flag: z1p_r3p41r3d
RUN mkdir -p /srv/archives
RUN mkdir -p /tmp/ziptemp && echo "z1p_r3p41r3d" > /tmp/ziptemp/flag.txt
RUN cd /tmp/ziptemp && zip /srv/archives/backup.zip flag.txt
RUN printf '\x00\x00' | dd of=/srv/archives/backup.zip bs=1 count=2 conv=notrunc 2>/dev/null
RUN rm -rf /tmp/ziptemp

# README simplificado (sem spoilers)
RUN echo "┌──────────────────────────────────────────────────────────┐" > /root/README.txt
RUN echo "│     🔐 DESAFIOS DE CRIPTOGRAFIA - CyberSkills Lab             │" >> /root/README.txt
RUN echo "└──────────────────────────────────────────────────────────┘" >> /root/README.txt
RUN echo "" >> /root/README.txt
RUN echo "📋 Total: 8 desafios de criptografia" >> /root/README.txt
RUN echo "💡 Explore o sistema e use seus conhecimentos em crypto!" >> /root/README.txt
RUN echo "" >> /root/README.txt
RUN echo "📚 Comandos úteis:" >> /root/README.txt
RUN echo "  • base64 - Codificação Base64" >> /root/README.txt
RUN echo "  • md5sum - Hash MD5" >> /root/README.txt
RUN echo "  • sha256sum - Hash SHA256" >> /root/README.txt
RUN echo "  • xxd - Hexdump" >> /root/README.txt
RUN echo "  • tr - Transformação de caracteres" >> /root/README.txt
RUN echo "" >> /root/README.txt
RUN echo "📚 Comandos úteis:" >> /root/README.txt
RUN echo "  • cat - Ler arquivos" >> /root/README.txt
RUN echo "  • echo - Imprimir texto" >> /root/README.txt
RUN echo "  • xxd - Hexdump" >> /root/README.txt
RUN echo "  • man - Manual de comandos" >> /root/README.txt
RUN echo "  • --help - Ajuda dos comandos" >> /root/README.txt
RUN echo "═══════════════════════════════════════════════════════════" >> /root/README.txt

# Banner
RUN echo '#!/bin/bash' > /etc/profile.d/welcome.sh
RUN echo 'clear' >> /etc/profile.d/welcome.sh
RUN echo 'echo "╔══════════════════════════════════════════════════════════╗"' >> /etc/profile.d/welcome.sh
RUN echo 'echo "║     🔐 CyberSkills Lab - Criptografia                         ║"' >> /etc/profile.d/welcome.sh
RUN echo 'echo "╚══════════════════════════════════════════════════════════╝"' >> /etc/profile.d/welcome.sh
RUN echo 'echo ""' >> /etc/profile.d/welcome.sh
RUN echo 'echo "📋 Desafios: 8 flags para capturar"' >> /etc/profile.d/welcome.sh
RUN echo 'echo "📖 Leia: cat /root/README.txt"' >> /etc/profile.d/welcome.sh
RUN echo 'echo ""' >> /etc/profile.d/welcome.sh
RUN chmod +x /etc/profile.d/welcome.sh

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
