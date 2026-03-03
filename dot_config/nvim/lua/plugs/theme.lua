-- [nfnl] fnl/plugs/theme.fnl
local _local_1_ = require("nfnl.module")
local autoload = _local_1_.autoload
local nvim = autoload("nvim")
local function _2_()
  local theme = require("tasogare")
  local _ = require("hls.stl")
  return vim.cmd("colorscheme tasogare")
end
return {{"F4LCn/tasogare.nvim", dependencies = {"nvim-tree/nvim-web-devicons"}, config = _2_}}
