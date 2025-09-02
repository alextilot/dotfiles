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
   # Install stow (required for symlinking)
   brew install stow  # macOS
   # or
   sudo apt install stow  # Ubuntu/Debian
   ```

3. **Run the install script**:
   ```bash
   chmod +x install
   ./install
   ```

## 📁 What's Included

This dotfiles repository includes configurations for:

- **Zsh**: Shell configuration with aliases, functions, and plugins
- **Tmux**: Terminal multiplexer with custom key bindings and themes
- **Git**: Global Git configuration and aliases
- **Neovim**: Modern Vim configuration (kickstart.nvim based)

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

### Neovim Configuration
- Based on [kickstart.nvim](https://github.com/alextilot/kickstart.nvim)
- Modern Lua configuration
- LSP support and plugin ecosystem

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
brew install stow zsh git
```

#### Ubuntu/Debian
```bash
# Update system
sudo apt update && sudo apt upgrade

# Install required packages
sudo apt install stow zsh git curl
```

### 3. Install Zsh Plugins and Theme

#### Install Antidote
```bash
git clone --depth=1 https://github.com/mattmc3/antidote.git ${ZDOTDIR:-~}/.antidote
```

#### Install Tmux Plugin Manager
```bash
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
export STOW_FOLDERS="git,zsh,tmux,nvim"  # Choose which configs to install
```

### Adding New Configurations
1. Create a new directory in the dotfiles repo
2. Add your configuration files
3. Update the `STOW_FOLDERS` variable in the install script
4. Run `./install` to apply changes

## 🔄 Updating

To update your dotfiles:

```bash
cd ~/.dotfiles
git pull
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
