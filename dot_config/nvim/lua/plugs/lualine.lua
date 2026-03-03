-- [nfnl] fnl/plugs/lualine.fnl
local function _1_()
  local lualine = require("lualine")
  return lualine.setup({options = {component_separators = {left = "", right = ""}, section_separators = {left = "", right = ""}, disabled_filetypes = {"nvim-tree"}, always_divide_middle = false}, sections = {lualine_a = {"mode"}, lualine_b = {"branch", "diff", "diagnostics"}, lualine_c = {"filename"}, lualine_x = {}, lualine_y = {}, lualine_z = {}}})
end
return {{"nvim-lualine/lualine.nvim", dependencies = {"nvim-tree/nvim-web-devicons"}, config = _1_}}
