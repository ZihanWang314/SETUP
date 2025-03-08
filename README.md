# Machine Learning Development Environment Setup

This repository provides a script to quickly set up a complete development environment for machine learning projects. The script automates common configuration tasks to help you get started with ML development faster.

## What This Script Does

- Sets up SSH keys for secure access
- Configures common API keys (OpenAI, DeepSeek)
- Installs essential development packages
- Sets up Git configuration
- Authenticates with ML platforms (Weights & Biases, Hugging Face)
- Creates useful command shortcuts
- Clones example ML projects to get you started

## Getting Started

### 1. Download the script

```bash
curl -O https://raw.githubusercontent.com/ZihanWang314/SETUP/main/setup.sh
# or download manually and save as setup.sh
```

### 2. Edit the script

Open `setup.sh` in any text editor and update the variables at the top with your information. Feel free to save your keys in any safe places at hand like local `.txt` files.

```bash
# SSH Keys
SERVER_PRIVATE_SSH_KEY="your-private-key"
SERVER_PUBLIC_SSH_KEY="your-public-key"
LOCAL_PUBLIC_SSH_KEY="your-local-public-key"

# API Keys
DEEPSEEK_API_KEY="your-deepseek-key"
OPENAI_API_KEY="your-openai-key"

# Git Configuration
GITHUB_USER_EMAIL="your-email@example.com"
GITHUB_USER_NAME="YourUsername"

# Authentication Keys
WANDB_USER_KEY="your-wandb-key"
HUGGINGFACE_USER_KEY="your-huggingface-key"
```

### 3. Make the script executable and run it

```bash
chmod +x setup.sh
./setup.sh
```

## Customizing for Your Needs

This script is designed to be easily customizable:

- **Add or remove repositories**: Edit the `PROJECT_REPOS` array
- **Skip sections**: Comment out any sections you don't need
- **Add custom tools**: Insert additional installation commands as needed

## Example Projects

The script sets up these example projects:

- **RAGEN**: https://www.github.com/ZihanWang314/RAGEN
- **CoE**: https://www.github.com/ZihanWang314/CoE

You can replace these with your own projects by changing the repository URLs in the script.

## Requirements

- Ubuntu/Debian-based system (e.g., Pytorch 2.2.0 cuda12.1 devel Docker)
- sudo privileges
- Internet connection

## Getting Help

If you encounter issues:

1. Check that all your credentials and SSH keys are correct
2. Ensure you have permissions for any private repositories
3. Verify your system meets the requirements above

## License

MIT
