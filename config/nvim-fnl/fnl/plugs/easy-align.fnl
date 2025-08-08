[{1 :junegunn/vim-easy-align
  :lazy false
  :init (fn []
          ;start interactive EasyAlign in visual mode (e.g. vipga)
          (vim.api.nvim_set_keymap :x :<leader>ea "<Plug>(EasyAlign)" {})
          ;start interactive EasyAlign for a motion/text object (e.g. gaip)
          (vim.api.nvim_set_keymap :n :<leader>ea "<Plug>(EasyAlign)" {})
          ;; align maps {:key value}
          (vim.api.nvim_set_keymap :n "={" "vi{<C-v>$:EasyAlign\\ g/^\\S/<CR>"
                                   {})
          ;; align vectors [a b c]
          (vim.api.nvim_set_keymap :n "=[" "vi[<C-v>$:EasyAlign\\ g/^\\S/<CR>"
                                   {})
          ;; align parentheses (a b c)
          (vim.api.nvim_set_keymap :n "=(" "vi(<C-v>$:EasyAlign\\ g/^\\S/<CR>"
                                   {}))}]
