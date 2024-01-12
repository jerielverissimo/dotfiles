(local {: autoload} (require :nfnl.module))
(local nvim (autoload :nvim))

[{1 :Olical/conjure
  :branch "master"
  :filetypes [:clojure :fennel :janet :racket :scheme :lua :lisp :python :sql]
  :filetype {:clojure :conjure.client.clojure.nrepl
              :fennel :conjure.client.fennel.aniseed
              :janet :conjure.client.janet.netrepl
              :racket :conjure.client.racket.stdio
              :scheme :conjure.client.scheme.stdio
              :lua :conjure.client.lua.neovim
              :lisp :conjure.client.common-lisp.swank
              :python :conjure.client.python.stdio
              :sql :conjure.client.sql.stdio}
  :init (fn []
          (set nvim.g.conjure#eval#result_register :e)
          (set nvim.g.conjure#mapping#log_buf :lo)
          (set nvim.g.conjure#mapping#doc_word :K)
          (set nvim.g.conjure#extract#tree_sitter#enabled true)
          (set nvim.g.conjure#client#clojure#nrepl#test#raw_out true)
          (set nvim.g.conjure#client#clojure#nrepl#test#current_form_names ["deftest" "defflow" "defspec"]))}]
