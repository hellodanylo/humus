#!/usr/bin/env zsh

script_dir=${0:a:h}
ZSH=$script_dir/ohmyzsh

git clone https://github.com/ohmyzsh/ohmyzsh.git $ZSH
cd $ZSH && git checkout 841f3cb0bb7663fa1062ffc59acb7b4581dc1d0f

ln -s $script_dir/alpha.zsh-theme $ZSH/themes

git clone -b v0.8.5 https://github.com/jeffreytse/zsh-vi-mode \
  $ZSH/custom/plugins/zsh-vi-mode

