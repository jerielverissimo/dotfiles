(local {: autoload} (require :nfnl.module))
(local cmp (autoload :cmp))
(local shared (require :core.lib.shared))

(local cmp-src-menu-items
  {:buffer   "buff"
   :conjure  "conj"
   :nvim_lsp "lsp"
   :vsnip    "vsnp"
   :luasnip  "lsnp"})

(local cmp-srcs
  [{:name :nvim_lsp}
   {:name :conjure}
   {:name :buffer}
   {:name :vsnip}
   {:name :luasnip}])

(fn has-words-before []
  (let [(line col) (unpack (vim.api.nvim_win_get_cursor 0))]
    (and (not= col 0)
         (= (: (: (. (vim.api.nvim_buf_get_lines 0 (- line 1) line true) 1) :sub col col) :match "%s") nil))))

[{1 :hrsh7th/nvim-cmp
  :dependencies [:hrsh7th/cmp-buffer
                 :hrsh7th/cmp-nvim-lsp
                 :hrsh7th/cmp-vsnip
                 :hrsh7th/cmp-path
                 :PaterJason/cmp-conjure
                 :L3MON4D3/LuaSnip
                 :saadparwaiz1/cmp_luasnip
                 :onsails/lspkind.nvim
                 :hrsh7th/cmp-cmdline
                 :hrsh7th/cmp-nvim-lsp-signature-help]
  :config (fn []
            (let [
                  luasnip (require :luasnip)]
              (cmp.setup {:experimental {:ghost_text true}
                          ; :window {:documentation {:border :solid}
                          ;          :completion {:col_offset (- 3)
                          ;                       :side_padding 0
                          ;                       :winhighlight "Normal:NormalFloat,NormalFloat:Pmenu,Pmenu:NormalFloat"}}
                          :view {:entries {:name :custom
                                           :selection_order :near_cursor}}
                          :preselect cmp.PreselectMode.None
                          :snippet {:expand (fn [args]
                                              (luasnip.lsp_expand args.body))}
                          :formatting {:fields {1 :kind 2 :abbr 3 :menu}
                                       :format (fn [entry item]
                                                 (set item.menu
                                                      (or (. cmp-src-menu-items
                                                             entry.source.name)
                                                          ""))
                                                 (set item.kind
                                                      (. shared.codicons
                                                         item.kind))
                                                 item)}
                          :mapping {:<C-p> (cmp.mapping.select_prev_item)
                                    :<C-n> (cmp.mapping.select_next_item)
                                    :<C-b> (cmp.mapping.scroll_docs (- 4))
                                    :<C-f> (cmp.mapping.scroll_docs 4)
                                    :<C-Space> (cmp.mapping.complete)
                                    :<C-e> (cmp.mapping.close)
                                    :<CR> (cmp.mapping.confirm {:behavior cmp.ConfirmBehavior.Insert
                                                                :select true})
                                    :<Tab> (cmp.mapping (fn [fallback]
                                                          (if (cmp.visible)
                                                              (cmp.select_next_item)
                                                              (luasnip.expand_or_jumpable)
                                                              (luasnip.expand_or_jump)
                                                              (has-words-before)
                                                              (cmp.complete)
                                                              :else
                                                              (fallback)))
                                                        {1 :i 2 :s})
                                    :<S-Tab> (cmp.mapping (fn [fallback]
                                                            (if (cmp.visible)
                                                                (cmp.select_prev_item)
                                                                (luasnip.jumpable -1)
                                                                (luasnip.jump -1)
                                                                :else
                                                                (fallback)))
                                                          {1 :i 2 :s})}
                          :snippet {:expand (fn [args]
                                              (luasnip.lsp_expand args.body))}
                          :sources cmp-srcs}))
            ;; Enable command-line completions
            (cmp.setup.cmdline "/"
                               {:mapping (cmp.mapping.preset.cmdline)
                                :sources [{:name :buffer :group_index 1}]})
            ;; Enable search completions
            (cmp.setup.cmdline ":"
                               {:mapping (cmp.mapping.preset.cmdline)
                                :sources [{:name :path}
                                          {:name :cmdline :group_index 1}]}))}]
