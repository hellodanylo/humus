vim.opt.showcmd = true
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex);
vim.keymap.set("n", "<C-n>", vim.cmd.tabnew);
vim.keymap.set("n", "<C-x>", vim.cmd.tabclose);
vim.keymap.set("n", "<C-[>", vim.cmd.tabprev);
vim.keymap.set("n", "<C-]>", vim.cmd.tabnext);

vim.keymap.set("v", "K", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "J", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

require('humus.treesitter')
require('humus.telescope')
require('humus.lspconfig')
