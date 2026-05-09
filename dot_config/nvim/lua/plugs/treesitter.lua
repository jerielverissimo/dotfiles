-- [nfnl] fnl/plugs/treesitter.fnl
local function _1_()
  local parsers = {"lua", "fennel", "vim", "vimdoc", "query", "javascript", "typescript", "html", "css", "json", "yaml", "toml", "markdown", "markdown_inline", "bash", "python", "rust", "go", "c"}
  do
    local install = require("nvim-treesitter.install")
    install.ensure_installed = parsers
  end
  local function _2_(args)
    local function _3_()
      vim.treesitter.start(args.buf)
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      return nil
    end
    return pcall(_3_)
  end
  return vim.api.nvim_create_autocmd("FileType", {callback = _2_})
end
return {{"nvim-treesitter/nvim-treesitter", build = ":TSUpdate", dependencies = {"nvim-treesitter/nvim-treesitter-textobjects"}, config = _1_, lazy = false}}
