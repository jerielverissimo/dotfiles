require("nvim-autopairs").setup()

local npairs = require "nvim-autopairs"
local Rule = require "nvim-autopairs.rule"

OnEnter = function()
  if vim.fn.pumvisible() == 1 then
    return vim.fn["compe#confirm"]()
  else
    return npairs.check_break_line_char()
  end
end

require("nvim-autopairs.completion.compe").setup {
  map_cr = true, --  map <CR> on insert mode
  map_complete = true, -- it will auto insert `(` after select function or method item
}

require("nvim-treesitter.configs").setup { autopairs = { enable = true } }
