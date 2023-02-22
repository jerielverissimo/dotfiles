(import-macros {: set! : map!} :core.lib.macros)

(local ufo (require :ufo))
(local {: openAllFolds : closeAllFolds} ufo)

(set! foldcolumn :1)
(set! foldlevel 99)
(set! foldlevelstart 99)
(set! foldenable true)

(map! [n] :zR `(openAllFolds) {:desc "Open all folds"})
(map! [n] :zM `(closeAllFolds {:desc "Close all folds"}))

(ufo.setup {:provider_selector (fn [bufnr filetype buftype]
                                 [:treesitter :indent])})
