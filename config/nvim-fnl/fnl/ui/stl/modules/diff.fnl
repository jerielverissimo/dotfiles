(fn M [m]
  (when (or (not vim.b.gitsigns_head) vim.b.gitsigns_git_status)
    (lua "return \"\""))
  (local git-status vim.b.gitsigns_status_dict)
  (local added (or (and (and git-status.added (not= git-status.added 0))
			(.. " + " git-status.added)) ""))
  (local changed (or (and (and git-status.changed (not= git-status.changed 0))
			  (.. " ~ " git-status.changed))
		     ""))
  (local removed (or (and (and git-status.removed (not= git-status.removed 0))
			  (.. " - " git-status.removed))
		     ""))
  (if (or (or (and (tonumber git-status.added)
		   (> (tonumber git-status.added) 0))
	      (> (and (tonumber git-status.changed)
		      (tonumber git-status.changed)) 0))
	  (and (tonumber git-status.removed)
	       (> (tonumber git-status.removed) 0)))
      (if (= m :minimal)
	  (.. " " "%#StalineDiffAdd#" added "%#StalineDiffChange#" changed
	      "%#StalineDiffRemove#" removed) (= m :fancy)
	  (.. " " "%#StalineDiffAddFancy#" added " "
	      "%#StalineDiffChangeFancy#" changed " %#StalineDiffRemoveFancy#"
	      removed " %#StalineEmptySpace#") :F) " "))

M	
