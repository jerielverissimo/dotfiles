-- [nfnl] fnl/core/opts.fnl
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local str = autoload("nfnl.string")
local nvim = autoload("nvim")
local core = autoload("nfnl.core")
do
  local options = {encoding = "utf-8", spelllang = "en_us", spell = true, backspace = "2", colorcolumn = "100", errorbells = true, number = true, relativenumber = true, ruler = true, completeopt = "menuone,noselect", wildmenu = true, wildignore = "*/tmp/*,*.so,*.swp,*.zip", ignorecase = true, smartcase = true, clipboard = "unnamedplus", listchars = str.join(",", {"tab:\226\150\182-", "trail:\226\128\162", "extends:\194\187", "precedes:\194\171", "eol:\194\172"}), expandtab = true, tabstop = 2, shiftwidth = 2, softtabstop = 2, undofile = true, splitbelow = true, splitright = true, hlsearch = true, laststatus = 3, numberwidth = 3, conceallevel = 2, concealcursor = "nc", fillchars = str.join(",", {"vert:\226\148\130", "diff:\226\149\177", "foldclose:\239\145\160", "foldopen:\239\145\188", "fold: ", "msgsep:\226\148\128"}), backup = false, list = false, showmode = false, swapfile = false}
  for option, value in pairs(options) do
    core.assoc(nvim.o, option, value)
  end
end
return vim.filetype.add({extension = {mdx = "mdx"}})
