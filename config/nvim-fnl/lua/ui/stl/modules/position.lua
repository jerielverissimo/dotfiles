-- [nfnl] Compiled from fnl/ui/stl/modules/position.fnl by https://github.com/Olical/nfnl, do not edit.
local ___fn___ = vim.fn
local function M(m)
  local current = ___fn___.line(".")
  local total = ___fn___.line("$")
  if (m == "minimal") then
    return ("%#StalineProgress#" .. " " .. current .. "/" .. total .. " " .. "%#StalineProgressIcon#" .. " " .. "%#StalineEmptySpace#")
  elseif (m == "fancy") then
    return ("%#StalineProgressIcon#" .. " \238\152\146  " .. "%#StalineProgress#" .. " " .. current .. "/" .. total .. " " .. "%#StalineEmptySpace#")
  else
    return "F"
  end
end
return M
