(fn scratch []
  ;; create buffer
  (local bufnr (vim.api.nvim_create_buf true true))
  (vim.api.nvim_buf_set_name bufnr :*scratch*)
  (vim.api.nvim_buf_set_option bufnr :filetype :clojure)
  (vim.api.nvim_win_set_buf 0 bufnr)
  ;; initial message
  (local scratch-comments
         [";; This buffer is for Clojure evaluation."
          ";; If you want to create a file, run ':write' with a file name."
          ";; NOTE: press <space>meb to evaluate buffer (conjure)."
          ";;       press <space>mer to evaluate root form (conjure)."
          ";;       press <space>hr to open reflect (hotpot)."
          ";; Run :ConjureSchool for more"
          ""
          ""
          "(require-macros :macros)"])
  (tset vim.opt_local :buftype :nofile)
  (vim.api.nvim_buf_set_lines 0 0 -1 true scratch-comments)
  (vim.api.nvim_win_set_cursor 0 [5 0]))

(vim.api.nvim_create_user_command :Scratch scratch {})

(vim.cmd "autocmd BufNewFile conjure-log-* lua vim.diagnostic.disable(0)")
