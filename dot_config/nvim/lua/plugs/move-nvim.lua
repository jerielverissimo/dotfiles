-- [nfnl] fnl/plugs/move-nvim.fnl
local function _1_()
  local m = require("move")
  return m.setup({})
end
return {{"fedepujol/move.nvim", config = _1_}}
