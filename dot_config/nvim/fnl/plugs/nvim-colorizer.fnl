(local {: autoload} (require :nfnl.module))
(local nvim (autoload :nvim))

[{1 :NvChad/nvim-colorizer.lua
    :event :BufRead
    :config (fn []
	      (let [colorizer (require :colorizer)]
		(colorizer.setup
		  {:filetypes ["*"]
		  :user_default_options {:AARRGGBB false
		  :RGB true
		  :RRGGBB true
		  :RRGGBBAA true
		  :css true
		  :css_fn false
		  :hsl_fn true
		  :mode :background
		  :names false
		  :rgb_fn true
		  :sass {:enable false
		  :parsers [:css]}
		  :tailwind true
		  :virtualtext "■"}}))

	      (vim.defer_fn (fn []
			      ((. (require :colorizer) :attach_to_buffer) 0))
			    0)	
	      )}]
