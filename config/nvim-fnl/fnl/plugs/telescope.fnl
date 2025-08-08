[{1 :nvim-telescope/telescope.nvim
  :dependencies [:nvim-telescope/telescope-ui-select.nvim
                 :nvim-telescope/telescope-ui-select.nvim
                 :nvim-telescope/telescope-file-browser.nvim
                 :nvim-telescope/telescope-media-files.nvim
                 :nvim-telescope/telescope-project.nvim
                 :LukasPietzschmann/telescope-tabs
                 :jvgrootveld/telescope-zoxide
                 :nvim-lua/popup.nvim
                 :nvim-lua/plenary.nvim]
  :init (fn []
          (vim.api.nvim_set_keymap :n :<leader>ff
                                   ":lua require('telescope.builtin').find_files()<CR>"
                                   {:noremap true})
          (vim.api.nvim_set_keymap :n :<leader>fg
                                   ":lua require('telescope.builtin').live_grep()<CR>"
                                   {:noremap true})
          (vim.api.nvim_set_keymap :n :<leader>fb
                                   ":lua require('telescope.builtin').buffers()<CR>"
                                   {:noremap true})
          (vim.api.nvim_set_keymap :n :<leader>fh
                                   ":lua require('telescope.builtin').help_tags()<CR>"
                                   {:noremap true}))
  :config (fn []
            (let [telescope (require :telescope)
                  themes (require :telescope.themes)]
              (telescope.setup {:defaults {:prompt_prefix "   "
                                           :selection_caret "  "
                                           :entry_prefix "  "
                                           :sorting_strategy :ascending
                                           :layout_strategy :flex
                                           :set_env {:COLORTERM :truecolor}
                                           :dynamic_preview_title :layout_config
                                           {:height 0.8
                                             :horizontal {:preview_width 0.55
                                                          :prompt_position :top}
                                             :preview_cutoff 120
                                             :vertical {:mirror false}
                                             :width 0.87} true
                                           :color_devicons true
                                           :file_ignore_patterns [:node_modules]
                                           :vimgrep_arguments [:rg
                                                               :--color=never
                                                               :--no-heading
                                                               :--with-filename
                                                               :--line-number
                                                               :--column
                                                               :--smart-case
                                                               :--iglob
                                                               :!.git
                                                               :--hidden]}
                                :extensions {:ui-select {1 (themes.get_dropdown {})}}
                                :pickers {:find_files {:find_command [:rg
                                                                      :--files
                                                                      :--iglob
                                                                      :!.git
                                                                      :--hidden]}}})
              (telescope.load_extension :ui-select)
              (telescope.load_extension :project)
              (telescope.load_extension :file_browser)
              (telescope.load_extension :telescope-tabs)))}]
