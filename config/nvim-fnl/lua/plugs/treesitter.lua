-- [nfnl] Compiled from fnl/plugs/treesitter.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  local treesitter = require("nvim-treesitter.configs")
  return treesitter.setup({highlight = {enable = true}, indent = {enable = true}, ensure_installed = {"bash", "clojure", "commonlisp", "dockerfile", "fennel", "html", "java", "javascript", "json", "lua", "markdown", "yaml", "rust", "go"}})
end
return {{"nvim-treesitter/nvim-treesitter", build = ":TSUpdate", config = _1_, lazy = false}}
