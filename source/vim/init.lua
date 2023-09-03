vim.opt.filetype = "off"

vim.cmd("map ; :")
vim.cmd("map <C-F> :FZF<CR>")
vim.cmd("nnoremap <C-E> :!%:p")

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.number = true
vim.opt.colorcolumn = nil
vim.opt.syntax = "on"
vim.opt.shell = "/bin/zsh -l -i"

-- " Slime
vim.g.slime_target = "tmux"

-- " Airline
-- vim.g.airline#extensions#tabline#enabled = 1
vim.g.airline_theme = "dark"

-- " Netrw
vim.g.netrw_liststyle = 3
vim.g.netrw_banner = 0
vim.g.netrw_browse_split = 4
vim.g.netrw_altv = 1
vim.g.netrw_winsize = 25

vim.cmd("colorscheme slate")

require('humus')
