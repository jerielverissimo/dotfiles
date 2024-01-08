(vim.api.nvim_create_autocmd [:ModeChanged :CursorHold]
                             {:callback (fn []
                                          (set vim.opt.laststatus 3)
                                          ((. (require :ui.stl) :setup) :minimal))})	
