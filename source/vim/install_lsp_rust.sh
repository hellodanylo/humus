#!/usr/bin/env zsh

cd $HUMUS_PATH/vim

cat - >>$HUMUS_PATH/vim/lua/humus/lspconfig.lua <<EOF
require('lspconfig')['rust_analyzer'].setup{
    on_attach = on_attach,
    flags = lsp_flags
}
EOF

