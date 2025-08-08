local function _1_()
  vim.g["conjure#eval#result_register"] = "e"
  vim.g["conjure#mapping#log_buf"] = "lo"
  vim.g["conjure#mapping#doc_word"] = "K"
  vim.g["conjure#extract#tree_sitter#enabled"] = true
  vim.g["conjure#client#clojure#nrepl#test#raw_out"] = true
  vim.g["conjure#client#clojure#nrepl#test#current_form_names"] = {"deftest", "defflow", "defspec"}
  return nil
end
return {{"Olical/conjure", branch = "master", filetypes = {"clojure", "fennel", "janet", "racket", "scheme", "lua", "lisp", "python", "sql"}, filetype = {clojure = "conjure.client.clojure.nrepl", fennel = "conjure.client.fennel.aniseed", janet = "conjure.client.janet.netrepl", racket = "conjure.client.racket.stdio", scheme = "conjure.client.scheme.stdio", lua = "conjure.client.lua.neovim", lisp = "conjure.client.common-lisp.swank", python = "conjure.client.python.stdio", sql = "conjure.client.sql.stdio"}, init = _1_}}