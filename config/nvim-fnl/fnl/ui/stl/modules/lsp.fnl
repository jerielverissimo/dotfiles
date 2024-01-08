(fn M [m]
  (each [_ client (ipairs (vim.lsp.get_active_clients))]
    (when (. client.attached_buffers (vim.api.nvim_get_current_buf))
      (if (= m :minimal)
	  (let [___antifnl_rtn_1___ (.. "%#StalineLspIcon#" " LSP "
					"%#StalineLspNameNormal#" " "
					client.name " %#StalineEmptySpace#" " ")]
	    (lua "return ___antifnl_rtn_1___")) (= m :fancy)
	  (let [___antifnl_rtn_1___ (.. "%#StalineLspIcon#" "   "
					"%#StalineLspName#" " " client.name " "
					"%#StalineEmptySpace#" " ")]
	    (lua "return ___antifnl_rtn_1___")) (lua "return \"f\"")))))

M	
