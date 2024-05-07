#!/bin/bash

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# zsh
ln -s ${BASEDIR}/.zshrc ~/.zshrc
ln -s ${BASEDIR}/.zsh_plugins.txt ~/.zsh_plugins.txt
ln -s ${BASEDIR}/.p10k.zsh ~/.p10k.zsh
ln -s ${BASEDIR}/.aliases.zsh ~/.aliases.zsh

# git
ln -s ${BASEDIR}/.gitconfig ~/.gitconfig