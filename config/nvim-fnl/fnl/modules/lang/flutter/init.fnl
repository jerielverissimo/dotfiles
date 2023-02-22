(local flutter-tools (require :flutter-tools))
(local {: on-attach} (require :modules.tools.lsp))

(flutter-tools.setup {:lsp {:color {:enabled true} :on_attach on-attach}})
