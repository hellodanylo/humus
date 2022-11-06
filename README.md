# Humus

Humus is an Ubuntu-based container image with an opinionated set of software pre-installed.

## Components:
* Ubuntu LTS
* ZSH with oh-my-zsh
* Vim with plugins
* Tmux

## Local Installation
```
HUMUS_PATH="~/opt/humus"

cp -r source $HUMUS_PATH
$HUMUS_PATH/vim/install.sh
$HUMUS_PATH/zsh/install.sh
$HUMUS_PATH/symlink.sh $HUMUS_PATH
```