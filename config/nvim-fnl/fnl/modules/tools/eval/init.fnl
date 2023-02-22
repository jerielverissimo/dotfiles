(import-macros {: let!} :core.lib.macros)

;(let! conjure#client#clojure#nrepl#eval#auto_require false)
;(let! conjure#client#clojure#nrepl#connection#auto_repl#enabled false)
(let! conjure#eval#result_register :e)
(let! conjure#mapping#log_buf :lo)
(let! conjure#mapping#eval_comment_current_form :ece)
(let! conjure#mapping#eval_root_form :ef)
(let! conjure#mapping#eval_comment_current_form :ece)
(let! conjure#mapping#eval_comment_root_form :ecf)

(let! conjure#mapping#doc_word :K)

(let! conjure#extract#tree_sitter#enabled true)

(let! conjure#client#clojure#nrepl#eval#raw_out true)
(let! conjure#client#clojure#nrepl#test#raw_out true)

(let! conjure#client#clojure#nrepl#test#current_form_names
      [:deftest :defflow :defflow-new-system!])

;(let! conjure#client#clojure#nrepl#test#runner :kaocha)
