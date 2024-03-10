#!/usr/bin/env zsh

go install golang.org/x/tools/gopls@latest

cat - >>$HUMUS_PATH/vim/lua/humus/lspconfig.lua <<EOF
require'lspconfig'.gopls.setup{}
EOF
