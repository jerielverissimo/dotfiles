-- [nfnl] fnl/plugs/dap-ui.fnl
local function _1_()
  local d = require("dapui")
  return d.setup({})
end
return {{"rcarriga/nvim-dap-ui", dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"}, config = _1_}}
