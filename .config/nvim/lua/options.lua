vim.opt.termguicolors = true
vim.cmd("set signcolumn=yes")

-- Spaces & Tabs {{{
vim.opt.tabstop = 4 -- number of visual spaces per TAB
vim.opt.softtabstop = 4 -- number of spaces in tab when editing
vim.opt.shiftwidth = 4 -- number of spaces to use for autoindent
vim.opt.expandtab = true -- tabs are space
vim.opt.autoindent = true
vim.opt.copyindent = true -- copy indent from the previous line
vim.opt.wrap = false -- copy indent from the previous line
vim.opt.relativenumber = true
-- }}} Spaces & Tabs

-- Clipboard {{{
vim.opt.clipboard = "unnamedplus"
-- }}} Clipboard

-- UI Config {{{
vim.opt.hidden = true
vim.opt.number = true -- show line number
vim.opt.showcmd = true -- show command in bottom bar
vim.opt.cursorline = true -- highlight current line
vim.opt.colorcolumn = "100" -- highlight current line
--vim.opt.cursorline               -- highlight current line
--vim.opt.wildmenu                 -- visual autocomplete for command menu
vim.opt.showmatch = true -- highlight matching brace
vim.opt.laststatus = 2 -- window will always have a status line

-- vim.opt.nobackup = true
-- vim.opt.swapfile = false
vim.o.swapfile = false
-- }}} UI Config

vim.opt.scrolloff = 999

vim.o.completeopt = "menuone,noselect"


vim.diagnostic.config({ virtual_text = false })
