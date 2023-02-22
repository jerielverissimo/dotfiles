(local {: deep-merge} (require :core.lib.tables))
(local lsp (require :lspconfig))

(local lsp-servers {})

(set vim.lsp.handlers.textDocument/signatureHelp
     (vim.lsp.with vim.lsp.handlers.signature_help {:border :solid}))

(set vim.lsp.handlers.textDocument/hover
     (vim.lsp.with vim.lsp.handlers.hover {:border :solid}))

(fn on-attach [client bufnr]
  (import-macros {: autocmd! : augroup! : clear!} :core.lib.macros)
  (local {: contains?} (require :core.lib))
  ;; Keybindings
  (do
    (vim.api.nvim_buf_set_keymap bufnr :n :gd
                                 "<Cmd>lua vim.lsp.buf.definition()<CR>"
                                 {:noremap true})
    (vim.api.nvim_buf_set_keymap bufnr :n :K "<Cmd>lua vim.lsp.buf.hover()<CR>"
                                 {:noremap true})
    (vim.api.nvim_buf_set_keymap bufnr :n :<leader>ld
                                 "<Cmd>lua vim.lsp.buf.declaration()<CR>"
                                 {:noremap true})
    (vim.api.nvim_buf_set_keymap bufnr :n :<leader>lt
                                 "<cmd>lua vim.lsp.buf.type_definition()<CR>"
                                 {:noremap true})
    (vim.api.nvim_buf_set_keymap bufnr :n :<leader>lh
                                 "<cmd>lua vim.lsp.buf.signature_help()<CR>"
                                 {:noremap true})
    (vim.api.nvim_buf_set_keymap bufnr :n :<leader>ln
                                 "<cmd>lua vim.lsp.buf.rename()<CR>"
                                 {:noremap true})
    (vim.api.nvim_buf_set_keymap bufnr :n :<leader>le
                                 "<cmd>lua vim.diagnostic.open_float()<CR>"
                                 {:noremap true})
    (vim.api.nvim_buf_set_keymap bufnr :n :<leader>lq
                                 "<cmd>lua vim.diagnostic.setloclist()<CR>"
                                 {:noremap true})
    (vim.api.nvim_buf_set_keymap bufnr :n :<leader>lf
                                 "<cmd>lua vim.lsp.buf.format()<CR>"
                                 {:noremap true})
    (vim.api.nvim_buf_set_keymap bufnr :n :<leader>lj
                                 "<cmd>lua vim.diagnostic.goto_next()<CR>"
                                 {:noremap true})
    (vim.api.nvim_buf_set_keymap bufnr :n :<leader>lk
                                 "<cmd>lua vim.diagnostic.goto_prev()<CR>"
                                 {:noremap true})
    (vim.api.nvim_buf_set_keymap bufnr :n :<leader>la
                                 "<cmd>lua vim.lsp.buf.code_action()<CR>"
                                 {:noremap true})
    (vim.api.nvim_buf_set_keymap bufnr :v :<leader>la
                                 "<cmd>lua vim.lsp.buf.range_code_action()<CR> "
                                 {:noremap true})
    ;telescope
    (vim.api.nvim_buf_set_keymap bufnr :n :<leader>lw
                                 ":lua require('telescope.builtin').lsp_workspace_diagnostics()<cr>"
                                 {:noremap true})
    (vim.api.nvim_buf_set_keymap bufnr :n :<leader>lr
                                 ":lua require('telescope.builtin').lsp_references()<cr>"
                                 {:noremap true})
    (vim.api.nvim_buf_set_keymap bufnr :n :<leader>li
                                 ":lua require('telescope.builtin').lsp_implementations()<cr>"
                                 {:noremap true}))
  ;; Enable lsp formatting if available 
  (when (client.supports_method :textDocument/formatting)
    (augroup! lsp-format-before-saving (clear! {:buffer bufnr})
              (autocmd! BufWritePre <buffer>
                        `(vim.lsp.buf.format {:filter (fn [client]
                                                        (not (contains? [:jsonls
                                                                         :tsserver]
                                                                        client.name)))
                                              : bufnr})
                        {:buffer bufnr}))))

;; What should the lsp be demanded of?

(local capabilities (vim.lsp.protocol.make_client_capabilities))
(set capabilities.textDocument.completion.completionItem
     {:documentationFormat [:markdown :plaintext]
      :snippetSupport true
      :preselectSupport true
      :insertReplaceSupport true
      :labelDetailsSupport true
      :deprecatedSupport true
      :commitCharactersSupport true
      :tagSupport {:valueSet {1 1}}
      :resolveSupport {:properties [:documentation
                                    :detail
                                    :additionalTextEdits]}})

;;; Setup servers

(local defaults {:on_attach on-attach
                 : capabilities
                 :flags {:debounce_text_changes 150}})

;; fennel-language-server
(tset lsp-servers :fennel-language-server {})
(tset (require :lspconfig.configs) :fennel-language-server
      {:default_config {:cmd [:fennel-language-server]
                        :filetypes [:fennel]
                        :single_file_support true
                        :root_dir (lsp.util.root_pattern :fnl)
                        :settings {:fennel {:workspace {:library (vim.api.nvim_list_runtime_paths)}
                                            :diagnostics {:globals [:vim]}}}}})

;; conditional servers

(tset lsp-servers :clojure_lsp {})

(tset lsp-servers :clangd {})

(tset lsp-servers :jdtls {})

(tset lsp-servers :bashls {})

(tset lsp-servers :rust_analyzer {})

(tset lsp-servers :tsserver {})

(tset lsp-servers :vuels {})

(tset lsp-servers :lua_ls
      {:settings {:Lua {:diagnostics {:globals [:vim]}
                        :workspace {:library (vim.api.nvim_list_runtime_paths)
                                    :maxPreload 100000}}}})

(tset lsp-servers :marksman {})

(tset lsp-servers :pyright
      {:root_dir (lsp.util.root_pattern [:.flake8])
       :settings {:python {:analysis {:autoImportCompletions true
                                      :useLibraryCodeForTypes true
                                      :disableOrganizeImports false}}}})

;; Load lsp

(let [servers lsp-servers]
  (each [server server_config (pairs servers)]
    ((. (. lsp server) :setup) (deep-merge defaults server_config))))

{: on-attach}
