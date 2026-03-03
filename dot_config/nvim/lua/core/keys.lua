-- [nfnl] Compiled from fnl/core/keys.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local nvim = autoload("nvim")
return nvim.set_keymap("n", "<leader>tt", ":NvimTreeToggle<CR>", {noremap = true})
