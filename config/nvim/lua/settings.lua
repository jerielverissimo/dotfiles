local opt = vim.opt
local g = vim.g

g.mapleader = " "

-- Undo files
opt.undofile = true
opt.undodir = "/home/nomad/.cache"

-- Identation
opt.smartindent = true
opt.autoindent = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.colorcolumn = "80"

-- Set clipboard to use system clipboard
opt.clipboard = "unnamedplus"

-- Use mouse
opt.mouse = "a"

-- Nicer UI settings
opt.termguicolors = true
--opt.cursorline      = true
opt.number = true
opt.relativenumber = true

-- Miscellaneous quality of life
opt.wrap = true
opt.smartcase = true
opt.ttimeoutlen = 5
opt.compatible = false
opt.autoread = true
opt.incsearch = true
opt.hidden = true
opt.shortmess = "atI"
vim.o.completeopt = "menuone,noselect"

vim.o.background = "dark" -- or "light" for light mode
vim.cmd [[colorscheme gruvbox-material]]
-- vim.cmd[[colorscheme gruvbox]]

-- vim.cmd[[let g:indent_blankline_char = '¦']]
vim.o.hlsearch = false
