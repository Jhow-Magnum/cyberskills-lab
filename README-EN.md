# CYBERSKILLS LAB

Open-source cybersecurity training platform with isolated practical environments via Docker.

[![Version](https://img.shields.io/badge/version-1.0.0-blue)](https://github.com/Jhow-Magnum/cyberskills-lab)
[![License](https://img.shields.io/badge/license-MIT-green)](LICENSE)
[![Python](https://img.shields.io/badge/python-3.8+-blue)](https://www.python.org/)
[![Docker](https://img.shields.io/badge/docker-required-blue)](https://www.docker.com/)

**English** | [Português](README.md)

---

## About

CYBERSKILLS LAB is an educational platform for hands-on information security training. It offers 37 challenges across 5 active categories, running in isolated Docker containers with an integrated web terminal.

The official platform mascot is **PinguLinux** 🐧 — a penguin representing the project's essence: Linux, community and hands-on learning.

### Features

- 100% local execution via Docker
- Integrated web terminal (xterm.js) — no external SSH needed
- Scoring and ranking system
- Auto-destruction of containers after use
- Support for multiple simultaneous users
- Installable as an app (PWA)

## Labs

| Category | Challenges | Points | Duration | Level |
|----------|-----------|--------|----------|-------|
| Linux Basics | 14 | 280 | 60 min | Beginner |
| Cryptography | 8 | 190 | 60 min | Beginner |
| Web Security | 3 | 150 | 90 min | Intermediate |
| Network Analysis | 3 | - | 90 min | 🚧 In Development |
| Code Review | 6 | 150 | 75 min | Intermediate |
| Penetration Testing | 5 | 200 | 120 min | Advanced |
| **Final Challenge** | 1 | 100 | 30 min | Special |

**Total: 37 active challenges | 1,070 points**

## Requirements

- Docker 20.10+
- Python 3.8+ with pip
- Linux (Debian/Ubuntu recommended)
- 4GB RAM minimum
- 10GB disk space

## Installation

### Prerequisites

**1. Docker:**
```bash
curl -fsSL https://get.docker.com | sudo bash
sudo usermod -aG docker $USER
newgrp docker
```

**2. Python 3 and pip:**
```bash
sudo apt update && sudo apt install python3 python3-pip -y
```

**3. Log out and log back in** to apply docker group permissions.

### Quick Install

```bash
curl -sSL https://raw.githubusercontent.com/Jhow-Magnum/cyberskills-lab/main/install.sh | bash
```

### Manual Installation

```bash
git clone https://github.com/Jhow-Magnum/cyberskills-lab.git
cd cyberskills-lab
bash install.sh
```

Access: http://localhost:5000

## Usage

1. Open `http://localhost:5000` in your browser
2. Enter your username
3. Select a lab
4. Solve challenges in the integrated terminal
5. Submit found flags
6. Track your score on the scoreboard

### Install as App (PWA)

- **Chrome/Edge/Brave**: Click the install icon (⊕) in the address bar
- **Firefox**: Menu → Install this site as an app
- **Safari**: Share → Add to Home Screen

### Stop the Platform

```bash
bash ~/cyberskills-lab/stop.sh
```

### Uninstall

```bash
bash ~/cyberskills-lab/uninstall.sh
```

## Project Structure

```
cyberskills-lab/
├── ctf-simple.py        # Flask backend
├── web.html             # Web interface
├── requirements.txt     # Python dependencies
├── install.sh           # Installation script
├── start.sh             # Start platform
├── stop.sh              # Stop platform
├── build-all.sh         # Build Docker images
├── repositories/        # YAML lab definitions
└── scenarios/           # Environment Dockerfiles
```

## Tech Stack

- **Backend**: Flask (Python)
- **Frontend**: HTML5, CSS3, JavaScript
- **Terminal**: xterm.js
- **Containers**: Docker
- **Database**: SQLite
- **WebSocket**: flask-sock

## Troubleshooting

**Port 5000 in use:**
```bash
lsof -ti:5000 | xargs kill -9
```

**Containers not removed:**
```bash
docker ps -a | grep cyberskills | awk '{print $1}' | xargs docker rm -f
```

**Rebuild images:**
```bash
bash build-all.sh
```

## Contributing

1. Fork the project
2. Create a branch (`git checkout -b feature/new-feature`)
3. Commit your changes (`git commit -m 'Description of change'`)
4. Push to the branch (`git push origin feature/new-feature`)
5. Open a Pull Request

## Author

**Jhow Magnum**

- GitHub: [@Jhow-Magnum](https://github.com/Jhow-Magnum)
- LinkedIn: [Jhow Magnum](https://www.linkedin.com/in/jhowmagnum/)

## License

MIT License — see [LICENSE](LICENSE) for details.
