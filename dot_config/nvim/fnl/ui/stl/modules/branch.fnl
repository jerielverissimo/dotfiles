(fn M []
  (when (or (not vim.b.gitsigns_head) vim.b.gitsigns_git_status)
    (lua "return \"\""))

  (local git-status vim.b.gitsigns_status_dict)

  (local branch-name (.. "  " git-status.head " "))

  (.. "%#StalineBranch#" branch-name))

M	
