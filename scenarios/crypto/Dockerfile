FROM debian:12-slim

LABEL maintainer="CTF SENAI" description="Cenário Criptografia - 8 Desafios"

# Instalar apenas ferramentas essenciais
RUN apt-get update && apt-get install -y --no-install-recommends \
    openssh-server python3 openssl bc xxd zip unzip file coreutils binutils \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# SSH config
RUN mkdir -p /var/run/sshd && echo 'root:root' | chpasswd \
    && sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# Criar todos os desafios em uma camada
RUN mkdir -p /opt/challenges/crypto /var/log/ctf /tmp/backup /etc/ctf /home/ctfuser/.secrets /srv/archives \
    && echo "R09SRF9NYXN0ZXJfMjAyNQ==" > /opt/challenges/crypto/message.txt \
    && echo "PVCURE_FVZCYR" > /var/log/ctf/encrypted.log \
    && printf "x0r_s1mpl3" | python3 -c "import sys; data=sys.stdin.buffer.read(); sys.stdout.buffer.write(bytes([b^0x42 for b in data]))" > /tmp/backup/data.enc \
    && echo "482c811da5d5b4bc6d497ffa98491e38" > /etc/ctf/shadow.hash \
    && echo -e "password\npassword123\nadmin\nroot\n123456\nqwerty\nletmein\nwelcome" > /usr/share/dict/common.txt \
    && echo "j43z4y_jy4jr3k" > /home/ctfuser/.secrets/note.txt \
    && mkdir -p /tmp/ziptemp && echo "z1p_r3p41r3d" > /tmp/ziptemp/flag.txt \
    && cd /tmp/ziptemp && zip -q /srv/archives/backup.zip flag.txt \
    && printf '\x00\x00' | dd of=/srv/archives/backup.zip bs=1 count=2 conv=notrunc 2>/dev/null \
    && rm -rf /tmp/ziptemp

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
