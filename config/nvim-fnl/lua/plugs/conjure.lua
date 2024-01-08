-- [nfnl] Compiled from fnl/plugs/conjure.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local nvim = autoload("nvim")
local function _2_()
  nvim.g["conjure#mapping#doc_word"] = "K"
  nvim.g["conjure#client#clojure#nrepl#eval#auto_require"] = false
  nvim.g["conjure#client#clojure#nrepl#connection#auto_repl#enabled"] = false
  nvim.g["conjure#client#clojure#nrepl#test#current_form_names"] = {"deftest", "defflow", "defspec"}
  return nil
end
return {{"Olical/conjure", branch = "master", filetypes = {"clojure", "fennel", "janet", "racket", "scheme", "lua", "lisp", "python", "sql"}, filetype = {clojure = "conjure.client.clojure.nrepl", fennel = "conjure.client.fennel.aniseed", janet = "conjure.client.janet.netrepl", racket = "conjure.client.racket.stdio", scheme = "conjure.client.scheme.stdio", lua = "conjure.client.lua.neovim", lisp = "conjure.client.common-lisp.swank", python = "conjure.client.python.stdio", sql = "conjure.client.sql.stdio"}, init = _2_}}
