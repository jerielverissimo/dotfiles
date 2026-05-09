-- [nfnl] fnl/plugs/eca.fnl
local function _1_()
  local eca = require("eca")
  return eca.setup({})
end
return {{"editor-code-assistant/eca-nvim", dependencies = {"MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim"}, config = _1_}}
