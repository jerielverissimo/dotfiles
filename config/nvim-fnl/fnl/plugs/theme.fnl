(local {: autoload} (require :nfnl.module))
(local nvim (autoload :nvim))

[{1 :rebelot/kanagawa.nvim
  :lazy false
  :priority 1000
  :dependencies [:nvim-tree/nvim-web-devicons]
  :config (fn []
            (let [theme (require :kanagawa)
		  _ (require :hls.stl)]
              (theme.setup {:theme :dragon
			    :background {:dark :dragon}})
              (vim.cmd "colorscheme kanagawa")))}]
