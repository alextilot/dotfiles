#!/usr/bin/env bash

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# zsh
rm -f ~/.zshrc
ln -s ${BASEDIR}/.zshrc ~/.zshrc
rm -f ~/.zsh_plugins.txt
ln -s ${BASEDIR}/.zsh_plugins.txt ~/.zsh_plugins.txt
rm -f ~/.p10k.zsh
ln -s ${BASEDIR}/.p10k.zsh ~/.p10k.zsh
rm -f ~/.aliases.zsh
ln -s ${BASEDIR}/.aliases.zsh ~/.aliases.zsh

# git
ln -s ${BASEDIR}/.gitconfig ~/.gitconfig

# tmux
ln -s ${BASEDIR}/.tmux.conf ~/.tmux.conf
