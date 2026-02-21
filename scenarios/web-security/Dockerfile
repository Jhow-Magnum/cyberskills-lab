FROM debian:12-slim

LABEL maintainer="CTF SENAI"
LABEL description="Cenário Web Security - 3 Desafios"

# Instalar Apache, PHP, MySQL
RUN apt-get update && apt-get install -y \
    apache2 \
    php \
    php-mysql \
    mariadb-server \
    openssh-server \
    curl \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Configurar SSH
RUN mkdir -p /var/run/sshd
RUN echo 'root:root' | chpasswd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# ==================== DESAFIO 1: robots.txt ====================
# Flag: R0B0TS_TXT
RUN echo "User-agent: *" > /var/www/html/robots.txt
RUN echo "Disallow: /admin/" >> /var/www/html/robots.txt
RUN echo "Disallow: /secret/" >> /var/www/html/robots.txt
RUN echo "" >> /var/www/html/robots.txt
RUN echo "# Flag: R0B0TS_TXT" >> /var/www/html/robots.txt

# ==================== DESAFIO 2: Comentário HTML ====================
# Flag: HTML_C0MM3NT
RUN echo '<!DOCTYPE html>' > /var/www/html/index.html
RUN echo '<html lang="pt-BR">' >> /var/www/html/index.html
RUN echo '<head>' >> /var/www/html/index.html
RUN echo '    <meta charset="UTF-8">' >> /var/www/html/index.html
RUN echo '    <title>CTF SENAI - Web Security</title>' >> /var/www/html/index.html
RUN echo '</head>' >> /var/www/html/index.html
RUN echo '<body>' >> /var/www/html/index.html
RUN echo '    <h1>🎯 CTF SENAI - Web Security</h1>' >> /var/www/html/index.html
RUN echo '    <p>Bem-vindo ao desafio de segurança web!</p>' >> /var/www/html/index.html
RUN echo '    <!-- Flag: HTML_C0MM3NT -->' >> /var/www/html/index.html
RUN echo '    <p>Explore o site e encontre as vulnerabilidades.</p>' >> /var/www/html/index.html
RUN echo '</body>' >> /var/www/html/index.html
RUN echo '</html>' >> /var/www/html/index.html

# ==================== DESAFIO 3: SQL Injection ====================
# Flag: SQL_1NJ3CT10N
RUN mkdir -p /var/www/html/login
RUN echo '<?php' > /var/www/html/login/index.php
RUN echo '$host = "localhost";' >> /var/www/html/login/index.php
RUN echo '$user = "root";' >> /var/www/html/login/index.php
RUN echo '$pass = "root";' >> /var/www/html/login/index.php
RUN echo '$db = "ctf";' >> /var/www/html/login/index.php
RUN echo '' >> /var/www/html/login/index.php
RUN echo 'if(isset($_POST["username"]) && isset($_POST["password"])) {' >> /var/www/html/login/index.php
RUN echo '    $conn = new mysqli($host, $user, $pass, $db);' >> /var/www/html/login/index.php
RUN echo '    $username = $_POST["username"];' >> /var/www/html/login/index.php
RUN echo '    $password = $_POST["password"];' >> /var/www/html/login/index.php
RUN echo '    // VULNERÁVEL A SQL INJECTION!' >> /var/www/html/login/index.php
RUN echo '    $sql = "SELECT * FROM users WHERE username='\''".$username."'\'' AND password='\''".$password."'\''";' >> /var/www/html/login/index.php
RUN echo '    $result = $conn->query($sql);' >> /var/www/html/login/index.php
RUN echo '    if($result->num_rows > 0) {' >> /var/www/html/login/index.php
RUN echo '        echo "<h2>Flag: SQL_1NJ3CT10N</h2>";' >> /var/www/html/login/index.php
RUN echo '    }' >> /var/www/html/login/index.php
RUN echo '}' >> /var/www/html/login/index.php
RUN echo '?>' >> /var/www/html/login/index.php
RUN echo '<form method="POST">' >> /var/www/html/login/index.php
RUN echo '    <input type="text" name="username" placeholder="Username">' >> /var/www/html/login/index.php
RUN echo '    <input type="password" name="password" placeholder="Password">' >> /var/www/html/login/index.php
RUN echo '    <button type="submit">Login</button>' >> /var/www/html/login/index.php
RUN echo '</form>' >> /var/www/html/login/index.php

# Script de inicialização
RUN echo '#!/bin/bash' > /start.sh
RUN echo 'service mysql start' >> /start.sh
RUN echo 'mysql -e "CREATE DATABASE IF NOT EXISTS ctf;"' >> /start.sh
RUN echo 'mysql -e "USE ctf; CREATE TABLE IF NOT EXISTS users (id INT, username VARCHAR(50), password VARCHAR(50));"' >> /start.sh
RUN echo 'mysql -e "USE ctf; INSERT INTO users VALUES (1, '\''admin'\'', '\''password123'\'');"' >> /start.sh
RUN echo 'service apache2 start' >> /start.sh
RUN echo '/usr/sbin/sshd -D' >> /start.sh
RUN chmod +x /start.sh

EXPOSE 22 80 3306

CMD ["/start.sh"]
