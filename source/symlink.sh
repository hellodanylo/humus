#!/usr/bin/env bash

prefix=$1

ln -s $prefix/zsh/zshrc ~/.zshrc
ln -s $prefix/zsh/zshenv ~/.zshenv
ln -s $prefix/vim ~/.vim
ln -s $prefix/vim/vimrc ~/.vimrc
ln -s $prefix/tmux.conf ~/.tmux.conf
