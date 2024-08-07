(local {: autoload} (require :nfnl.module))
(local nvim (autoload :nvim))

[{1 :junegunn/vim-easy-align
    :lazy false
    :init (fn []
	    ;start interactive EasyAlign in visual mode (e.g. vipga)
	    (nvim.set_keymap :x :<leader>ea "<Plug>(EasyAlign)" {})
	    ;start interactive EasyAlign for a motion/text object (e.g. gaip)
	    (nvim.set_keymap :n :<leader>ea "<Plug>(EasyAlign)" {})

      ;; align maps {:key value}
      (nvim.set_keymap :n "={" "vi{<C-v>$:EasyAlign\\ g/^\\S/<CR>" {})
      ;; align vectors [a b c]
      (nvim.set_keymap :n "=[" "vi[<C-v>$:EasyAlign\\ g/^\\S/<CR>" {})
      ;; align parentheses (a b c)
      (nvim.set_keymap :n "=(" "vi(<C-v>$:EasyAlign\\ g/^\\S/<CR>" {})

      )}]
