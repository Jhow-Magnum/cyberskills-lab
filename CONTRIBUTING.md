# Contributing to CYBERSKILLS LAB

Thank you for considering contributing to CYBERSKILLS LAB. This document outlines the process and guidelines for contributing.

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [How to Contribute](#how-to-contribute)
- [Development Setup](#development-setup)
- [Creating New Labs](#creating-new-labs)
- [Submitting Changes](#submitting-changes)
- [Style Guidelines](#style-guidelines)

## Code of Conduct

This project expects all participants to maintain professional and respectful conduct. Be constructive, collaborative, and considerate in all interactions.

## How to Contribute

### Reporting Bugs

Before creating bug reports, check existing issues. Include:

- Clear title and description
- Steps to reproduce
- Expected vs actual behavior
- Environment details (OS, Docker version, Python version)
- Screenshots if applicable

### Suggesting Enhancements

Enhancement suggestions are tracked as GitHub issues. Include:

- Clear title and description
- Use case and rationale
- Possible implementation (optional)

### Contributing Code

Areas where contributions are welcome:

- New labs and challenges
- Bug fixes
- Documentation improvements
- Interface enhancements
- New features

## Development Setup

### Prerequisites

- Docker installed
- Python 3.8+
- Git

### Setup Steps

1. Fork the repository

2. Clone your fork
```bash
git clone https://github.com/YOUR-USERNAME/cyberskills-lab.git
cd cyberskills-lab
```

3. Create a branch
```bash
git checkout -b feature/your-feature-name
```

4. Install dependencies
```bash
pip install -r requirements.txt
```

5. Test your changes
```bash
bash start.sh
# Access http://localhost:5000
```

## Creating New Labs

### Lab Structure

Each lab consists of:

1. YAML definition (`repositories/cyberskills-lab/labs/category-name/lab.yaml`)
2. Dockerfile (`scenarios/category-name/Dockerfile`)
3. Challenge files (scripts, configs, etc.)

### Example Lab Creation

#### 1. Create Lab Directory

```bash
mkdir -p repositories/cyberskills-lab/labs/your-category
mkdir -p scenarios/your-category
```

#### 2. Create YAML Definition

`repositories/cyberskills-lab/labs/your-category/lab.yaml`:

```yaml
name: "Your Lab Name"
description: "Brief description"
duration: 60  # minutes
difficulty: "Medium"
points: 100
challenges:
  - id: "challenge-1"
    title: "Challenge Title"
    description: "Task description"
    flag: "FLAG{your_flag_here}"
    points: 20
```

#### 3. Create Dockerfile

`scenarios/your-category/Dockerfile`:

```dockerfile
FROM ubuntu:22.04

RUN apt-get update && apt-get install -y \
    package1 \
    package2 \
    && rm -rf /var/lib/apt/lists/*

COPY challenges/ /challenges/
WORKDIR /home/ctfuser

CMD ["/bin/bash"]
```

#### 4. Build and Test

```bash
docker build -t cyberskills-lab/your-category scenarios/your-category/
docker run -it cyberskills-lab/your-category
```

## Submitting Changes

### Commit Message Guidelines

Follow Conventional Commits specification:

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

1. Update documentation if needed
2. Test your changes thoroughly
3. Create Pull Request with clear description:

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
```

4. Wait for review
5. Address feedback if requested

## Style Guidelines

### Python Code

- Follow PEP 8
- Use meaningful variable names
- Add docstrings to functions
- Keep functions small and focused

### YAML Files

- Use 2 spaces for indentation
- Keep consistent formatting
- Add comments for complex configurations

### Docker

- Use official base images
- Minimize layers
- Clean up in same RUN command
- Add labels for metadata

### Documentation

- Use clear, concise language
- Include code examples
- Add screenshots when helpful

## Recognition

Contributors will be:

- Listed in the Contributors section
- Mentioned in release notes
- Credited in challenge descriptions (for new labs)

## Questions

- Open a Discussion on GitHub
- Create an Issue
- Contact the maintainer

## License

By contributing, you agree that your contributions will be licensed under the MIT License.

---

Thank you for contributing to CYBERSKILLS LAB.
