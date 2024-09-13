#!/usr/bin/env zsh

set -ux
prefix=${1:a}

mkdir -p ~/.config

ln -s $prefix ~/.humus
ln -s $prefix/zsh/zshrc ~/.zshrc
ln -s $prefix/zsh/zshenv ~/.zshenv
mkdir -p $HOME/.config/fish
ln -s $prefix/fish/config.fish ~/.config/fish/config.fish
ln -s $prefix/vim ~/.config/nvim
ln -s $prefix/tmux.conf ~/.tmux.conf
