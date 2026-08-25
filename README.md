# Dotfiles & macOS Developer Environment

Automated setup script and Zsh configuration tailored for macOS, Python development, and modern terminal tooling.

---

## 📁 Repository Structure

```text
dotfiles/
├── setup.sh
├── .zshrc
└── README.md
```

---

## 🚀 Quickstart on a Fresh Mac

Open **Terminal.app** and run:

```bash
# 1. Clone your dotfiles into ~/dotfiles
git clone <YOUR_DOTFILES_REPO_URL> ~/dotfiles

# 2. Make the setup script executable and run it
cd ~/dotfiles
chmod +x setup.sh
./setup.sh
```

> **Note:** The script will prompt for your macOS password to install Homebrew and configure your default login shell.

## ⌨️ Shell Shortcuts & Aliases Reference

### 1. Navigation & System

| Alias | Command | Purpose |
| :--- | :--- | :--- |
| `..` | `cd ..` | Go up one directory level |
| `...` | `cd ../..` | Go up two directory levels |
| `....` | `cd ../../..` | Go up three directory levels |
| `~` | `cd ~` | Jump straight to user home directory |
| `dot` | `cd ~/dotfiles` | Jump to your dotfiles directory |
| `reload` | `exec zsh -l` | Hard restart and reload the interactive shell |
| `zshconfig` | `code ~/.zshrc \|\| nano ~/.zshrc` | Open `.zshrc` in VS Code or Nano |
| `myip` | `curl -s https://ipinfo.io/ip` | Print your public IP address |
| `ports` | `lsof -iTCP -sTCP:LISTEN -n -P` | List all local ports actively listening |
| `flushdns` | `sudo dscacheutil ...` | Clear macOS DNS cache |

---

### 2. File Listing (BSD/macOS Colors)

| Alias | Command | Purpose |
| :--- | :--- | :--- |
| `ls` | `ls -G` | Colorized basic directory listing |
| `ll` | `ls -lahG` | Detailed list (permissions, human sizes, hidden files) |
| `la` | `ls -AG` | List all files including hidden, omitting `.` and `..` |
| `l` | `ls -CFG` | Multi-column categorized directory listing |

---

### 3. Git Workflow

| Alias | Command | Purpose |
| :--- | :--- | :--- |
| `gs` | `git status -sb` | Short, branch-aware Git status |
| `ga` | `git add` | Stage specific files (`ga <file>`) |
| `gaa` | `git add -A` | Stage all changes (new, modified, deleted) |
| `gc` | `git commit -m` | Commit with message (`gc "feat: initial commit"`) |
| `gca` | `git commit -a -m` | Stage tracked files and commit with message |
| `gp` | `git push` | Push committed branch to remote |
| `gpl` | `git pull --rebase` | Pull remote changes with clean rebase |
| `gd` | `git diff` | Show unstaged file diffs |
| `gl` | `git log --oneline --graph ...` | Formatted visual commit tree (last 15 commits) |
| `gb` | `git branch` | List local branches |
| `gco` | `git checkout` | Switch branch or checkout file |
| `gcb` | `git checkout -b` | Create and immediately switch to a new branch |

---

### 4. Python, Virtual Environments & Quality

| Alias | Command | Purpose |
| :--- | :--- | :--- |
| `py` | `python3` | Launch default Python 3 interpreter |
| `venv` | `uv venv && source .venv/bin/activate` | Create a fresh virtualenv via `uv` and activate it |
| `activate` | `source .venv/bin/activate` | Activate existing `.venv` in current directory |
| `rf` | `ruff check --fix && ruff format` | Run Ruff linter with auto-fixes and code formatter |
| `pt` | `pytest` | Run test suite via `pytest` |
| `ptv` | `pytest -vv` | Run `pytest` with full verbose output |
| `ptcov` | `pytest --cov=. --cov-report=term-missing` | Run test coverage reporting missing lines |
| `typecheck` | `pyright` | Run static type checking across the project |

---

### 5. Docker & Docker Compose

| Alias | Command | Purpose |
| :--- | :--- | :--- |
| `dps` | `docker ps --format ...` | Clean table view of running containers and ports |
| `dpsa` | `docker ps -a --format ...` | Clean table view of all containers (including stopped) |
| `dstop` | `docker stop $(docker ps -q)` | Stop all currently running Docker containers |
| `dcup` | `docker compose up -d` | Start compose stack in detached background mode |
| `dcdn` | `docker compose down` | Stop and tear down compose stack containers/networks |
| `dcl` | `docker compose logs -f --tail=100` | Follow container logs (last 100 lines) |
| `dprune` | `docker system prune -af --volumes` | Danger: remove all unused containers, images & volumes |

---

## ⚡ Built-in Plugins & Keyboard Shortcuts

* **`Ctrl + R` (via `fzf`):** Interactive, fuzzy-searchable shell history dropdown.
* **`→` (Right Arrow) / `Ctrl + E`:** Accept inline auto-suggestions powered by `zsh-autosuggestions`.
* **`copypath`:** Copies current absolute working path to macOS clipboard.
* **`copyfile <filename>`:** Copies entire file contents directly to macOS clipboard.
* **`p10k configure`:** Re-run the interactive Powerlevel10k prompt configuration wizard at any time.
