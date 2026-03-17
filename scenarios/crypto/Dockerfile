FROM debian:12-slim

LABEL maintainer="Jhow-Magnum" description="Cenário Criptografia - 8 Desafios"

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

# Criar README educativo (PT-BR)
RUN printf '=== CYBERSKILLS LAB - CRIPTOGRAFIA ===\n\nBem-vindo aos desafios de Criptografia!\nVoce esta logado como root. Explore e decifre.\n\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n\n8 DESAFIOS DE CRIPTOGRAFIA\n\nComandos uteis:\n• base64 -d\n• echo -n "texto" | md5sum\n• tr A-Za-z N-ZA-Mn-za-m\n• xxd arquivo\n• python3 -c "codigo"\n• for i in {0..255}; do ... done\n• while read palavra; do ... done < wordlist\n• file arquivo\n• unzip arquivo.zip\n\nDicas gerais:\n1. Base64 codifica dados em texto ASCII\n2. ROT13 rotaciona letras 13 posicoes\n3. XOR e uma operacao bit a bit reversivel\n4. MD5 gera hash de 32 caracteres hexadecimais\n5. Wordlists ajudam em ataques de dicionario\n6. Cifra de Cesar desloca letras\n7. Arquivos ZIP podem estar corrompidos\n8. Hexadecimal representa bytes em base 16\n\nRecursos:\n• Diretorios: /opt, /var/log, /tmp, /etc, /home, /srv\n• Wordlists: /usr/share/dict\n• Ferramentas: base64, md5sum, tr, xxd, python3\n\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n\nUsando Google/IA como aliado:\n\nEsta travado? Tudo bem usar Google ou IA (ChatGPT, Claude, etc), MAS:\n\nFACA:\n  • Pergunte "O que e Base64 e como decodificar?"\n  • Pergunte "Como funciona a cifra ROT13?"\n  • Pergunte "O que e XOR em criptografia?"\n  • Use para APRENDER os conceitos e tecnicas\n\nNAO FACA:\n  • Copiar e colar comandos prontos sem entender\n  • Pedir "resolva o desafio X para mim"\n  • Pular o aprendizado so para pegar a flag\n\nO objetivo e APRENDER, nao apenas completar!\nEntenda cada tecnica criptografica que voce usa.\n\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n\nLembre-se: A melhor forma de aprender e tentando sozinho primeiro!\nUse as dicas apenas se estiver realmente travado.\n\nBoa sorte, hacker!\n' > /root/README

# README em Ingles
RUN echo '=== CYBERSKILLS LAB - CRYPTOGRAPHY ===' > /root/README-EN && \
    echo '' >> /root/README-EN && \
    echo 'Welcome to Cryptography challenges!' >> /root/README-EN && \
    echo 'You are logged in as root. Explore and decipher.' >> /root/README-EN && \
    echo '' >> /root/README-EN && \
    echo '8 CRYPTOGRAPHY CHALLENGES' >> /root/README-EN && \
    echo '' >> /root/README-EN && \
    echo 'Useful commands:' >> /root/README-EN && \
    echo '- base64 -d' >> /root/README-EN && \
    echo '- echo -n "text" | md5sum' >> /root/README-EN && \
    echo '- tr A-Za-z N-ZA-Mn-za-m' >> /root/README-EN && \
    echo '- xxd file' >> /root/README-EN && \
    echo '- python3 -c "code"' >> /root/README-EN && \
    echo '- for i in {0..255}; do ... done' >> /root/README-EN && \
    echo '- while read word; do ... done < wordlist' >> /root/README-EN && \
    echo '- file filename' >> /root/README-EN && \
    echo '- unzip file.zip' >> /root/README-EN && \
    echo '' >> /root/README-EN && \
    echo 'Directories: /opt, /var/log, /tmp, /etc, /home, /srv' >> /root/README-EN && \
    echo 'Wordlists: /usr/share/dict' >> /root/README-EN && \
    echo '' >> /root/README-EN && \
    echo 'Good luck, hacker!' >> /root/README-EN

# Auto-exibir README ao logar
RUN echo '' >> /root/.bashrc && \
    echo '[ -f /root/README ] && cat /root/README' >> /root/.bashrc && \
    echo '' >> /root/.bashrc

# Limpar historico de comandos
RUN rm -f /root/.bash_history /home/user/.bash_history 2>/dev/null || true

WORKDIR /root
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
