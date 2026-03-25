# CYBERSKILLS LAB

Plataforma open-source de treinamento prático em cibersegurança com ambientes isolados via Docker.

[![Version](https://img.shields.io/badge/version-1.0.0-blue)](https://github.com/Jhow-Magnum/cyberskills-lab)
[![License](https://img.shields.io/badge/license-MIT-green)](LICENSE)
[![Python](https://img.shields.io/badge/python-3.8+-blue)](https://www.python.org/)
[![Docker](https://img.shields.io/badge/docker-required-blue)](https://www.docker.com/)

[English](README-EN.md) | **Português**

---

## Sobre o Projeto

CYBERSKILLS LAB é uma plataforma educacional para treinamento prático em segurança da informação. Oferece 37 desafios em 5 categorias ativas, executados em containers Docker isolados com terminal web integrado.

O mascote oficial da plataforma é o **PinguLinux** 🐧 — um pinguim que representa a essência do projeto: Linux, comunidade e aprendizado prático.

### Características

- Execução 100% local via Docker
- Terminal web integrado (xterm.js) — sem necessidade de SSH externo
- Sistema de pontuação e ranking
- Auto-destruição de containers após uso
- Suporte a múltiplos usuários simultâneos
- Instalável como aplicativo (PWA)

## Laboratórios

| Categoria | Desafios | Pontos | Duração | Nível |
|-----------|----------|--------|---------|-------|
| Linux Básico | 14 | 280 | 60 min | Iniciante |
| Criptografia | 8 | 190 | 60 min | Iniciante |
| Web Security | 3 | 150 | 90 min | Intermediário |
| Network Analysis | 3 | - | 90 min | 🚧 Em Desenvolvimento |
| Code Review | 6 | 150 | 75 min | Intermediário |
| Penetration Testing | 5 | 200 | 120 min | Avançado |
| **Desafio Final** | 1 | 100 | 30 min | Especial |

**Total: 37 desafios ativos | 1.070 pontos**

## Requisitos

- Docker 20.10+
- Python 3.8+ com pip
- Linux (Debian/Ubuntu recomendado)
- 4GB RAM mínimo
- 10GB espaço em disco

## Instalação

### Pré-requisitos

**1. Docker:**
```bash
curl -fsSL https://get.docker.com | sudo bash
sudo usermod -aG docker $USER
newgrp docker
```

**2. Python 3 e pip:**
```bash
sudo apt update && sudo apt install python3 python3-pip -y
```

**3. Faça logout e login novamente** para aplicar as permissões do grupo docker.

### Instalação Rápida

```bash
curl -sSL https://raw.githubusercontent.com/Jhow-Magnum/cyberskills-lab/main/install.sh | bash
```

### Instalação Manual

```bash
git clone https://github.com/Jhow-Magnum/cyberskills-lab.git
cd cyberskills-lab
bash install.sh
```

Acesse: http://localhost:5000

## Uso

1. Abra `http://localhost:5000` no navegador
2. Digite seu nome de usuário
3. Selecione um laboratório
4. Resolva os desafios no terminal integrado
5. Submeta as flags encontradas
6. Acompanhe sua pontuação no scoreboard

### Instalar como Aplicativo (PWA)

- **Chrome/Edge/Brave**: Clique no ícone (⊕) na barra de endereço
- **Firefox**: Menu → Instalar este site como aplicativo
- **Safari**: Compartilhar → Adicionar à Tela de Início

### Parar a Plataforma

```bash
bash ~/cyberskills-lab/stop.sh
```

### Desinstalar

```bash
bash ~/cyberskills-lab/uninstall.sh
```

## Estrutura do Projeto

```
cyberskills-lab/
├── ctf-simple.py        # Backend Flask
├── web.html             # Interface web
├── requirements.txt     # Dependências Python
├── install.sh           # Instalação
├── start.sh             # Iniciar plataforma
├── stop.sh              # Parar plataforma
├── build-all.sh         # Build das imagens Docker
├── repositories/        # Definições YAML dos labs
└── scenarios/           # Dockerfiles dos ambientes
```

## Stack Tecnológica

- **Backend**: Flask (Python)
- **Frontend**: HTML5, CSS3, JavaScript
- **Terminal**: xterm.js
- **Containers**: Docker
- **Banco de Dados**: SQLite
- **WebSocket**: flask-sock

## Solução de Problemas

**Porta 5000 em uso:**
```bash
lsof -ti:5000 | xargs kill -9
```

**Containers não removidos:**
```bash
docker ps -a | grep cyberskills | awk '{print $1}' | xargs docker rm -f
```

**Reconstruir imagens:**
```bash
bash build-all.sh
```

## Contribuindo

1. Fork o projeto
2. Crie uma branch (`git checkout -b feature/nova-feature`)
3. Commit suas mudanças (`git commit -m 'Descrição da mudança'`)
4. Push para a branch (`git push origin feature/nova-feature`)
5. Abra um Pull Request

## Autor

**Jhow Magnum**

- GitHub: [@Jhow-Magnum](https://github.com/Jhow-Magnum)
- LinkedIn: [Jhow Magnum](https://www.linkedin.com/in/jhowmagnum/)

## Licença

MIT License — veja [LICENSE](LICENSE) para detalhes.
