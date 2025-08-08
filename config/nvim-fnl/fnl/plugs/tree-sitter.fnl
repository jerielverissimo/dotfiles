[{1 :nvim-treesitter/nvim-treesitter
  :build ":TSUpdate"
  :lazy false
  :dependencies [:nvim-treesitter/playground
                 :nvim-treesitter/nvim-treesitter-textobjects
                 :hiphish/rainbow-delimiters.nvim
                 :nvim-treesitter/nvim-treesitter-refactor]
  :config (fn []
(local rainbow-delimiters {:RainbowDelimiterRed {:fg "#878d96"}
                           :RainbowDelimiterYellow {:fg "#a8a8a8"}
                           :RainbowDelimiterBlue {:fg "#8d8d8d"}
                           :RainbowDelimiterOrange {:fg "#a2a9b0"}
                           :RainbowDelimiterGreen {:fg "#8f8b8b"}
                           :RainbowDelimiterViolet {:fg "#ada8a8"}
                           :RainbowDelimiterCyan {:fg "#878d96"}})

(fn load-highlight [group]
  (each [hl col (pairs group)]
    (vim.api.nvim_set_hl 0 hl col)))

(load-highlight rainbow-delimiters)

            (let [treesitter (require :nvim-treesitter.configs)]
              (treesitter.setup {:highlight {:enable true
                                             :use_languagetree true}
                                 :indent {:enable true}
                                 :sync_install true
                                 :context_commentstring {:enable true}
                                 :refactor {:enable true
                                            :keymaps {:smart_rename :<localleader>rn}}
                                 :query_linter {:enable true
                                                :use_virtual_text true
                                                :lint_events [:BufWrite
                                                              :CursorHold]}
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
                                                                          "[]" "@class.outer"}}}
                                 :ensure_installed [:bash
                                                    :clojure
                                                    :commonlisp
                                                    :dockerfile
                                                    :fennel
                                                    :html
                                                    :java
                                                    :javascript
                                                    :json
                                                    :lua
                                                    :markdown
                                                    :yaml
                                                    :rust
                                                    :go
                                                    :query
                                                    :dart
                                                    :comment]})))}]
