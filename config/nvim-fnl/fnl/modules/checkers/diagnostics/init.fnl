(import-macros {: map!} :core.lib.macros)

(local {: on-attach} (require :modules.tools.lsp))
(local null-ls (require :null-ls))
(local null-ls-sources [])

;; configure signs

(fn lsp-symbol [name icon]
  (let [hl (.. :DiagnosticSign name)]
    (vim.fn.sign_define hl {:text icon :numhl hl :texthl hl})))

(lsp-symbol :Error "")
(lsp-symbol :Info "")
(lsp-symbol :Hint "")
(lsp-symbol :Warn "")

(vim.diagnostic.config {:virtual_text false
                        :signs true
                        :underline true
                        :update_in_insert false
                        :float {:show_header false :border :rounded}})

(local {:goto_prev goto-diag-prev! :goto_next goto-diag-next!} vim.diagnostic)

(map! [n] "[d" goto-diag-prev! {:desc "Goto previous diagonstics"})

(map! [n] "]d" goto-diag-next! {:desc "Goto next diagnostics"})

(table.insert null-ls-sources null-ls.builtins.formatting.fnlfmt)

(table.insert null-ls-sources null-ls.builtins.formatting.clang_format)
(table.insert null-ls-sources null-ls.builtins.diagnostics.clang_check)

(table.insert null-ls-sources null-ls.builtins.formatting.zprint)

(table.insert null-ls-sources null-ls.builtins.formatting.google_java_format)

(table.insert null-ls-sources null-ls.builtins.formatting.stylua)

(table.insert null-ls-sources null-ls.builtins.formatting.ruff)

(table.insert null-ls-sources null-ls.builtins.diagnostics.pycodestyle)

(table.insert null-ls-sources null-ls.builtins.formatting.markdownlint)

(table.insert null-ls-sources null-ls.builtins.formatting.rustfmt)

(table.insert null-ls-sources null-ls.builtins.formatting.shfmt)

(table.insert null-ls-sources null-ls.builtins.diagnostics.selene)

(table.insert null-ls-sources null-ls.builtins.diagnostics.clj_kondo)

;;(table.insert null-ls-sources null-ls.builtins.formatting.cljstyle)

(table.insert null-ls-sources null-ls.builtins.diagnostics.buf)

;;(table.insert null-ls-sources null-ls.builtins.diagnostics.eslint)

(table.insert null-ls-sources null-ls.builtins.formatting.prettier)

(table.insert null-ls-sources null-ls.builtins.formatting.dart_format)

(null-ls.setup {:sources null-ls-sources
                ;; #{m}: message
                ;; #{s}: source name (defaults to null-ls if not specified)
                ;; #{c}: code (if available
                :diagnostics_format "[#{c}] #{m} (#{s})"
                :debug false
                :on_attach on-attach})
