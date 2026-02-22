FROM debian:12-slim

LABEL maintainer="CTF SENAI" description="Cenário Web Security - 3 Desafios"

# Instalar apenas ferramentas essenciais
RUN apt-get update && apt-get install -y --no-install-recommends \
    apache2 php openssh-server curl wget netcat-openbsd file \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# SSH config
RUN mkdir -p /var/run/sshd && echo 'root:root' | chpasswd \
    && sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# Criar desafios web
RUN echo -e "User-agent: *\nDisallow: /admin/\nDisallow: /secret/\n\n# Flag: R0B0TS_TXT" > /var/www/html/robots.txt \
    && echo -e '<!DOCTYPE html>\n<html><head><meta charset="UTF-8"><title>CTF SENAI</title></head>\n<body><h1>🎯 CTF SENAI - Web Security</h1>\n<!-- Flag: HTML_C0MM3NT -->\n<p>Explore o site.</p></body></html>' > /var/www/html/index.html \
    && mkdir -p /var/www/html/login \
    && echo -e '<?php\nif(isset($_POST["username"]) && isset($_POST["password"])) {\n    echo "<h2>Flag: SQL_1NJ3CT10N</h2>";\n}\n?>\n<form method="POST">\n<input type="text" name="username" placeholder="Username">\n<input type="password" name="password" placeholder="Password">\n<button type="submit">Login</button>\n</form>' > /var/www/html/login/index.php

# Script de inicialização
RUN echo -e '#!/bin/bash\nservice apache2 start\n/usr/sbin/sshd -D' > /start.sh && chmod +x /start.sh

EXPOSE 22 80
CMD ["/start.sh"]
