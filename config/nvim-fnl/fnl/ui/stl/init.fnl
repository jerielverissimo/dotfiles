(fn run [STYLE]
  (let [mode (require :ui.stl.modules.mode)
	     filename (require :ui.stl.modules.filename)
	     branch (require :ui.stl.modules.branch)
	     diff (require :ui.stl.modules.diff)
	     folder (require :ui.stl.modules.folder)
	     position (require :ui.stl.modules.position)
	     diagnostics (require :ui.stl.modules.diagnostics)
	     lsp (require :ui.stl.modules.lsp)]
    (table.concat [(mode STYLE)
		   (filename STYLE)
		   (branch)
		   (diff STYLE)
		   "%="
		   (diagnostics STYLE)
;;		   (folder STYLE)
		   (or (lsp STYLE) "")
		   (position STYLE)])))

(fn setup [STYLE]
  (set vim.opt.statusline (run STYLE))
  (vim.api.nvim_create_autocmd [:ModeChanged :CursorHold]
			       {:callback (fn []
					    (set vim.opt.statusline (run STYLE)))}))

{: run : setup}	
