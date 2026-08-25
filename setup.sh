#!/usr/bin/env bash

set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

echo "==> [1/6] Installing Homebrew, system tools, VS Code, and Docker..."
if ! command -v brew >/dev/null 2>&1; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
brew update
brew install git curl zsh fzf fontconfig uv

# Install GUI Applications via Homebrew Cask
CASKS=(
    "visual-studio-code|/Applications/Visual Studio Code.app"
    "docker|/Applications/Docker.app"
)

for entry in "${CASKS[@]}"; do
    cask="${entry%%|*}"
    app_path="${entry##*|}"
    if [ ! -d "$app_path" ]; then
        echo "Installing $cask..."
        brew install --cask "$cask"
    fi
done

echo "==> [2/6] Installing MesloLGS Nerd Font..."
FONT_DIR="$HOME/Library/Fonts"
mkdir -p "$FONT_DIR"

MESLO_FONTS=(
    "MesloLGS NF Regular.ttf|https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf"
    "MesloLGS NF Bold.ttf|https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf"
    "MesloLGS NF Italic.ttf|https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf"
    "MesloLGS NF Bold Italic.ttf|https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf"
)

for item in "${MESLO_FONTS[@]}"; do
    filename="${item%%|*}"
    url="${item##*|}"
    if [ ! -f "$FONT_DIR/$filename" ]; then
        echo "Downloading $filename..."
        curl -fsSL "$url" -o "$FONT_DIR/$filename"
    fi
done

echo "==> [3/6] Installing Oh My Zsh..."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

echo "==> [4/6] Installing Powerlevel10k and Zsh Plugins..."
CLONE_REPOS=(
    "https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k"
    "https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions"
    "https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
)

for repo in "${CLONE_REPOS[@]}"; do
    url="${repo%% *}"
    dest="${repo#* }"
    if [ ! -d "$dest" ]; then
        git clone --depth=1 "$url" "$dest"
    fi
done

echo "==> [5/6] Symlinking .zshrc..."
if [ -f "$HOME/.zshrc" ] && [ ! -L "$HOME/.zshrc" ]; then
    mv "$HOME/.zshrc" "$HOME/.zshrc.backup.$(date +%s)"
fi
ln -sf "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"

echo "==> [6/6] Configuring Terminal.app and default shell..."
osascript -e 'tell application "Terminal" to set font name of current settings of selected tab of front window to "MesloLGS-NF-Regular"' 2>/dev/null || true
osascript -e 'tell application "Terminal" to set font size of current settings of selected tab of front window to 12' 2>/dev/null || true

if [ "$SHELL" != "$(which zsh)" ]; then
    chsh -s "$(which zsh)"
fi

echo "================================================================="
echo " Setup complete! Launching fully loaded Zsh session..."
echo "================================================================="

exec zsh -l