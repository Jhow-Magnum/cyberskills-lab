# CYBERSKILLS LAB

Open-source cybersecurity training platform with isolated practical environments via Docker.

[![Version](https://img.shields.io/badge/version-1.0.0-blue)](https://github.com/Jhow-Magnum/cyberskills-lab)
[![License](https://img.shields.io/badge/license-MIT-green)](LICENSE)
[![Python](https://img.shields.io/badge/python-3.8+-blue)](https://www.python.org/)
[![Docker](https://img.shields.io/badge/docker-required-blue)](https://www.docker.com/)

[![English](https://img.shields.io/badge/lang-English-red)](README-EN.md)
[![Português](https://img.shields.io/badge/lang-Português-green)](README.md)

**English | [Português](README.md)**

---

## About

CYBERSKILLS LAB is an educational platform for hands-on information security training. It offers 40 challenges across 6 categories, running in isolated Docker containers with integrated web terminal.

### Key Features

- Local execution via Docker
- Integrated web terminal (xterm.js)
- Scoring and ranking system
- Auto-destruction of containers after use
- Responsive interface
- Support for multiple simultaneous users

## Available Labs

| Category | Challenges | Points | Duration | Level |
|----------|-----------|--------|----------|-------|
| Linux Basics | 14 | 280 | 60 min | Beginner |
| Cryptography | 8 | 190 | 60 min | Beginner |
| Web Security | 3 | 150 | 90 min | Intermediate |
| Network Analysis | 3 | 120 | 90 min | Intermediate |
| Code Review | 6 | 150 | 75 min | Intermediate |
| Penetration Testing | 5 | 200 | 120 min | Advanced |
| **Final Challenge** | 1 | 100 | 10 min | Special |

**Total: 40 challenges | 1,190 points**

## System Requirements

- Docker 20.10+
- Python 3.8+
- Linux (Debian/Ubuntu recommended)
- 4GB RAM minimum
- 10GB disk space

## Installation

### 1. Install Docker

```bash
curl -fsSL https://get.docker.com | sudo bash
sudo usermod -aG docker $USER
```

Log out and log back in to apply permissions.

### 2. Clone Repository

```bash
git clone https://github.com/Jhow-Magnum/cyberskills-lab.git
cd cyberskills-lab
```

### 3. Install Dependencies

```bash
bash install.sh
```

### 4. Start Platform

```bash
bash start.sh
```

Access: http://localhost:5000

## Usage

1. Open browser at `http://localhost:5000`
2. Enter your username
3. Select a lab
4. Solve challenges in the integrated terminal
5. Submit found flags
6. Track your score on the scoreboard

### Install as App (PWA)

You can install the platform as an application:

- **Chrome/Edge/Brave**: Click the install icon (⊕) in the address bar
- **Firefox**: Menu → Install this site as an app
- **Safari**: Share → Add to Home Screen

The app will open in its own window without the browser bar.

To stop:
```bash
bash stop.sh
```

## Project Structure

```
cyberskills-lab/
├── ctf-simple.py           # Flask backend
├── web.html                # Web interface
├── requirements.txt        # Python dependencies
├── install.sh              # Installation script
├── start.sh                # Start platform
├── stop.sh                 # Stop platform
├── build-all.sh            # Build Docker images
├── repositories/           # YAML lab definitions
│   └── cyberskills-lab/
│       └── labs/
└── scenarios/              # Environment Dockerfiles
    ├── linux-basic/
    ├── crypto/
    ├── web-security/
    ├── network/
    ├── code-review/
    └── pentest/
```

## Tech Stack

- **Backend**: Flask (Python)
- **Frontend**: HTML5, CSS3, JavaScript
- **Terminal**: xterm.js
- **Containers**: Docker
- **Database**: SQLite
- **WebSocket**: flask-sock

## Troubleshooting

### Port 5000 in use

```bash
lsof -ti:5000 | xargs kill -9
```

### Containers not removed

```bash
docker ps -a | grep cyberskills | awk '{print $1}' | xargs docker rm -f
```

### Rebuild images

```bash
bash build-all.sh
```

## Contributing

Contributions are welcome. Please:

1. Fork the project
2. Create a feature branch (`git checkout -b feature/new-feature`)
3. Commit your changes (`git commit -m 'Add new feature'`)
4. Push to the branch (`git push origin feature/new-feature`)
5. Open a Pull Request

See [CONTRIBUTING.md](CONTRIBUTING.md) for details.

## Roadmap

- Badge and achievement system
- Real-time competition mode
- Digital forensics labs
- Malware analysis labs
- Cloud security labs (AWS/Azure)
- Public REST API
- Analytics dashboard
- Multi-language support

## Author

**Jhow Magnum**

- GitHub: [@Jhow-Magnum](https://github.com/Jhow-Magnum)
- LinkedIn: [Jhow Magnum](https://www.linkedin.com/in/jhowmagnum/)

## License

This project is licensed under the MIT License - see [LICENSE](LICENSE) file for details.

## Acknowledgments

- Information security community
- Project contributors
- Open-source community

---

**Version 1.0.0** | 2026
