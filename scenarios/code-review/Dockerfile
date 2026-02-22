FROM debian:12-slim

LABEL maintainer="CTF SENAI"
LABEL description="Cenário Code Review - 6 Desafios"

# Instalar ferramentas de code review
RUN apt-get update && apt-get install -y \
    openssh-server \
    python3 \
    python3-pip \
    nodejs \
    npm \
    default-jdk \
    gcc \
    make \
    git \
    php \
    file \
    && rm -rf /var/lib/apt/lists/*

# Instalar bandit para análise de código Python
RUN pip3 install --no-cache-dir bandit --break-system-packages

RUN mkdir -p /var/run/sshd
RUN echo 'root:root' | chpasswd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

RUN mkdir -p /root/code_review

# Desafio 1: Command Injection
RUN echo '#!/usr/bin/env python3' > /root/code_review/vuln1.py && \
    echo 'import os' >> /root/code_review/vuln1.py && \
    echo 'user_input = input("Digite um comando: ")' >> /root/code_review/vuln1.py && \
    echo '# VULNERÁVEL: Command Injection!' >> /root/code_review/vuln1.py && \
    echo 'os.system(user_input)' >> /root/code_review/vuln1.py && \
    echo "CMD_1NJ3CT10N" > /root/code_review/flag1.txt

# Desafio 2: SQL Injection
RUN echo 'const mysql = require("mysql");' > /root/code_review/vuln2.js && \
    echo 'const username = req.body.username;' >> /root/code_review/vuln2.js && \
    echo '// VULNERÁVEL: SQL Injection!' >> /root/code_review/vuln2.js && \
    echo 'const query = "SELECT * FROM users WHERE username = '\''"+username+"'\''";' >> /root/code_review/vuln2.js && \
    echo "SQL_1NJ3CT10N" > /root/code_review/flag2.txt

# Desafio 3: Hardcoded Password
RUN echo '#!/usr/bin/env python3' > /root/code_review/vuln3.py && \
    echo '# VULNERÁVEL: Senha hardcoded!' >> /root/code_review/vuln3.py && \
    echo 'DB_PASSWORD = "super_secret_password_123"' >> /root/code_review/vuln3.py && \
    echo "H4RDC0D3D_P4SS" > /root/code_review/flag3.txt

# Desafio 4: Code Execution
RUN echo '<?php' > /root/code_review/vuln4.php && \
    echo '$code = $_GET["code"];' >> /root/code_review/vuln4.php && \
    echo '// VULNERÁVEL: Code Execution!' >> /root/code_review/vuln4.php && \
    echo 'eval($code);' >> /root/code_review/vuln4.php && \
    echo '?>' >> /root/code_review/vuln4.php && \
    echo "C0D3_3X3C" > /root/code_review/flag4.txt

# Desafio 5: API Key Leak
RUN echo '#!/usr/bin/env python3' > /root/code_review/vuln5.py && \
    echo '# VULNERÁVEL: API Key exposta!' >> /root/code_review/vuln5.py && \
    echo 'API_KEY = "sk-1234567890abcdef"' >> /root/code_review/vuln5.py && \
    echo "L34K3D_K3Y" > /root/code_review/flag5.txt

# Desafio 6: XSS
RUN echo 'const userInput = req.query.name;' > /root/code_review/vuln6.js && \
    echo '// VULNERÁVEL: XSS!' >> /root/code_review/vuln6.js && \
    echo 'document.write("Hello " + userInput);' >> /root/code_review/vuln6.js && \
    echo "XSS_VULN" > /root/code_review/flag6.txt

RUN echo "=== CTF SENAI - Code Review ===" > /root/README.txt && \
    echo "Analise os códigos em /root/code_review/" >> /root/README.txt && \
    echo "6 vulnerabilidades para encontrar" >> /root/README.txt

RUN echo '#!/bin/bash' > /etc/profile.d/welcome.sh && \
    echo 'echo "🎯 CTF SENAI - Code Review"' >> /etc/profile.d/welcome.sh && \
    echo 'echo "📋 6 flags | 📖 cat /root/README.txt"' >> /etc/profile.d/welcome.sh && \
    chmod +x /etc/profile.d/welcome.sh

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
