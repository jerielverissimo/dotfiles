-- [nfnl] Compiled from fnl/plugs/gitsigns-nvim.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  local gitsigns = require("gitsigns")
  return gitsigns.setup({signs = {add = {text = "+"}, change = {text = "~"}, changedelete = {text = "~_"}, delete = {text = "_"}, topdelete = {text = "\226\128\190"}, untracked = {text = "\226\148\134"}}})
end
return {{"lewis6991/gitsigns.nvim", config = _1_}}
