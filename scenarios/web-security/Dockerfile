FROM debian:12-slim

LABEL maintainer="CTF SENAI" description="Cenário Web Security - 3 Desafios"

# Instalar apenas ferramentas essenciais
RUN apt-get update && apt-get install -y --no-install-recommends \
    apache2 php openssh-server curl wget netcat-openbsd file ca-certificates \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# SSH config
RUN mkdir -p /var/run/sshd && echo 'root:root' | chpasswd \
    && sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# Criar usuário padrão para terminal
RUN useradd -m -s /bin/bash user && echo 'user:user' | chpasswd

# Criar desafios web
RUN echo -e "User-agent: *\nDisallow: /admin/\nDisallow: /secret/\n\n# Flag: R0B0TS_TXT" > /var/www/html/robots.txt \
    && echo -e '<!DOCTYPE html>\n<html><head><meta charset="UTF-8"><title>CTF SENAI</title></head>\n<body><h1>🎯 CTF SENAI - Web Security</h1>\n<!-- Flag: HTML_C0MM3NT -->\n<p>Explore o site.</p></body></html>' > /var/www/html/index.html \
    && mkdir -p /var/www/html/login \
    && echo -e '<?php\nif(isset($_POST["username"]) && isset($_POST["password"])) {\n    echo "<h2>Flag: SQL_1NJ3CT10N</h2>";\n}\n?>\n<form method="POST">\n<input type="text" name="username" placeholder="Username">\n<input type="password" name="password" placeholder="Password">\n<button type="submit">Login</button>\n</form>' > /var/www/html/login/index.php

# Criar README educativo estilo Bandit
RUN printf '=== CYBERSKILLS LAB - WEB SECURITY ===\n\nBem-vindo aos desafios de Segurança Web!\nVocê está logado como '\''user'\''. Explore o servidor web.\n\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n\n3 DESAFIOS DE SEGURANÇA WEB\n\nComandos úteis:\n• curl http://localhost\n• curl http://localhost/arquivo\n• wget http://localhost\n• cat /var/www/html/*\n• cat /var/www/html/login/*\n• find /var/www -type f\n• grep -r "Flag" /var/www\n• ls -la /var/www/html\n\nDicas gerais:\n1. Servidores web guardam arquivos em /var/www/html\n2. Arquivos especiais revelam informações\n3. Comentários HTML podem conter dados sensíveis\n4. Código fonte de páginas pode ter surpresas\n5. SQL Injection explora queries mal construídas\n6. Formulários podem ser vulneráveis\n\nRecursos:\n• Diretórios web: /var/www/html\n• Arquivos comuns: robots.txt, index.html, .htaccess\n• Scripts PHP: /var/www/html/login\n\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n\n💡 Usando Google/IA:\n\n✅ Pergunte: "O que é robots.txt e para que serve?"\n✅ Pergunte: "Como ver código fonte HTML no terminal?"\n✅ Pergunte: "O que é SQL Injection básico?"\n\n❌ Não peça: "Me dê as flags do desafio web"\n\nAPRENDA segurança web, não apenas copie!\n\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n\nLembre-se: A melhor forma de aprender é tentando sozinho primeiro!\nUse as dicas apenas se estiver realmente travado.\n\nBoa sorte, hacker!\n' > /home/user/README.txt \
    && chown user:user /home/user/README.txt

# Script de inicialização
RUN printf '#!/bin/bash\nservice apache2 start\n/usr/sbin/sshd -D\n' > /start.sh && chmod +x /start.sh

EXPOSE 22 80
CMD ["/start.sh"]
