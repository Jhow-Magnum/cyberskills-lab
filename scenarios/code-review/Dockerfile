FROM debian:12-slim

LABEL maintainer="CTF SENAI" description="Cenário Code Review - 6 Desafios"

# Instalar ferramentas
RUN apt-get update && apt-get install -y --no-install-recommends \
    openssh-server python3 python3-pip nodejs npm default-jdk gcc make git php file \
    && pip3 install --no-cache-dir bandit --break-system-packages \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# SSH config
RUN mkdir -p /var/run/sshd && echo 'root:root' | chpasswd \
    && sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# Criar todos os desafios
RUN mkdir -p /root/code_review \
    && echo -e '#!/usr/bin/env python3\nimport os\nuser_input = input("Digite um comando: ")\n# VULNERÁVEL: Command Injection!\nos.system(user_input)' > /root/code_review/vuln1.py && echo "CMD_1NJ3CT10N" > /root/code_review/flag1.txt \
    && echo -e 'const mysql = require("mysql");\nconst username = req.body.username;\n// VULNERÁVEL: SQL Injection!\nconst query = "SELECT * FROM users WHERE username = '\''"+username+"'\''";' > /root/code_review/vuln2.js && echo "SQL_1NJ3CT10N" > /root/code_review/flag2.txt \
    && echo -e '#!/usr/bin/env python3\n# VULNERÁVEL: Senha hardcoded!\nDB_PASSWORD = "super_secret_password_123"' > /root/code_review/vuln3.py && echo "H4RDC0D3D_P4SS" > /root/code_review/flag3.txt \
    && echo -e '<?php\n$code = $_GET["code"];\n// VULNERÁVEL: Code Execution!\neval($code);\n?>' > /root/code_review/vuln4.php && echo "C0D3_3X3C" > /root/code_review/flag4.txt \
    && echo -e '#!/usr/bin/env python3\n# VULNERÁVEL: API Key exposta!\nAPI_KEY = "sk-1234567890abcdef"' > /root/code_review/vuln5.py && echo "L34K3D_K3Y" > /root/code_review/flag5.txt \
    && echo -e 'const userInput = req.query.name;\n// VULNERÁVEL: XSS!\ndocument.write("Hello " + userInput);' > /root/code_review/vuln6.js && echo "XSS_VULN" > /root/code_review/flag6.txt

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
