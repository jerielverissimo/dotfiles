local opt = vim.opt
local g = vim.g

g.mapleader = " "
g.maplocalleader = " "

-- Undo files
opt.undofile = true
opt.undodir = "/Users/jeriel.verissimo/.cache"

-- Identation
opt.smartindent = true
opt.autoindent = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.colorcolumn = "100"
opt.cursorline = true

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

vim.opt.spell = true
vim.opt.spelllang = {"en_us"}

vim.o.background = "dark" -- or "light" for light mode
vim.cmd [[colorscheme gruvbox-material]]
-- vim.cmd[[colorscheme gruvbox]]

-- vim.cmd[[let g:indent_blankline_char = '¦']]
vim.o.hlsearch = false

vim.o.fixendofline = true

vim.g["conjure#client#clojure#nrepl#test#current_form_names"] = {"deftest", "defflow", "defflow-new-system!"}
