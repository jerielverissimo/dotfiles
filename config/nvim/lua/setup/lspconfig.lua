require("lspconfig").tsserver.setup {}
require("lspconfig").clangd.setup {}
-- VimL (full circle!)
require("lspconfig").vimls.setup {}
-- nvim_lsp object
local lsp_status = require("lsp-status")
lsp_status.register_progress()
local nvim_lsp = require "lspconfig"
local configs = require "lspconfig/configs"

require "lspconfig".solargraph.setup {}

-- snippet support
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {"documentation", "detail", "additionalTextEdits"}
}

-- Enable rust_analyzer
nvim_lsp.rust_analyzer.setup {
  capabilities = capabilities,
  settings = {
    ["rust-analyzer"] = {
      cargo = {loadOutDirsFromCheck = true},
      procMacro = {enable = true}
    }
  }
}

local opts = {
  tools = {
    autoSetHints = true,
    hover_with_actions = true,
    runnables = {
      use_telescope = true
    },
    inlay_hints = {
      show_parameter_hints = false,
      parameter_hints_prefix = "",
      other_hints_prefix = ""
    }
  },
  server = {} -- rust-analyer options
}
require("rust-tools").setup(opts)

require "lspconfig".html.setup {
  capabilities = capabilities
}

configs.emmet_ls = {
  default_config = {
    cmd = {"emmet-ls", "--stdio"},
    filetypes = {"html", "css", "scss"},
    root_dir = function()
      return vim.loop.cwd()
    end,
    settings = {}
  }
}

nvim_lsp.emmet_ls.setup {
  on_attach = on_attach
}

require "lspconfig".crystalline.setup {}

require "lspconfig".gopls.setup {}

-- LSP Enable diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] =
  vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics,
  {
    virtual_text = true,
    underline = true,
    signs = true,
    severity_sort = true,
    update_in_insert = false
  }
)

vim.fn.sign_define(
  "LspDiagnosticsSignError",
  {texthl = "LspDiagnosticsSignError", text = "", numhl = "LspDiagnosticsSignError"}
)
vim.fn.sign_define(
  "LspDiagnosticsSignWarning",
  {texthl = "LspDiagnosticsSignWarning", text = "", numhl = "LspDiagnosticsSignWarning"}
)
vim.fn.sign_define(
  "LspDiagnosticsSignHint",
  {texthl = "LspDiagnosticsSignHint", text = "", numhl = "LspDiagnosticsSignHint"}
)
vim.fn.sign_define(
  "LspDiagnosticsSignInformation",
  {texthl = "LspDiagnosticsSignInformation", text = "", numhl = "LspDiagnosticsSignInformation"}
)

-- symbols for autocomplete
vim.lsp.protocol.CompletionItemKind = {
  "   (Text) ",
  "   (Method)",
  "   (Function)",
  "   (Constructor)",
  " ﴲ  (Field)",
  "[] (Variable)",
  "   (Class)",
  " ﰮ  (Interface)",
  "   (Module)",
  " 襁 (Property)",
  "   (Unit)",
  "   (Value)",
  " 練 (Enum)",
  "   (Keyword)",
  "   (Snippet)",
  "   (Color)",
  "   (File)",
  "   (Reference)",
  "   (Folder)",
  "   (EnumMember)",
  " ﲀ  (Constant)",
  " ﳤ  (Struct)",
  "   (Event)",
  "   (Operator)",
  "   (TypeParameter)"
}

vim.lsp.diagnostic.show_line_diagnostics()
