-- [nfnl] Compiled from fnl/plugs/nvim-colorizer.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local nvim = autoload("nvim")
local function _2_()
  do
    local colorizer = require("colorizer")
    colorizer.setup({filetypes = {"*"}, user_default_options = {RGB = true, RRGGBB = true, RRGGBBAA = true, css = true, hsl_fn = true, mode = "background", rgb_fn = true, sass = {parsers = {"css"}, enable = false}, tailwind = true, virtualtext = "\226\150\160", AARRGGBB = false, css_fn = false, names = false}})
  end
  local function _3_()
    return (require("colorizer")).attach_to_buffer(0)
  end
  return vim.defer_fn(_3_, 0)
end
return {{"NvChad/nvim-colorizer.lua", event = "BufRead", config = _2_}}
