(local {: autoload} (require :nfnl.module))
(local nvim (autoload :nvim))

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
            (nvim.set_keymap :n :<leader>ff ":lua require('telescope.builtin').find_files()<CR>" {:noremap true})
            (nvim.set_keymap :n :<leader>fg ":lua require('telescope.builtin').live_grep()<CR>" {:noremap true})
            (nvim.set_keymap :n :<leader>fb ":lua require('telescope.builtin').buffers()<CR>" {:noremap true})
            (nvim.set_keymap :n :<leader>fh ":lua require('telescope.builtin').help_tags()<CR>" {:noremap true}))
    :config (fn []
              (let [telescope (require :telescope)
                              themes (require :telescope.themes)]
                (telescope.setup {:defaults {:color_devicons true
                                 :file_ignore_patterns ["node_modules"]
                                 :vimgrep_arguments ["rg"
                                                     "--color=never"
                                                     "--no-heading"
                                                     "--with-filename"
                                                     "--line-number"
                                                     "--column"
                                                     "--smart-case"
                                                     "--iglob"
                                                     "!.git"
                                                     "--hidden"]}
                                 :extensions {:ui-select {1 (themes.get_dropdown {})}}
                                 :pickers {:find_files {:find_command ["rg"
                                                                       "--files"
                                                                       "--iglob"
                                                                       "!.git"
                                                                       "--hidden"]}}})
                (telescope.load_extension :ui-select)
                (telescope.load_extension :project)
                (telescope.load_extension :file_browser)
                (telescope.load_extension :telescope-tabs)))}]
