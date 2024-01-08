-- [nfnl] Compiled from fnl/plugs/theme.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local nvim = autoload("nvim")
local function _2_()
  local theme = require("kanagawa")
  local _ = require("hls.stl")
  theme.setup({theme = "dragon", background = {dark = "dragon"}})
  return vim.cmd("colorscheme kanagawa")
end
return {{"rebelot/kanagawa.nvim", priority = 1000, dependencies = {"nvim-tree/nvim-web-devicons"}, config = _2_, lazy = false}}
