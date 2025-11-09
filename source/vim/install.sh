#!/usr/bin/env zsh

set -eux

script_dir=${0:a:h}

VIM_PLUGINS=$script_dir/pack/shell/start
mkdir -p $VIM_PLUGINS

cd $script_dir

# Detect OS and architecture
os_name=$(uname -s)
arch_name=$(uname -m)

# Normalize OS and architecture identifiers
case "$os_name" in
  Linux*) os="linux" ;;
  Darwin*) os="macos" ;;
  *) echo "Unsupported OS: $os_name" >&2; exit 1 ;;
esac

case "$arch_name" in
  x86_64) arch="x86_64" ;;
  arm64|aarch64) arch="arm64" ;;
  *) echo "Unsupported architecture: $arch_name" >&2; exit 1 ;;
esac

name="nvim-$os-$arch"
file="$name.tar.gz"
wget https://github.com/neovim/neovim/releases/download/v0.11.5/$file
tar xvf $file
rm $file
mv $name neovim

git clone -q -b v3.6 https://github.com/tpope/vim-fugitive.git $VIM_PLUGINS/fugitive
nvim -E -u NONE -c "helptags $VIM_PLUGINS/fugitive/doc" -c q

git clone -q -b v2.2 https://github.com/tpope/vim-surround.git $VIM_PLUGINS/surround
nvim -E -u NONE -c "helptags $VIM_PLUGINS/surround/doc" -c q

git clone -q -b v1.3 https://github.com/tpope/vim-commentary.git $VIM_PLUGINS/commentary
nvim -E -u NONE -c "helptags $VIM_PLUGINS/commentary/doc" -c q

git clone -q https://github.com/jpalardy/vim-slime.git $VIM_PLUGINS/slime
nvim -E -u NONE -c "helptags $VIM_PLUGINS/slime/doc" -c q

git clone -q -b 0.42.0 https://github.com/junegunn/fzf.git $VIM_PLUGINS/fzf
nvim -E -u NONE -c "helptags $VIM_PLUGINS/fzf/doc" -c q

git clone -q -b v0.1.3 https://github.com/nvim-lua/plenary.nvim.git $VIM_PLUGINS/plenary
#vim -E -u NONE -c "helptags $VIM_PLUGINS/plenary/doc" -c q

git clone -q -b 0.1.2 https://github.com/nvim-telescope/telescope.nvim.git $VIM_PLUGINS/telescope
nvim -E -u NONE -c "helptags $VIM_PLUGINS/telescope/doc" -c q

git clone -q -b v0.1.6 https://github.com/neovim/nvim-lspconfig.git $VIM_PLUGINS/lspconfig
nvim -E -u NONE -c "helptags $VIM_PLUGINS/lspconfig/doc" -c q

git clone -q -b v0.9.1 https://github.com/nvim-treesitter/nvim-treesitter.git $VIM_PLUGINS/treesitter
nvim -E -u NONE -c "helptags $VIM_PLUGINS/treesitter/doc" -c q
nvim -E -c "TSInstallSync python rust bash json toml yaml dockerfile javascript typescript" -c q

git clone -q -b v0.11 https://github.com/vim-airline/vim-airline.git $VIM_PLUGINS/airline
git clone -q https://github.com/vim-airline/vim-airline-themes.git $VIM_PLUGINS/airline-themes
nvim -E -u NONE -c "helptags $VIM_PLUGINS/airline/doc" -c q

