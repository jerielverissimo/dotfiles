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
          (set vim.g.conjure#eval#result_register :e)
          (set vim.g.conjure#mapping#log_buf :lo)
          (set vim.g.conjure#mapping#doc_word :K)
          (set vim.g.conjure#extract#tree_sitter#enabled true)
          (set vim.g.conjure#client#clojure#nrepl#test#raw_out true)
          (set vim.g.conjure#client#clojure#nrepl#test#current_form_names ["deftest" "defflow" "defspec"]))}]
