#!/bin/bash
#
# Lab Environment Setup Script
# ----------------------------
# This script configures a development environment with necessary SSH keys,
# API keys, development tools, and project repositories.
#

# ===== VARIABLES TO CUSTOMIZE =====
# SSH Keys
SERVER_PRIVATE_SSH_KEY="[YOUR_SERVER_PRIVATE_SSH_KEY]"
SERVER_PUBLIC_SSH_KEY="[YOUR_SERVER_PUBLIC_SSH_KEY]"
LOCAL_PUBLIC_SSH_KEY="[YOUR_LOCAL_PUBLIC_SSH_KEY]"

# API Keys
DEEPSEEK_API_KEY="[YOUR_DEEPSEEK_API_KEY]"
OPENAI_API_KEY="[YOUR_OPENAI_API_KEY]"

# Git Configuration
GITHUB_USER_EMAIL="[YOUR_GITHUB_USER_EMAIL]"
GITHUB_USER_NAME="[YOUR_GITHUB_USER_NAME]"

# Authentication Keys
WANDB_USER_KEY="[YOUR_WANDB_USER_KEY]"
HUGGINGFACE_USER_KEY="[YOUR_HUGGINGFACE_USER_KEY]"

# Project Repositories
PROJECT_REPOS=(
  "git@github.com:ZihanWang314/RAGEN.git"
  "git@github.com:ZihanWang314/CoE.git"
)

# ===== SSH CONFIGURATION =====
echo "Setting up SSH keys..."
echo -e "$SERVER_PRIVATE_SSH_KEY" >> ~/.ssh/id_rsa
echo -e "$SERVER_PUBLIC_SSH_KEY" >> ~/.ssh/id_rsa.pub
echo -e "$LOCAL_PUBLIC_SSH_KEY" >> ~/.ssh/authorized_keys
chmod 600 ~/.ssh/id_rsa
chmod 644 ~/.ssh/id_rsa.pub
touch ~/.no_auto_tmux

# ===== ENVIRONMENT VARIABLES =====
echo "Setting up environment variables..."
echo -e "DEEPSEEK_API_KEY=$DEEPSEEK_API_KEY\n" >> ~/.bashrc
echo -e "OPENAI_API_KEY=$OPENAI_API_KEY\n" >> ~/.bashrc

# ===== SYSTEM PACKAGES =====
echo "Installing system packages..."
sudo apt-get update
sudo apt-get install build-essential zip unzip screen -y

# ===== GITHUB CONFIGURATION =====
echo "Configuring GitHub access..."
GITHUB_HOST="github.com"
ssh-keyscan -t ed25519 $GITHUB_HOST >> ~/.ssh/known_hosts
git config --global user.email $GITHUB_USER_EMAIL
git config --global user.name $GITHUB_USER_NAME
git config --global pull.rebase true
git config --global credential.helper store

# ===== PLATFORM AUTHENTICATION =====
echo "Setting up platform authentication..."
# Weights & Biases
pip install wandb && wandb login --verify $WANDB_USER_KEY
# Hugging Face
pip install -U "huggingface_hub[cli]"
huggingface-cli login --token $HUGGINGFACE_USER_KEY --add-to-git-credential

# ===== SHELL ALIASES =====
echo "Setting up useful aliases..."
# Git shortcuts
alias gacu='git add . && git commit -m "update" && git push'
echo "alias gacu='git add . && git commit -m \"update\" && git push'" >> ~/.bashrc
alias gbase='git stash && git pull --rebase && git stash pop'
echo "alias gbase='git stash && git pull --rebase && git stash pop'" >> ~/.bashrc

# ===== PROJECT SETUP =====
echo "Setting up project repositories..."
cd ~
for repo in "${PROJECT_REPOS[@]}"; do
  # Extract repo name from URL
  repo_name=$(basename "$repo" .git)
  echo "Setting up $repo_name..."
  
  git clone "$repo"
  cd "$repo_name"
  
  # Run project-specific setup scripts
  if [ "$repo_name" = "RAGEN" ]; then
    bash scripts/setup_ragen.sh
    python scripts/download_data.py
  elif [ "$repo_name" = "CoE" ]; then
    bash scripts/setup.sh
  fi
  
  cd ~
done

echo "Setup complete! Your environment is now ready."
