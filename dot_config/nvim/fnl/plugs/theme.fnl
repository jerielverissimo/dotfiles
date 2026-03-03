(local {: autoload} (require :nfnl.module))
(local nvim (autoload :nvim))

[{1 :F4LCn/tasogare.nvim
  :dependencies [:nvim-tree/nvim-web-devicons]
  :config (fn []
            (let [theme (require :tasogare)
		              _ (require :hls.stl)]
              (vim.cmd "colorscheme tasogare")))}]

; [{1 :rebelot/kanagawa.nvim
;   :lazy false
;   :priority 1000
;   :dependencies [:nvim-tree/nvim-web-devicons]
;   :config (fn []
;             (let [theme (require :kanagawa)
; 		  _ (require :hls.stl)]
;               (theme.setup {:theme :dragon
; 			    :background {:dark :dragon}})
;               (vim.cmd "colorscheme kanagawa")))}]

; [{1 :vague2k/vague.nvim
;   :lazy false
;   :priority 1000
;   :dependencies [:nvim-tree/nvim-web-devicons]
;   :config (fn []
;             (let [theme (require :vague)
; 		  _ (require :hls.stl)]
;               (theme.setup {:theme :dragon
; 			    :background {:dark :dragon}})
;               (vim.cmd "colorscheme vague")))}]

; [{1 :jerielverissimo/bearded-theme.nvim
;   :dependencies [:nvim-tree/nvim-web-devicons]
;   :config (fn []
;             (let [theme (require :bearded-theme)]
;               (theme.setup {})
;               (vim.cmd "colorscheme bearded-theme")))}]
