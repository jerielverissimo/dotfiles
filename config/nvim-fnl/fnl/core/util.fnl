(local nvim (require :core.lib.nvim))
(local core (require :core.lib))

(fn insert-keymap [from to]
  (let [map-opts {:noremap true}
        to (.. ":" to :<cr>)]
    (nvim.set_keymap :i from to map-opts)))

(fn nnoremap [from to opts]
  (let [map-opts {:noremap true}
        to (.. ":" to :<cr>)]
    (if (core.get opts :local?)
        (nvim.buf_set_keymap 0 :n from to map-opts)
        (nvim.set_keymap :n from to map-opts))))

(fn lnnoremap [from to]
  (nnoremap (.. :<leader> from) to))

(fn expand [path]
  (nvim.fn.expand path))

(fn glob [path]
  (nvim.fn.glob path true true true))

(fn exists? [path]
  (= (nvim.fn.filereadable path) 1))

(fn lua-file [path]
  (nvim.ex.luafile path))

(local config-path (nvim.fn.stdpath :config))

(fn set-global-option [key value]
  "Sets a nvim global options"
  (core.assoc nvim.o key value))

(fn set-global-variable [key value]
  "Sets a nvim global variables"
  (core.assoc nvim.g key value))

(fn list [value str sep]
  (set-forcibly! sep (or sep ","))
  (set-forcibly! str (or str ""))
  (set-forcibly! value (or (and (= (type value) :table)
                                (table.concat value sep))
                           value))
  (or (and (not= str "") (table.concat [value str] sep)) value))

{: insert-keymap
 : nnoremap
 : lnnoremap
 : expand
 : glob
 : exists?
 : lua-file
 : config-path
 : set-global-option
 : set-global-variable
 : list}
