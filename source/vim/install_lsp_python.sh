#!/usr/bin/env zsh

cd $HUMUS_PATH/vim

node_version="node-v18.17.1-linux-x64"

curl -o - "https://nodejs.org/dist/v18.17.1/$node_version.tar.xz" | tar xfJ -

export PATH="$HUMUS_PATH/vim/$node_version/bin:$PATH"

npm i -g pyright

# todo: make idempotennt
cat - >>$HUMUS_PATH/vim/lua/humus/lspconfig.lua <<EOF
vim.env.PATH = vim.env.HUMUS_PATH .. '/vim/$node_version/bin:' .. vim.env.PATH
require'lspconfig'.pyright.setup{}
EOF
