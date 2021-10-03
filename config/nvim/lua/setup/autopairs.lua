require("nvim-autopairs").setup()

-- local npairs = require "nvim-autopairs"
-- local Rule = require "nvim-autopairs.rule"

-- OnEnter = function()
--   if vim.fn.pumvisible() == 1 then
--     return vim.fn["compe#confirm"]()
--   else
--     return npairs.check_break_line_char()
--   end
-- end

require("nvim-autopairs.completion.cmp").setup(
  {
    map_cr = true, --  map <CR> on insert mode
    map_complete = true, -- it will auto insert `(` (map_char) after select function or method item
    auto_select = true, -- automatically select the first item
    insert = false, -- use insert confirm behavior instead of replace
    map_char = {
      -- modifies the function or method delimiter by filetypes
      all = "(",
      tex = "{"
    }
  }
)

require("nvim-treesitter.configs").setup {autopairs = {enable = true}}
