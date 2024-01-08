(local diagnostic vim.diagnostic)

(fn M [m]
  (let [errors (length (diagnostic.get 0 {:severity diagnostic.severity.ERROR}))
	       warnings (length (diagnostic.get 0 {:severity diagnostic.severity.WARN}))
	       hints (length (diagnostic.get 0 {:severity diagnostic.severity.HINT}))
	       info (length (diagnostic.get 0 {:severity diagnostic.severity.INFO}))]
    (if (= m :minimal) 
	(do
	  (global ERROR
		  (or (and (and errors (> errors 0))
			   (.. "%#StalineLspErrorIcon#" " "
			       "%#StalineLspError#" errors))
		      ""))
	  (global WARNING
		  (or (and (and warnings (> warnings 0))
			   (.. "%#StalineLspWarningIcon#" " "
			       "%#StalineLspWarning#" warnings))
		      ""))
	  (global HINT
		  (or (and (and hints (> hints 0))
			   (.. "%#StalineLspHintsIcon#" " "
			       "%#StalineLspHints#" hints))
		      ""))
	  (global INFO
		  (or (and (and info (> info 0))
			   (.. "%#StalineLspInfoIcon#" " "
			       "%#StalineLspInfo#" info))
		      ""))) (= m :fancy)
	(do
	  (global ERROR (or (and (and errors (> errors 0))
				 (.. "%#StalineLspErrorIcon#" " "
				     "%#StalineLspError#" errors))
			    ""))
	  (global WARNING (or (and (and warnings (> warnings 0))
				   (.. "%#StalineLspWarningIcon#" " "
				       "%#StalineLspWarning#" warnings))
			      ""))
	  (global HINT (or (and (and hints (> hints 0))
				(.. "%#StalineLspHintsIcon#" " "
				    "%#StalineLspHints#" hints))
			   ""))
	  (global INFO (or (and (and info (> info 0))
				(.. "%#StalineLspInfoIcon#" " "
				    "%#StalineLspInfo#" info))
			   ""))) (lua "return \"F\""))
    (.. ERROR " " WARNING " " HINT " " INFO " " "%#StalineEmptySpace#")))

M	
