-- [nfnl] fnl/plugs/comment.fnl
local function _1_()
  local c = require("Comment")
  return c.setup({})
end
return {{"numToStr/Comment.nvim", config = _1_, lazy = false}}
