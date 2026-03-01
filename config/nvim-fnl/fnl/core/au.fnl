(vim.api.nvim_create_autocmd 
  [:UIEnter]
  {:callback (fn []
	       (var should-skip false)
	       (if (or (or (> (vim.fn.argc) 0)
			   (not= (vim.fn.line2byte "$")
				 (- 1)))
		       (not vim.o.modifiable))
		   (set should-skip true)
		   (each [_ arg (pairs vim.v.argv)]
		     (when (or (or (or (= arg :-b)
				       (= arg :-c))
				   (vim.startswith arg
						   "+"))
			       (= arg :-S))
		       (set should-skip true)
		       (lua :break))))
	       (when (not should-skip)
		 (vim.cmd :Alpha)))})	

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

(local clojure-group (vim.api.nvim_create_augroup :clojureFiles {:clear true}))
(vim.api.nvim_create_autocmd :BufWinEnter
                             {:command "silent! set filetype=clojure"
                              :group clojure-group
                              :pattern [:*.clj :*.cljs :*.edn :*.edn.base]})	


(local json-group (vim.api.nvim_create_augroup :jsonFiles {:clear true}))
(vim.api.nvim_create_autocmd :BufWinEnter
                             {:command "silent! set filetype=json"
                              :group json-group
                              :pattern [:*.json.base]})	
