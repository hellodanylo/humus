#!/usr/bin/env zsh

set -eux
prefix=${1:a}

mkdir -p ~/.config

ln -s $prefix ~/.humus
ln -s $prefix/zsh/zshrc ~/.zshrc
ln -s $prefix/zsh/zshenv ~/.zshenv
ln -s $prefix/fish/config.fish ~/.config/fish/config.fish
ln -s $prefix/vim ~/.config/nvim
ln -s $prefix/tmux.conf ~/.tmux.conf
