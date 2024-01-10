-- [nfnl] Compiled from fnl/plugs/paredit.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local nvim = autoload("nvim")
local function _2_()
  nvim.g.sexp_filetypes = "clojure,scheme,lisp,timl,fennel,janet,hy"
  return nil
end
local function _3_()
  local surround = require("nvim-surround")
  return surround.setup()
end
return {{"guns/vim-sexp", ft = {"fennel", "clojure", "lisp", "racket", "scheme", "janet", "guile"}, dependencies = {"tpope/vim-sexp-mappings-for-regular-people"}, config = _2_}, {"kylechui/nvim-surround", event = "VeryLazy", config = _3_}, {"windwp/nvim-autopairs", event = "InsertEnter", opts = {}}}
