set -euo pipefail

echo "Initial macOS setup for Apple Silicon"

echo "Installing Homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo "Configuring PATH..."

echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >>~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

CLI_PACKAGES=(
  git
  wget
  htop
  python
  node
  tmux
  ripgrep
  virtualenv
  neovim
)

echo "Installing CLI tools..."
brew install ${CLI_PACKAGES[@]}

CASK_APPS=(
  iterm2
  google-chrome
  caffeine
  docker
  chatgpt
  openvpn-connect
  zoom
  lunar
)

echo "Installing applications..."
brew install --cask ${CASK_APPS[@]}

echo "Cleaning up..."

brew cleanup

echo "Setting Python aliases..."
{
  echo ''
  echo '# Python'
  echo 'alias python="python3"'
  echo 'alias pip="pip3"'
} >>~/.zprofile

source ~/.zprofile
mkdir -p ~/.config/nvim
brew install --cask font-fira-code-nerd-font

echo "Configuring Python venv defaults..."

{
  echo ''
  echo '# Python venv defaults'
  echo 'export VIRTUAL_ENV_DISABLE_PROMPT=1'
  echo 'alias mkvenv="python3 -m venv .venv"'
  echo 'alias workon="source .venv/bin/activate"'
} >>~/.zprofile

echo "LazyConfiguring"

mv ~/.config/nvim{,.bak}

mv ~/.local/share/nvim{,.bak}
mv ~/.local/state/nvim{,.bak}
mv ~/.cache/nvim{,.bak}

git clone https://github.com/LazyVim/starter ~/.config/nvim

rm -rf ~/.config/nvim/.git

echo "Setup complete. Restart Terminal to apply environment."
