-- [nfnl] Compiled from fnl/plugs/todo-comments.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  local todo = require("todo-comments")
  return todo.setup({})
end
return {{"folke/todo-comments.nvim", dependencies = {"nvim-lua/plenary.nvim"}, config = _1_}}
