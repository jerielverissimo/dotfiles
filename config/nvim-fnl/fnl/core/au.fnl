(vim.api.nvim_create_autocmd 
  [:BufWritePre]
  {:callback (fn []
               (each [_ client (ipairs (vim.lsp.get_active_clients))]
                 (if (. client.attached_buffers
                        (vim.api.nvim_get_current_buf))
                     (do
                       (vim.lsp.buf.format)
                       (lua "return "))
                     (lua "return "))))})	
