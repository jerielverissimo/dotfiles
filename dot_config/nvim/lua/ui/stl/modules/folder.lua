-- [nfnl] Compiled from fnl/ui/stl/modules/folder.fnl by https://github.com/Olical/nfnl, do not edit.
local ___fn___ = vim.fn
local function M(m)
  if (m == "minimal") then
    local directory = ("%#StalineFolderText#" .. " " .. ___fn___.fnamemodify(___fn___.getcwd(), ":t") .. " ")
    local icon = ("%#StalineFolderIcon#" .. " DIR ")
    return (icon .. directory .. "%#StalineEmptySpace#" .. " ")
  elseif (m == "fancy") then
    local directory = ("%#StalineFolderText#" .. " " .. ___fn___.fnamemodify(___fn___.getcwd(), ":t") .. " ")
    local icon = ("%#StalineFolderIcon#" .. "\238\152\147  ")
    return ("%#StalineFolderSep#" .. "\238\130\182" .. icon .. directory .. "%#StalineEmptySpace#" .. " ")
  else
    return "f"
  end
end
return M
