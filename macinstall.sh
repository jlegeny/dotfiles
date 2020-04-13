#!/bin/bash -e

DOTFILES="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# Macinstall

## Homebrew

echo "Installing Homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

## POWERLEVEL9K

echo "Installing powerlevel9k..."
brew tap sambadevi/powerlevel9k
brew install powerlevel9k

## Shell Tools

echo "Installing Shell Tools..."
brew install ripgrep fd fzf tldr

## Editors 

echo "Installing Editors..."
brew install nvim 
brew cask install vimr

## Media

echo "Installing media programs..."
brew cask install mpv
brew install dosbox

# Install components from Git

echo "Installing vim-plug..."
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "Installing zsh syntax highligting..."
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Setup

echo "Linking configurations"

mkdir -p "${HOME}/.config/nvim"
ln -s "${DOTFILES}/vim/vimrc" "${HOME}/.config/nvim/init.vim"

ln -s "${DOTFILES}/zsh/zshrc" "${HOME}/.zshrc"
