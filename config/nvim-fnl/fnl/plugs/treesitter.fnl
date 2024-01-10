[{1 :nvim-treesitter/nvim-treesitter
    :build ":TSUpdate"
    :lazy false
    :dependencies [:nvim-treesitter/playground
                   :nvim-treesitter/nvim-treesitter-textobjects]
    :config (fn []
              (let [treesitter (require :nvim-treesitter.configs)]
                (treesitter.setup {:highlight {:enable true :use_languagetree true}
                                  :indent {:enable true}
                                  :sync_install true
                                  :context_commentstring {:enable true}
                                  :refactor {:enable true
                                  :keymaps {:smart_rename :<localleader>rn}}
                                  :query_linter {:enable true
                                  :use_virtual_text true
                                  :lint_events [:BufWrite :CursorHold]}
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
                                                      :query]})))}]
