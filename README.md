# dotfiles

Personal configuration files and setup scripts for a modern development environment.

## 🚀 Quick Start

1. **Clone the repository**:
   ```bash
   git clone git@github.com:alextilot/dotfiles.git ~/.dotfiles
   cd ~/.dotfiles
   ```

2. **Install dependencies**:
   ```bash
   # Install Homebrew first on macOS, then run install script.
   # The install script auto-installs required packages (including stow + fzf).
   brew install stow  # optional preinstall if you prefer
   # or
   sudo apt install stow  # optional preinstall if you prefer
   ```

3. **Run the install script**:
   ```bash
   chmod +x install
   ./install
   ```
   The script installs missing essential packages, then stows selected configs.

## 📁 What's Included

This dotfiles repository includes configurations for:

- **Zsh**: Shell configuration with aliases, functions, and plugins
- **Tmux**: Terminal multiplexer with custom key bindings and themes
- **Git**: Global Git configuration and aliases
- **Bin**: User scripts under `~/.local/bin` (e.g. `dot-update`)

## 🛠 Components

### Zsh Configuration
- **Plugin Manager**: [Antidote](https://getantidote.github.io/) for fast plugin management
- **Theme**: [Powerlevel10k](https://github.com/romkatv/powerlevel10k) for a beautiful prompt
- **Plugins**: Oh My Zsh plugins for Git, Tmux navigation, and more
- **Custom Aliases**: Productivity-focused command shortcuts

### Tmux Configuration
- **Theme**: [Catppuccin](https://github.com/catppuccin/tmux) theme (Mocha flavor)
- **Plugin Manager**: [TPM](https://github.com/tmux-plugins/tpm) for plugin management
- **Vim Integration**: Seamless navigation between Vim and Tmux panes
- **Custom Key Bindings**: Optimized for productivity

### Git Configuration
- Global Git settings and aliases
- Optimized for modern Git workflows

### Neovim (separate)
Neovim config is **not** stowed from this repo. Install the editor via packages (`neovim` in `ESSENTIAL_PACKAGES`), then clone your kickstart fork:

```bash
git clone git@github.com:alextilot/kickstart.nvim.git ~/.config/nvim
# or: https://github.com/alextilot/kickstart.nvim.git
```

## 📋 Prerequisites

### Required
- **Git**: Version control system
- **Stow**: GNU Stow for symlink management
- **Zsh**: Modern shell (will be set as default)

### Optional but Recommended
- **Homebrew** (macOS): Package manager
- **Nerd Font**: For proper icon display in terminal

## 🔧 Manual Setup Steps

### 1. SSH Key Setup (if needed)
```bash
# Generate SSH key
ssh-keygen -t ed25519 -C "your-email@example.com"

# Start ssh-agent and add key
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

# Copy public key to clipboard
cat ~/.ssh/id_ed25519.pub
# Add this key to your GitHub account
```

### 2. Install Dependencies

#### macOS
```bash
# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install required packages
brew install stow git zsh tmux fzf neovim lazygit tree-sitter-cli
```

#### Ubuntu/Debian
```bash
# Update system
sudo apt update && sudo apt upgrade

# Install required packages (build-essential provides the C compiler
# tree-sitter-cli needs to build parsers for nvim-treesitter)
sudo apt install stow git zsh tmux fzf neovim lazygit tree-sitter-cli curl build-essential
```

### 3. Install Zsh Plugins and Theme

`./install` clones these automatically (skip this step). To use a fork or a
different location, set `ANTIDOTE_REPO`/`ANTIDOTE_DIR` or `TPM_REPO`/`TPM_DIR`
before running `./install` (see [Customization](#-customization)).

If you need to install them manually instead:

```bash
# Antidote (zsh plugin manager)
git clone --depth=1 https://github.com/mattmc3/antidote.git ${ZDOTDIR:-~}/.antidote

# TPM (tmux plugin manager)
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

### 4. Install Fonts (Optional)
Download and install a [Nerd Font](https://www.nerdfonts.com/) for better terminal experience:
```bash
# Recommended: JetBrains Mono Nerd Font
brew install font-jetbrains-mono-nerd-font  # macOS
```

## 🎨 Customization

### Environment Variables
You can customize the installation by setting environment variables:

```bash
export DOTFILES="/path/to/your/dotfiles"
export STOW_FOLDERS="git,zsh,tmux,bin"  # Choose which configs to install
export INSTALL_PACKAGES=0  # Optional: skip package/plugin-manager installs and only stow files

# Point at a fork or alternate location for the zsh/tmux plugin managers
export ANTIDOTE_REPO="https://github.com/your-fork/antidote.git"
export ANTIDOTE_DIR="$HOME/.antidote"
export TPM_REPO="https://github.com/your-fork/tpm.git"
export TPM_DIR="$HOME/.tmux/plugins/tpm"
```

### Multiple Machines: Work vs Personal

You can run this repo on as many machines as you like — work laptop, personal
laptop, personal Linux box, whatever — without maintaining separate branches
or forks. Two mechanisms handle the two kinds of "this is different on that
machine" problem:

**1. Self-adapting config (most things).** Files like [zsh/darwin.zsh](zsh/darwin.zsh)
and [zsh/linux.zsh](zsh/linux.zsh) are tracked and shared across every machine
on that OS. Anything that's only relevant on *some* machines (an optional
tool, a corporate CA cert) is guarded by a `command -v` / `[[ -f ]]` / `[[ -d ]]`
check, so the same file is simply a no-op where that tool/file doesn't exist.
Prefer this — no flag to remember, nothing to keep in sync.

**2. Explicit profile (things that genuinely differ by identity).** Set once
per machine via a one-line, gitignored file:

```bash
DOTFILES_PROFILE=work ./install      # or: personal
```

This writes `zsh/profile.local.zsh` (gitignored — never committed), which
`.zshrc` sources first on every shell startup. From there, `.zshrc` sources,
in order:

1. `zsh/profile.local.zsh` — sets `$DOTFILES_PROFILE`
2. `zsh/<os>.zsh` — tracked, shared across every machine on that OS
3. `zsh/<os>.<profile>.zsh` — tracked, e.g. `zsh/darwin.work.zsh` or
   `zsh/linux.personal.zsh`; put non-secret, identity-only aliases/env here
4. `zsh/<os>.local.zsh` — gitignored escape hatch, only for a genuine secret
   that must never be public (rare — most things fit case 1 or 3 above)

**Git identity** (author name/email) already has its own mechanism and needs
no profile flag: [git/.gitconfig](git/.gitconfig) uses
`includeIf "gitdir:~/work/"` to load `~/.gitconfig-work` for anything under
`~/work/`, and `~/.gitconfig-personal` everywhere else. Neither of those
files is tracked — create them once per machine with your `user.name`/
`user.email`.

### Adding New Configurations
1. Create a new directory in the dotfiles repo
2. Add your configuration files
3. Update the `STOW_FOLDERS` variable in the install script
4. Run `./install` to apply changes

## 🔄 Updating

Update OS packages (brew on macOS, apt on Linux), antidote (zsh plugins), TPM (tmux plugins), neovim vim.pack plugins, and pull this repo:

```bash
dot-update
# or: dotupdate
```

After pulling config changes that need re-stowing:

```bash
cd ~/.dotfiles
./install
```

## 📚 Additional Resources

- [Stow Manual](https://www.gnu.org/software/stow/manual/stow.html)
- [Antidote Documentation](https://getantidote.github.io/)
- [Powerlevel10k Configuration](https://github.com/romkatv/powerlevel10k#configuration)
- [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm)

## 🐛 Troubleshooting

### Common Issues

**`compdef` command not found**:
Make sure your `.zshrc` includes:
```bash
autoload -Uz compinit
compinit
```

**Stow conflicts**:
If stow reports conflicts, backup existing files:
```bash
mv ~/.gitconfig ~/.gitconfig.backup
./install
```

**Tmux plugins not loading**:
After first tmux setup, press `prefix + I` to install plugins.

## 📄 License

This project is open source and available under the [MIT License](LICENSE).
