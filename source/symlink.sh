#!/usr/bin/env zsh

prefix=${1:a}

ln -s $prefix ~/.humus
ln -s $prefix/zsh/zshrc ~/.zshrc
ln -s $prefix/zsh/zshenv ~/.zshenv
ln -s $prefix/vim ~/.vim
ln -s $prefix/vim/vimrc ~/.vimrc
ln -s $prefix/tmux.conf ~/.tmux.conf

mkdir -p $HOME/.config/nvim
ln -s $prefix/vim/nvim $HOME/.config/nvim/init.vim
