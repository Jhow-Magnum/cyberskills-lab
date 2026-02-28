FROM debian:12-slim

LABEL maintainer="CyberSkills Lab" description="Cenário Code Review - 6 Desafios"

# Instalar apenas ferramentas essenciais
RUN apt-get update && apt-get install -y --no-install-recommends \
    openssh-server python3 php file \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# SSH config
RUN mkdir -p /var/run/sshd && echo 'root:root' | chpasswd \
    && sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# Criar todos os desafios
RUN mkdir -p /opt/vulnerable \
    && printf '#!/usr/bin/env python3\nimport os\nuser_input = input("Digite um comando: ")\n# VULNERÁVEL: Command Injection!\n# Flag: CMD_1NJ3CT10N\nos.system(user_input)\n' > /opt/vulnerable/vuln1.py \
    && printf 'const mysql = require("mysql");\nconst username = req.body.username;\n// VULNERÁVEL: SQL Injection!\n// Flag: SQL_1NJ3CT10N\nconst query = "SELECT * FROM users WHERE username = '\''"+username+"'\''";\n' > /opt/vulnerable/vuln2.js \
    && printf '#!/usr/bin/env python3\n# VULNERÁVEL: Senha hardcoded!\n# Flag: H4RDC0D3D_P4SS\nDB_PASSWORD = "super_secret_password_123"\n' > /opt/vulnerable/config.py \
    && printf '<?php\n$code = $_GET["code"];\n// VULNERÁVEL: Code Execution!\n// Flag: C0D3_3X3C\neval($code);\n?>\n' > /opt/vulnerable/vuln4.php \
    && printf '#!/usr/bin/env python3\n# VULNERÁVEL: API Key exposta!\n# Flag: L34K3D_K3Y\nAPI_KEY = "sk-1234567890abcdef"\nSECRET_TOKEN = "ghp_xxxxxxxxxxxxxxxxxxxx"\n' > /opt/vulnerable/.env \
    && printf 'const userInput = req.query.name;\n// VULNERÁVEL: XSS!\n// Flag: XSS_VULN\ndocument.getElementById("output").innerHTML = userInput;\n' > /opt/vulnerable/vuln6.js

# Criar README educativo estilo Bandit
RUN printf '=== CYBERSKILLS LAB - CODE REVIEW ===\n\nBem-vindo aos desafios de Revisão de Código!\nVocê está logado como '\''root'\''. Analise códigos vulneráveis.\n\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n\n6 DESAFIOS DE REVISÃO DE CÓDIGO\n\nComandos úteis:\n• ls /opt/vulnerable\n• cat /opt/vulnerable/*.py\n• cat /opt/vulnerable/*.js\n• cat /opt/vulnerable/*.php\n• cat /opt/vulnerable/.env\n• grep -r "Flag" /opt\n• grep -r "VULNERÁVEL" /opt\n• grep -r "password" /opt\n• grep -r "eval" /opt\n• grep -r "system" /opt\n• find /opt -name "*.py"\n• find /opt -name ".env"\n\nDicas gerais:\n1. Comentários indicam vulnerabilidades\n2. Funções perigosas: eval(), exec(), system()\n3. Credenciais hardcoded são inseguras\n4. Queries SQL sem sanitização são vulneráveis\n5. Input do usuário deve ser validado\n6. API keys não devem estar no código\n7. XSS explora saída não sanitizada\n\nVulnerabilidades comuns:\n• Command Injection\n• SQL Injection\n• Hardcoded Credentials\n• Code Execution\n• API Key Leak\n• Cross-Site Scripting (XSS)\n\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n\n💡 Usando Google/IA:\n\n✅ Pergunte: "O que é Command Injection?"\n✅ Pergunte: "Por que eval() é perigoso?"\n✅ Pergunte: "Como prevenir SQL Injection?"\n\n❌ Não peça: "Encontre as vulnerabilidades para mim"\n\nAPRENDA segurança de código, não apenas identifique!\n\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n\nLembre-se: A melhor forma de aprender é tentando sozinho primeiro!\nUse as dicas apenas se estiver realmente travado.\n\nBoa sorte, hacker!\n' > /root/README.txt

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
