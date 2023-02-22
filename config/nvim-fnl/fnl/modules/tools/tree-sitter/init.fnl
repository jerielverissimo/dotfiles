(local treesiter (require :nvim-treesitter.configs))

(local treesitter-filetypes [:comment
                             :help
                             :fennel
                             :vim
                             :regex
                             :query
                             :clojure
                             :rust
                             :dart
                             :javascript
                             :css
                             :scss
                             :vue
                             :java])

(treesiter.setup {:ensure_installed treesitter-filetypes
                  :sync_install true
                  :highlight {:enable true :use_languagetree true}
                  :indent {:enable true}
                  :context_commentstring {:enable true}
                  :refactor {:enable true
                             :keymaps {:smart_rename :<localleader>rn}}
                  :query_linter {:enable true
                                 :use_virtual_text true
                                 :lint_events [:BufWrite :CursorHold]}
                  :rainbow {:enable true
                            :extended_mode true
                            :colors ["#d9b27c"
                                     "#8ca589"
                                     "#998396"
                                     "#d08b65"
                                     "#829e9b"
                                     "#ab9382"
                                     "#dc7575"]}
                  :incremental_selection {:enable true
                                          :keymaps {:init_selection :gnn
                                                    :node_incremental :grn
                                                    :scope_incremental :grc
                                                    :node_decremental :grm}}
                  :textobjects {:select {:enable true}
                                :lookahead true
                                :keymaps {:af "@function.outer"
                                          :if "@function.inner"
                                          :ac "@class.outer"
                                          :ic "@class.inner"}
                                :move {:enable true
                                       :set_jumps true
                                       :goto_next_start {"]m" "@function.outer"
                                                         "]]" "@class.outer"}
                                       :goto_next_end {"]M" "@function.outer"
                                                       "][" "@class.outer"}
                                       :goto_previous_start {"[m" "@function.outer"
                                                             "[[" "@class.outer"}
                                       :goto_previous_end {"[M" "@function.outer"
                                                           "[]" "@class.outer"}}}})
