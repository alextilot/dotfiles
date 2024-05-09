# dotfiles

Setup and Sync for shell and dotfiles

1. Git [install](https://git-scm.com/downloads)

   - Step 1: Generate Your SSH Key
     ```shell
     ssh-keygen -t rsa -b 4096 -C "example@example.com"
     ```
   - Step 2: Use the Key

     ```shell
     eval $(ssh-agent -s)
     ```

     Then add the key we just generated. If you selected a different path than the default, be sure to replace that path in the command.

     ```shell
     ssh-add ~/.ssh/id_rsa
     ```

   - Step 3: Add the SSH Key on GitHub

     ```shell
     cat ~/.ssh/id_rsa.pub
     ```

2. Obsidian [install](https://obsidian.md/download)
3. WSL2 [install](https://learn.microsoft.com/en-us/windows/wsl/install)
   1. Ubuntu
4. Terminal [source](https://dev.to/contactsunny/installing-zsh-and-oh-my-zsh-on-windows-11-with-wsl2-1p5i)
   1. system update `sudo apt update && sudo apt upgrade`
   2. dotfiles
      Using credential manager
      ```shell
      git clone https://github.com/alextilot/dotfiles.git .dotfiles
      cd .dotfiles
      ./link.sh
      ```
      Using SSH
      ```shell
      git clone git@github.com:alextilot/dotfiles.git ~/.dotfiles
      cd .dotfiles
      ./link.sh
      ```
   3. zsh `sudo apt install zsh`
   4. oh-my-zsh [install](https://ohmyz.sh/#install) `sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"`
   5. zsh plugin manager - [antidote](https://getantidote.github.io/install)
   6. theme - [powerlevel10k](https://github.com/romkatv/powerlevel10k)
   - [install unicode font](https://github.com/romkatv/powerlevel10k#meslo-nerd-font-patched-for-powerlevel10k)
5. Programing Languages
   1. Go
   2. JavaScript
      1. NVM
      2. Node.js
6. Visual Studio Code
7. NeoVim setup:
   1. Follow direction from [nvim repo](https://github.com/alextilot/kickstart.nvim)
   2. Install [Tmux Plugin Manger](https://github.com/tmux-plugins/tpm)
   3. ```shell 
      git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
      ```
