#!/usr/bin/env zsh

script_dir=${0:a:h}
ZSH=$script_dir/ohmyzsh

git clone https://github.com/ohmyzsh/ohmyzsh.git $ZSH
cd $ZSH && git checkout 80fa5e137672a529f65a05e396b40f0d133b2432

ln -s $script_dir/alpha.zsh-theme $ZSH/themes
