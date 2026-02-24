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

# Criar README educativo estilo Bandit
RUN printf '=== CYBERSKILLS LAB - CRIPTOGRAFIA ===\n\nBem-vindo aos desafios de Criptografia!\nVocê está logado como '\''root'\''. Explore e decifre.\n\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n\n8 DESAFIOS DE CRIPTOGRAFIA\n\nComandos úteis:\n• base64 -d\n• echo -n "texto" | md5sum\n• echo -n "texto" | sha256sum\n• sha256sum | cut -c1-8\n• tr '\''A-Za-z'\'' '\''N-ZA-Mn-za-m'\''\n• tr '\''A-Za-z'\'' '\''H-ZA-Gh-za-g'\''\n• xxd arquivo\n• xxd -r arquivo\n• python3 -c "código"\n• for i in {0..255}; do ... done\n• while read palavra; do ... done < wordlist\n• openssl enc -d\n• file arquivo\n• unzip arquivo.zip\n• printf '\''\\x50\\x4B'\'' | dd of=arquivo\n\nDicas gerais:\n1. Arquivos codificados estão espalhados pelo sistema\n2. Hashes podem ser quebrados com wordlists\n3. ROT13 é uma cifra de substituição simples\n4. Caesar cipher usa rotação de letras\n5. XOR pode ser quebrado testando todas as chaves (0-255)\n6. Magic numbers identificam tipos de arquivo\n7. ZIP começa com bytes 50 4B 03 04\n\nRecursos:\n• Diretórios: /opt, /var/log, /tmp, /etc, /home, /srv\n• Wordlists: /usr/share/dict\n\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n\n💡 Usando Google/IA:\n\n✅ Pergunte: "Como decodificar Base64 no Linux?"\n✅ Pergunte: "O que é ROT13 e como decifrar?"\n✅ Pergunte: "Como quebrar hash MD5 com wordlist?"\n\n❌ Não peça soluções prontas!\n\nAPRENDA criptografia, não apenas resolva!\n\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n\nLembre-se: A melhor forma de aprender é tentando sozinho primeiro!\nUse as dicas apenas se estiver realmente travado.\n\nBoa sorte, hacker!\n' > /root/README.txt

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
