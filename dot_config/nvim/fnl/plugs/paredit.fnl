(local {: autoload} (require :nfnl.module))
(local nvim (autoload :nvim))

[{1 :guns/vim-sexp
  :ft [:fennel :clojure :lisp :racket :scheme :janet :guile]
  :dependencies [:tpope/vim-sexp-mappings-for-regular-people]
  :config (fn []
            (set nvim.g.sexp_filetypes "clojure,scheme,lisp,timl,fennel,janet,hy"))}

 {1 :kylechui/nvim-surround
 :event "VeryLazy"
  :config (fn []
            (let [surround (require :nvim-surround)]
              (surround.setup)))}

 {1 :windwp/nvim-autopairs
  :event "InsertEnter"
  :opts {}}]
