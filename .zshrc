# ----------------------------------------------------------------------
# 1. Powerlevel10k Instant Prompt (Keep at very top of .zshrc)
# ----------------------------------------------------------------------
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ----------------------------------------------------------------------
# 2. Python & uv Environment Path
# ----------------------------------------------------------------------
export PATH="$HOME/.local/bin:$PATH"

# ----------------------------------------------------------------------
# 3. Oh My Zsh Initialization & Plugins
# ----------------------------------------------------------------------
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Enabled plugins (syntax-highlighting must be loaded last)
plugins=(
    git
    docker
    docker-compose
    macos
    copypath
    copyfile
    zsh-autosuggestions
    zsh-syntax-highlighting
)

source "$ZSH/oh-my-zsh.sh"

# ----------------------------------------------------------------------
# 4. fzf Keybindings (Interactive Ctrl + R History Search)
# ----------------------------------------------------------------------
if command -v fzf >/dev/null 2>&1; then
    source <(fzf --zsh)
fi

# ----------------------------------------------------------------------
# 5. History Management
# ----------------------------------------------------------------------
HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=50000

setopt EXTENDED_HISTORY          # Write timestamps to history
setopt SHARE_HISTORY             # Share history across terminal tabs
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first
setopt HIST_IGNORE_DUPS          # Ignore immediate duplicates
setopt HIST_IGNORE_ALL_DUPS      # Delete older duplicate entries
setopt HIST_FIND_NO_DUPS         # Do not display duplicates when searching
setopt HIST_IGNORE_SPACE         # Ignore commands starting with a space
setopt HIST_SAVE_NO_DUPS         # Do not write duplicate entries to file

# ----------------------------------------------------------------------
# 6. Native BSD/macOS `ls` Colors & Listing Aliases
# ----------------------------------------------------------------------
export CLICOLOR=1
export LSCOLORS="Gxfxcxdxbxegedabagacad"

alias ls="ls -G"
alias ll="ls -lahG"
alias la="ls -AG"
alias l="ls -CFG"

# ----------------------------------------------------------------------
# 7. Navigation & Productivity Aliases
# ----------------------------------------------------------------------
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias ~="cd ~"
alias dot="cd ~/dotfiles"

# Quick Config Editing & Shell Reload
alias reload="exec zsh -l"
alias zshconfig="code ~/.zshrc || nano ~/.zshrc"

# Network & macOS Helpers
alias myip="curl -s https://ipinfo.io/ip"
alias ports="lsof -iTCP -sTCP:LISTEN -n -P"
alias flushdns="sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder"

# ----------------------------------------------------------------------
# 8. Git Shortcuts
# ----------------------------------------------------------------------
alias gs="git status -sb"
alias ga="git add"
alias gaa="git add -A"
alias gc="git commit -m"
alias gca="git commit -a -m"
alias gp="git push"
alias gpl="git pull --rebase"
alias gd="git diff"
alias gl="git log --oneline --graph --decorate -n 15"
alias gb="git branch"
alias gco="git checkout"
alias gcb="git checkout -b"

# ----------------------------------------------------------------------
# 9. Python & Virtualenv Shortcuts
# ----------------------------------------------------------------------
alias py="python3"
alias venv="uv venv && source .venv/bin/activate"
alias activate="source .venv/bin/activate"

# Testing, Linting & Typing
alias rf="ruff check --fix && ruff format"
alias pt="pytest"
alias ptv="pytest -vv"
alias ptcov="pytest --cov=. --cov-report=term-missing"
alias typecheck="pyright"

# ----------------------------------------------------------------------
# 10. Docker & Docker Compose Shortcuts
# ----------------------------------------------------------------------
alias dps="docker ps --format 'table {{.Names}}\t{{.Status}}\t{{.Ports}}'"
alias dpsa="docker ps -a --format 'table {{.Names}}\t{{.Status}}\t{{.Ports}}'"
alias dstop="docker stop \$(docker ps -q)"
alias dcup="docker compose up -d"
alias dcdn="docker compose down"
alias dcl="docker compose logs -f --tail=100"
alias dprune="docker system prune -af --volumes"

# ----------------------------------------------------------------------
# 11. Load Powerlevel10k Custom Config (if present)
# ----------------------------------------------------------------------
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh