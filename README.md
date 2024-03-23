# Humus

Humus is an Ubuntu-based container image with an opinionated set of software pre-installed.

## Core Components
* Ubuntu LTS
* ZSH with oh-my-zsh
* Vim with plugins
* Tmux

## Local Installation
Requires:
* cmake
* unzip
* gettext

```
HUMUS_PATH="$HOME/opt/humus"

cp -r source $HUMUS_PATH
$HUMUS_PATH/vim/install.sh
$HUMUS_PATH/zsh/install.sh
$HUMUS_PATH/symlink.sh $HUMUS_PATH
```

## Additional Tools

* `exa` for better file system viewing
* `fzf` for fuzzy search
* `rg` for recursive search in files

## Arm Support

```
docker run --privileged --rm tonistiigi/binfmt --install arm64
docker run --rm arm64v8/alpine uname -a
```

## Vim Bindings

Telescope:
* \ff - file path
* \fb - buffer name
* \fg - file content
* \fh - vim commands
* \fs - lsp symbols

* Nagivate panes - Ctrl+W, [hjkl]
