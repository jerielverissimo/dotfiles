-- [nfnl] fnl/ui/stl/modules/branch.fnl
local function M()
  if (not vim.b.gitsigns_head or vim.b.gitsigns_git_status) then
    return ""
  else
  end
  local git_status = vim.b.gitsigns_status_dict
  local branch_name = (" \238\156\165 " .. git_status.head .. " ")
  return ("%#StalineBranch#" .. branch_name)
end
return M
