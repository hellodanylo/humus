#!/usr/bin/env zsh

set -eux

script_dir=${0:a:h}

VIM_PLUGINS=$script_dir/pack/shell/start
mkdir -p $VIM_PLUGINS

git clone -q -b v3.6 https://github.com/tpope/vim-fugitive.git $VIM_PLUGINS/fugitive
vim -E -u NONE -c "helptags $VIM_PLUGINS/fugitive/doc" -c q

git clone -q -b v2.2 https://github.com/tpope/vim-surround.git $VIM_PLUGINS/surround
vim -E -u NONE -c "helptags $VIM_PLUGINS/surround/doc" -c q

git clone -q -b v1.3 https://github.com/tpope/vim-commentary.git $VIM_PLUGINS/commentary
vim -E -u NONE -c "helptags $VIM_PLUGINS/commentary/doc" -c q

git clone -q https://github.com/jpalardy/vim-slime.git $VIM_PLUGINS/slime
vim -E -u NONE -c "helptags $VIM_PLUGINS/slime/doc" -c q

git clone -q -b 0.42.0 https://github.com/junegunn/fzf.git $VIM_PLUGINS/fzf
vim -E -u NONE -c "helptags $VIM_PLUGINS/fzf/doc" -c q

git clone -q -b v0.11 https://github.com/vim-airline/vim-airline.git $VIM_PLUGINS/vim-airline
git clone -q https://github.com/vim-airline/vim-airline-themes.git $VIM_PLUGINS/vim-airline-themes
vim -E -u NONE -c "helptags $VIM_PLUGINS/vim-airline/doc" -c q

# git clone -q https://github.com/elzr/vim-json.git $script_dir/bundle/vim-json

# git clone -q -b v0.10.2 https://github.com/VundleVim/Vundle.vim.git $script_dir/bundle/Vundle.vim

