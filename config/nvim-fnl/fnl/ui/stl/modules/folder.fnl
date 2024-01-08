(local ___fn___ vim.fn)

(fn M [m]
  (if (= m :minimal)
      (let [directory (.. "%#StalineFolderText#" " "
			  (___fn___.fnamemodify (___fn___.getcwd) ":t") " ")
		      icon (.. "%#StalineFolderIcon#" " DIR ")]
	(.. icon directory "%#StalineEmptySpace#" " ")) (= m :fancy)
      (let [directory (.. "%#StalineFolderText#" " "
			  (___fn___.fnamemodify (___fn___.getcwd) ":t") " ")
		      icon (.. "%#StalineFolderIcon#" "  ")]
	(.. "%#StalineFolderSep#" "" icon directory "%#StalineEmptySpace#"
	    " ")) :f))

M	
