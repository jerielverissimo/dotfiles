-- [nfnl] Compiled from fnl/ui/init.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  vim.opt.laststatus = 3
  return (require("ui.stl")).setup("minimal")
end
return vim.api.nvim_create_autocmd({"ModeChanged", "CursorHold"}, {callback = _1_})
