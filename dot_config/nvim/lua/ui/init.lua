-- [nfnl] fnl/ui/init.fnl
local function _1_()
  vim.opt.laststatus = 3
  return require("ui.stl").setup("minimal")
end
return vim.api.nvim_create_autocmd({"ModeChanged", "CursorHold"}, {callback = _1_})
