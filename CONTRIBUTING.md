# 🤝 Contributing to CYBERSKILLS LAB

First off, thank you for considering contributing to CYBERSKILLS LAB! It's people like you that make this platform a great learning resource for the cybersecurity community.

## 📋 Table of Contents

- [Code of Conduct](#code-of-conduct)
- [How Can I Contribute?](#how-can-i-contribute)
- [Development Setup](#development-setup)
- [Creating New Labs](#creating-new-labs)
- [Submitting Changes](#submitting-changes)
- [Style Guidelines](#style-guidelines)

## 📜 Code of Conduct

This project and everyone participating in it is governed by respect and professionalism. By participating, you are expected to uphold this code.

**Be respectful, be constructive, be collaborative.**

## 🎯 How Can I Contribute?

### 🆕 Creating New Labs

We're always looking for new challenges! You can contribute:

- **New categories**: Forensics, Malware Analysis, Cloud Security, etc.
- **New challenges**: Add challenges to existing categories
- **Difficulty levels**: Easy, Medium, Hard, Expert

### 🐛 Reporting Bugs

Before creating bug reports, please check existing issues. When creating a bug report, include:

- **Clear title and description**
- **Steps to reproduce**
- **Expected vs actual behavior**
- **Environment details** (OS, Docker version, Python version)
- **Screenshots** if applicable

### 💡 Suggesting Enhancements

Enhancement suggestions are tracked as GitHub issues. When creating an enhancement suggestion, include:

- **Clear title and description**
- **Use case** - why is this enhancement useful?
- **Possible implementation** (optional)

### 📚 Improving Documentation

- Fix typos or clarify existing documentation
- Add examples and tutorials
- Translate documentation to other languages
- Create video tutorials or blog posts

## 🛠️ Development Setup

### Prerequisites

- Docker installed
- Python 3.8+
- Git

### Setup Steps

1. **Fork the repository**

2. **Clone your fork**
```bash
git clone https://github.com/YOUR-USERNAME/cyberskills-lab.git
cd cyberskills-lab
```

3. **Create a branch**
```bash
git checkout -b feature/your-feature-name
```

4. **Install dependencies**
```bash
pip install -r requirements.txt
```

5. **Test your changes**
```bash
bash start.sh
# Access http://localhost:5000
```

## 🎮 Creating New Labs

### Lab Structure

Each lab consists of:

1. **YAML definition** (`repositories/ctf-senai/labs/category-name/lab.yaml`)
2. **Dockerfile** (`scenarios/category-name/Dockerfile`)
3. **Challenge files** (scripts, configs, etc.)

### Example: Creating a New Lab

#### 1. Create Lab Directory

```bash
mkdir -p repositories/ctf-senai/labs/your-category
mkdir -p scenarios/your-category
```

#### 2. Create YAML Definition

`repositories/ctf-senai/labs/your-category/lab.yaml`:

```yaml
name: "Your Lab Name"
description: "Brief description of what students will learn"
duration: 60  # minutes
difficulty: "Medium"
points: 100
challenges:
  - id: "challenge-1"
    title: "Challenge Title"
    description: "What the student needs to do"
    flag: "FLAG{your_flag_here}"
    points: 20
    hints:
      - "First hint (costs 5 points)"
      - "Second hint (costs 5 points)"
```

#### 3. Create Dockerfile

`scenarios/your-category/Dockerfile`:

```dockerfile
FROM ubuntu:22.04

# Install required packages
RUN apt-get update && apt-get install -y \
    package1 \
    package2 \
    && rm -rf /var/lib/apt/lists/*

# Add challenge files
COPY challenges/ /challenges/

# Setup environment
RUN useradd -m ctfuser
WORKDIR /home/ctfuser

CMD ["/bin/bash"]
```

#### 4. Update Index

Add your lab to `repositories/ctf-senai/index.yaml`:

```yaml
labs:
  - id: "your-category"
    name: "Your Category Name"
    path: "labs/your-category/lab.yaml"
    icon: "🎯"
```

#### 5. Build and Test

```bash
# Build Docker image
docker build -t ctf-senai/your-category scenarios/your-category/

# Test locally
docker run -it ctf-senai/your-category
```

## 📤 Submitting Changes

### Commit Message Guidelines

Follow the [Conventional Commits](https://www.conventionalcommits.org/) specification:

```
feat: add new forensics lab
fix: correct flag validation in crypto lab
docs: update installation instructions
style: format code according to PEP8
refactor: reorganize lab structure
test: add tests for web security challenges
chore: update dependencies
```

### Pull Request Process

1. **Update documentation** if needed
2. **Test your changes** thoroughly
3. **Update CHANGELOG.md** (if applicable)
4. **Create Pull Request** with clear description:

```markdown
## Description
Brief description of changes

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Documentation update
- [ ] New lab/challenge

## Testing
How did you test your changes?

## Screenshots (if applicable)
Add screenshots here
```

5. **Wait for review** - maintainers will review your PR
6. **Address feedback** if requested
7. **Celebrate** when merged! 🎉

## 🎨 Style Guidelines

### Python Code

- Follow **PEP 8**
- Use **meaningful variable names**
- Add **docstrings** to functions
- Keep functions **small and focused**

### YAML Files

- Use **2 spaces** for indentation
- Keep **consistent formatting**
- Add **comments** for complex configurations

### Docker

- Use **official base images**
- **Minimize layers**
- **Clean up** in same RUN command
- Add **labels** for metadata

### Documentation

- Use **clear, concise language**
- Include **code examples**
- Add **screenshots** when helpful
- Support **both English and Portuguese**

## 🏆 Recognition

Contributors will be:

- ✅ Listed in the **Contributors** section
- ✅ Mentioned in **release notes**
- ✅ Credited in **challenge descriptions** (for new labs)

## 💬 Questions?

- 💬 Open a [Discussion](https://github.com/Jhow-Magnum/cyberskills-lab/discussions)
- 🐛 Create an [Issue](https://github.com/Jhow-Magnum/cyberskills-lab/issues)
- 📧 Contact the maintainer

## 📄 License

By contributing, you agree that your contributions will be licensed under the MIT License.

---

<p align="center">
  <strong>Thank you for contributing to CYBERSKILLS LAB!</strong><br>
  Together we're building a better cybersecurity learning platform 🚀
</p>
