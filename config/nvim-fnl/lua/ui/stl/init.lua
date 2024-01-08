-- [nfnl] Compiled from fnl/ui/stl/init.fnl by https://github.com/Olical/nfnl, do not edit.
local function run(STYLE)
  local mode = require("ui.stl.modules.mode")
  local filename = require("ui.stl.modules.filename")
  local branch = require("ui.stl.modules.branch")
  local diff = require("ui.stl.modules.diff")
  local folder = require("ui.stl.modules.folder")
  local position = require("ui.stl.modules.position")
  local diagnostics = require("ui.stl.modules.diagnostics")
  local lsp = require("ui.stl.modules.lsp")
  return table.concat({mode(STYLE), filename(STYLE), branch(), diff(STYLE), "%=", diagnostics(STYLE), (lsp(STYLE) or ""), position(STYLE)})
end
local function setup(STYLE)
  vim.opt.statusline = run(STYLE)
  local function _1_()
    vim.opt.statusline = run(STYLE)
    return nil
  end
  return vim.api.nvim_create_autocmd({"ModeChanged", "CursorHold"}, {callback = _1_})
end
return {run = run, setup = setup}
