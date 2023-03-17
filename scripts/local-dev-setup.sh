#!/bin/bash

# Detect OS
OS="$(uname)"

# Install common tools
if [ "$OS" == "Darwin" ]; then
  # macOS
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  brew install git docker
elif [ "$OS" == "Linux" ]; then
  # Ubuntu/Debian-based
  sudo apt-get update
  sudo apt-get install -y git docker.io
fi

# Install programming languages and frameworks
brew install node python golang terraform

# Install VS Code
if [ "$OS" == "Darwin" ]; then
  brew install --cask visual-studio-code
elif [ "$OS" == "Linux" ]; then
  sudo snap install --classic code
fi

# Install Oh-My-Zsh, auto-suggestions, and passion custom theme
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
curl -fsSL https://raw.githubusercontent.com/erikgervas/passion-zsh-theme/master/passion.zsh-theme > ~/.oh-my-zsh/custom/themes/passion.zsh-theme

# Configure Oh-My-Zsh
sed -i.bak 's/ZSH_THEME=".*"/ZSH_THEME="passion"/g' ~/.zshrc
echo 'source $ZSH_CUSTOM/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh' >> ~/.zshrc

# Install other utilities
brew install awscli kubectl

# Setup SSH key
if [ ! -f ~/.ssh/id_rsa ]; then
  echo "Please enter your email address for the SSH key:"
  read -r email
  ssh-keygen -t rsa -b 4096 -C "$email"
fi
