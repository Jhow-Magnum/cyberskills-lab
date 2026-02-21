# 🎯 CYBERSKILLS LAB - Cybersecurity Training Platform

<p align="center">
  <img src="assets/banner.png" alt="CyberSkills Lab Banner" width="100%"/>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/version-1.0.0-blue" />
  <img src="https://img.shields.io/badge/status-stable-green" />
  <img src="https://img.shields.io/badge/license-MIT-green" />
  <img src="https://img.shields.io/badge/docker-required-blue" />
  <img src="https://img.shields.io/badge/python-3.8+-blue" />
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black" />
  <img src="https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white" />
  <img src="https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white" />
  <img src="https://img.shields.io/badge/Flask-000000?style=for-the-badge&logo=flask&logoColor=white" />
</p>

**[English](#english) | [Português](README.md)**

---

## 📖 About

**CYBERSKILLS LAB** is an open-source platform featuring interactive laboratories for hands-on training in **Cybersecurity, Penetration Testing, Linux, and Capture The Flag (CTF)** challenges, designed for anyone studying cybersecurity and Linux.

### ✨ Key Features

- ✅ **Self-Hosted**: Runs locally on your machine via Docker
- ✅ **Dynamic Timer**: Each lab has specific duration (60-120 min)
- ✅ **Stop Button**: End your session anytime
- ✅ **Auto-Destruction**: Containers are automatically removed
- ✅ **Integrated Web Terminal**: xterm.js terminal in browser
- ✅ **Web Interface**: Access via browser (port 5000)
- ✅ **User System**: Each person has their own profile
- ✅ **Visual Feedback**: Visual indicators for correct/incorrect answers
- ✅ **Scoreboard**: Ranking with top 20 players
- ✅ **Secret Final Challenge**: Unlocked after completing all labs

## 🎮 Available Scenarios

| Scenario | Challenges | Points | Duration | Difficulty |
|----------|-----------|--------|----------|------------|
| 🐧 Linux Basics | 14 | 280 | 60 min | Easy |
| 🔐 Cryptography | 8 | 190 | 60 min | Easy |
| 🌐 Web Security | 3 | 150 | 90 min | Medium |
| 🌐 Network | 3 | 120 | 90 min | Medium |
| 💻 Code Review | 6 | 150 | 75 min | Medium |
| 🎯 Pentest | 5 | 200 | 120 min | Hard |
| 🏆 Final Challenge | 1 | 100 | 10 min | Legendary |

**Total: 40 challenges | 1190 points**

## 🚀 Quick Installation

### Prerequisites

- **Docker** installed ([Installation Guide](https://docs.docker.com/get-docker/))
- **Linux** (Debian/Ubuntu recommended)
- **Python 3.8+**
- **4GB RAM** minimum
- **10GB** disk space

### Step 1: Install Docker

```bash
curl -fsSL https://get.docker.com | sudo bash
```

### Step 2: Clone Repository

```bash
git clone https://github.com/Jhow-Magnum/cyberskills-lab.git
cd cyberskills-lab
```

### Step 3: Run Installation

```bash
bash install.sh
```

### Step 4: Start Platform

```bash
bash start.sh
```

Access: **http://localhost:5000**

## 📁 Project Structure

```
cyberskills-lab/
├── install.sh              # Installation script
├── start.sh                # Start platform
├── stop.sh                 # Stop platform
├── build-all.sh            # Build all Docker images
├── ctf-simple.py           # Flask backend with WebSocket
├── web.html                # Main web interface
├── requirements.txt        # Python dependencies
├── ctf_scores.db           # SQLite database
├── LICENSE                 # MIT License
├── CONTRIBUTING.md         # Contribution guide
├── MAPA_FLAGS.md           # Map of all flags
├── repositories/           # YAML repository of labs
│   └── ctf-senai/
│       ├── index.yaml      # Labs index
│       └── labs/           # YAML definitions for each lab
│           ├── linux-basic/
│           ├── crypto/
│           ├── web-security/
│           ├── network/
│           ├── code-review/
│           └── pentest/
└── scenarios/              # Dockerfiles for scenarios
    ├── linux-basic/
    ├── crypto/
    ├── web-security/
    ├── network/
    ├── code-review/
    └── pentest/
```

## 🛠️ Useful Commands

```bash
bash start.sh       # Start platform
bash stop.sh        # Stop platform
bash install.sh     # Reinstall dependencies
bash build-all.sh   # Rebuild Docker images
```

## 🔧 Troubleshooting

### Error: Port 5000 in use

```bash
# Find the process
lsof -ti:5000

# Kill the process
lsof -ti:5000 | xargs kill -9

# Or use the script
bash stop.sh
```

### Container won't start

```bash
# Check if images exist
docker images | grep ctf-senai

# Rebuild if necessary
bash build-all.sh
```

### Clean stopped containers

```bash
# Remove all CTF containers
docker ps -a | grep ctf- | awk '{print $1}' | xargs docker rm -f

# Or use the script
bash stop.sh
```

### Docker permission error

```bash
# Add your user to docker group
sudo usermod -aG docker $USER

# Logout and login again
```

### Corrupted database

```bash
# Backup database
cp ctf_scores.db ctf_scores.db.backup

# Remove and restart
rm ctf_scores.db
python3 ctf-simple.py
```

## 🛠️ Tech Stack

- **Backend**: Python 3.8+ with Flask
- **Containerization**: Docker
- **Terminal**: xterm.js with WebSocket
- **Database**: SQLite
- **Frontend**: Vanilla JavaScript + CSS3

## 🤝 Contributing

> 💡 **Contributions and suggestions for improvements are super welcome!**
> 
> This is a constantly evolving project and your help is essential to make it even better.
> Whether reporting bugs, suggesting new labs, improving documentation or contributing code.

Contributions are welcome! See [CONTRIBUTING.md](CONTRIBUTING.md) for details.

### How to Contribute

1. Fork the project
2. Create a branch (`git checkout -b feature/NewLab`)
3. Commit your changes (`git commit -m 'feat: add new lab'`)
4. Push to the branch (`git push origin feature/NewLab`)
5. Open a Pull Request

### Contribution Ideas

- 🆕 New labs (forensics, malware, cloud security)
- 🐛 Bug fixes
- 📚 Documentation improvements
- 🎨 Interface improvements
- 🔧 New features

## 🌟 Roadmap

- [ ] Badge and achievement system
- [ ] Real-time competition mode
- [ ] Digital forensics labs
- [ ] Malware analysis labs
- [ ] Cloud security labs (AWS/Azure)
- [ ] CTFd integration
- [ ] Public API
- [ ] Analytics dashboard
- [ ] Multi-language support

## 📊 Statistics

- **6 Main Labs**
- **40 Total Challenges**
- **1190 Maximum Points**
- **6 Security Categories**
- **100% Open Source**

## 📞 Support and Community

- 🐛 **Issues**: [GitHub Issues](https://github.com/Jhow-Magnum/cyberskills-lab/issues)
- 💬 **Discussions**: [GitHub Discussions](https://github.com/Jhow-Magnum/cyberskills-lab/discussions)
- 📧 **Email**: contact@example.com
- 📖 **Wiki**: [GitHub Wiki](https://github.com/Jhow-Magnum/cyberskills-lab/wiki)

## 👥 Creator & Community

### 🚀 Founded by

**Jhow Magnum** - *Creator and Lead Developer*

- 🐙 GitHub: [@Jhow-Magnum](https://github.com/Jhow-Magnum)
- 💼 LinkedIn: [Jhow Magnum](https://www.linkedin.com/in/jhowmagnum/)

---

### 🤝 Community-Driven Project

This project is **open for contributions** from the cybersecurity community!

**We welcome:**
- 🆕 New labs and challenges
- 🐛 Bug fixes and improvements
- 📚 Documentation enhancements
- 🌍 Translations
- 💡 Feature suggestions

**Want to contribute?** Check our [Contributing Guide](CONTRIBUTING.md)

---

### 🌟 Contributors

Thanks to all contributors who help make CYBERSKILLS LAB better!

<!-- ALL-CONTRIBUTORS-LIST:START -->
<!-- This section is automatically generated -->
<!-- ALL-CONTRIBUTORS-LIST:END -->

## 🙏 Acknowledgments

- Cybersecurity Community
- Project Contributors
- Linux and Open Source Community

## ⭐ Star History

If this project was useful to you, consider giving it a ⭐!

## 📄 License

MIT License - see [LICENSE](LICENSE) for details.

---

<p align="center">
  Made with ❤️ for the Cybersecurity Community
</p>

<p align="center">
  <strong>Version 1.0.0</strong> | 2025
</p>
