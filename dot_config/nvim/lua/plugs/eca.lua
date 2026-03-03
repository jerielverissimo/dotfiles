-- [nfnl] fnl/plugs/eca.fnl
local function _1_()
  local eca = require("eca")
  return eca.setup({})
end
return {{dependencies = {"MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim"}, config = _1_, "editor-code-assistant/eca-nvim"}}
