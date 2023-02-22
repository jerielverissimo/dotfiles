(local cmp (require :cmp))
(local luasnip (require :luasnip))

(tset vim.opt :completeopt [:menu :menuone :noselect])

(local cmp-sources [])

(table.insert cmp-sources {:name :luasnip :group_index 1})
;;(table.insert cmp-sources {:name :buffer :group_index 2})
(table.insert cmp-sources {:name :path :group_index 2})
(table.insert cmp-sources {:name :crates :group_index 1})
(table.insert cmp-sources {:name :conjure :group_index 1})
(table.insert cmp-sources {:name :nvim_lsp :group_index 1})
(table.insert cmp-sources {:name :nvim_lsp_signature_help :group_index 1})

(local icons {:Text "  "
              :Method "  "
              :Function "  "
              :Constructor "  "
              :Field "  "
              :Variable "  "
              :Class "  "
              :Interface "  "
              :Module "  "
              :Property "  "
              :Unit "  "
              :Value "  "
              :Enum "  "
              :Keyword "  "
              :Snippet "  "
              :Color "  "
              :File "  "
              :Reference "  "
              :Folder "  "
              :EnumMember "  "
              :Constant "  "
              :Struct "  "
              :Event "  "
              :Operator "  "
              :TypeParameter "  "})

(cmp.setup {:experimental {:ghost_text true}
            :window {:documentation {:border :solid}
                     :completion {:col_offset (- 3)
                                  :side_padding 0
                                  :winhighlight "Normal:NormalFloat,NormalFloat:Pmenu,Pmenu:NormalFloat"}}
            :view {:entries {:name :custom :selection_order :near_cursor}}
            :enabled (fn []
                       (local context (require :cmp.config.context))
                       (if (= (. (vim.api.nvim_get_mode) :mode) :c) true
                           (and (not (context.in_treesitter_capture :comment))
                                (not (context.in_syntax_group :Comment)))))
            :preselect cmp.PreselectMode.None
            :snippet {:expand (fn [args]
                                (luasnip.lsp_expand args.body))}
            :mapping {:<C-b> (cmp.mapping.scroll_docs -4)
                      :<C-f> (cmp.mapping.scroll_docs 4)
                      :<C-Space> (cmp.mapping.complete)
                      :<C-p> (cmp.mapping.select_prev_item)
                      :<C-n> (cmp.mapping.select_next_item)
                      :<CR> (cmp.mapping.confirm {:behavior cmp.ConfirmBehavior.Insert
                                                  :select false})
                      :<C-e> (fn [fallback]
                               (if (cmp.visible)
                                   (do
                                     (cmp.mapping.close)
                                     (vim.cmd :stopinsert))
                                   (fallback)))}
            :sources cmp-sources
            :formatting {:fields {1 :kind 2 :abbr 3 :menu}
                         :format (fn [_ vim-item]
                                   (set vim-item.menu vim-item.kind)
                                   (set vim-item.kind (. icons vim-item.kind))
                                   vim-item)}})

;; snippets

((. (require :luasnip.loaders.from_vscode) :lazy_load))
