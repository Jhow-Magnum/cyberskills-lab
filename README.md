# CYBERSKILLS LAB

Plataforma open-source de treinamento em cibersegurança com ambientes práticos isolados via Docker.

[![Version](https://img.shields.io/badge/version-1.0.0-blue)](https://github.com/Jhow-Magnum/cyberskills-lab)
[![License](https://img.shields.io/badge/license-MIT-green)](LICENSE)
[![Python](https://img.shields.io/badge/python-3.8+-blue)](https://www.python.org/)
[![Docker](https://img.shields.io/badge/docker-required-blue)](https://www.docker.com/)

[![English](https://img.shields.io/badge/lang-English-red)](README-EN.md)
[![Português](https://img.shields.io/badge/lang-Português-green)](README.md)

[English](README-EN.md) | **Português**

---

## Sobre o Projeto

CYBERSKILLS LAB é uma plataforma educacional para treinamento prático em segurança da informação. Oferece 40 desafios distribuídos em 6 categorias, executados em containers Docker isolados com terminal web integrado.

### Características Principais

- Execução local via Docker
- Terminal web integrado (xterm.js)
- Sistema de pontuação e ranking
- Auto-destruição de containers após uso
- Interface responsiva
- Suporte a múltiplos usuários simultâneos

## Laboratórios Disponíveis

| Categoria | Desafios | Pontos | Duração | Nível |
|-----------|----------|--------|---------|-------|
| Linux Básico | 14 | 280 | 60 min | Iniciante |
| Criptografia | 8 | 190 | 60 min | Iniciante |
| Web Security | 3 | 150 | 90 min | Intermediário |
| Network Analysis | 3 | 120 | 90 min | Intermediário |
| Code Review | 6 | 150 | 75 min | Intermediário |
| Penetration Testing | 5 | 200 | 120 min | Avançado |
| **Desafio Final** | 1 | 100 | 10 min | Especial |

**Total: 40 desafios | 1.190 pontos**

## Requisitos do Sistema

- Docker 20.10+
- Python 3.8+
- Linux (Debian/Ubuntu recomendado)
- 4GB RAM mínimo
- 10GB espaço em disco

## Instalação

### 1. Instalar Docker

```bash
curl -fsSL https://get.docker.com | sudo bash
sudo usermod -aG docker $USER
```

Faça logout e login novamente para aplicar as permissões.

### 2. Clonar Repositório

```bash
git clone https://github.com/Jhow-Magnum/cyberskills-lab.git
cd cyberskills-lab
```

### 3. Instalar Dependências

```bash
bash install.sh
```

### 4. Iniciar Plataforma

```bash
bash start.sh
```

Acesse: http://localhost:5000

## Uso

1. Abra o navegador em `http://localhost:5000`
2. Digite seu nome de usuário
3. Selecione um laboratório
4. Resolva os desafios no terminal integrado
5. Submeta as flags encontradas
6. Acompanhe sua pontuação no scoreboard

### Instalar como Aplicativo (PWA)

Você pode instalar a plataforma como um aplicativo:

- **Chrome/Edge/Brave**: Clique no ícone de instalação (⊕) na barra de endereço
- **Firefox**: Menu → Instalar este site como aplicativo
- **Safari**: Compartilhar → Adicionar à Tela de Início

O aplicativo abrirá em janela própria sem a barra do navegador.

Para encerrar:
```bash
bash stop.sh
```

## Estrutura do Projeto

```
cyberskills-lab/
├── ctf-simple.py           # Backend Flask
├── web.html                # Interface web
├── requirements.txt        # Dependências Python
├── install.sh              # Script de instalação
├── start.sh                # Iniciar plataforma
├── stop.sh                 # Parar plataforma
├── build-all.sh            # Build das imagens Docker
├── repositories/           # Definições YAML dos labs
│   └── cyberskills-lab/
│       └── labs/
└── scenarios/              # Dockerfiles dos ambientes
    ├── linux-basic/
    ├── crypto/
    ├── web-security/
    ├── network/
    ├── code-review/
    └── pentest/
```

## Stack Tecnológica

- **Backend**: Flask (Python)
- **Frontend**: HTML5, CSS3, JavaScript
- **Terminal**: xterm.js
- **Containers**: Docker
- **Banco de Dados**: SQLite
- **WebSocket**: flask-sock

## Solução de Problemas

### Porta 5000 em uso

```bash
lsof -ti:5000 | xargs kill -9
```

### Containers não removidos

```bash
docker ps -a | grep cyberskills | awk '{print $1}' | xargs docker rm -f
```

### Reconstruir imagens

```bash
bash build-all.sh
```

## Contribuindo

Contribuições são bem-vindas. Por favor:

1. Fork o projeto
2. Crie uma branch para sua feature (`git checkout -b feature/nova-feature`)
3. Commit suas mudanças (`git commit -m 'Adiciona nova feature'`)
4. Push para a branch (`git push origin feature/nova-feature`)
5. Abra um Pull Request

Veja [CONTRIBUTING.md](CONTRIBUTING.md) para mais detalhes.

## Roadmap

- Sistema de badges e conquistas
- Modo competição em tempo real
- Labs de forense digital
- Labs de análise de malware
- Labs de segurança em cloud (AWS/Azure)
- API REST pública
- Dashboard de analytics
- Suporte multilíngue

## Autor

**Jhow Magnum**

- GitHub: [@Jhow-Magnum](https://github.com/Jhow-Magnum)
- LinkedIn: [Jhow Magnum](https://www.linkedin.com/in/jhowmagnum/)

## Licença

Este projeto está licenciado sob a Licença MIT - veja o arquivo [LICENSE](LICENSE) para detalhes.

## Agradecimentos

- Comunidade de segurança da informação
- Contribuidores do projeto
- Comunidade open-source

---

**Versão 1.0.0** | 2026
