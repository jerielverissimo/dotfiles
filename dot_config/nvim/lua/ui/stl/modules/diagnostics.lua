-- [nfnl] Compiled from fnl/ui/stl/modules/diagnostics.fnl by https://github.com/Olical/nfnl, do not edit.
local diagnostic = vim.diagnostic
local function M(m)
  local errors = #diagnostic.get(0, {severity = diagnostic.severity.ERROR})
  local warnings = #diagnostic.get(0, {severity = diagnostic.severity.WARN})
  local hints = #diagnostic.get(0, {severity = diagnostic.severity.HINT})
  local info = #diagnostic.get(0, {severity = diagnostic.severity.INFO})
  if (m == "minimal") then
    ERROR = (((errors and (errors > 0)) and ("%#StalineLspErrorIcon#" .. "\239\129\151 " .. "%#StalineLspError#" .. errors)) or "")
    WARNING = (((warnings and (warnings > 0)) and ("%#StalineLspWarningIcon#" .. "\239\129\177 " .. "%#StalineLspWarning#" .. warnings)) or "")
    HINT = (((hints and (hints > 0)) and ("%#StalineLspHintsIcon#" .. "\239\129\153 " .. "%#StalineLspHints#" .. hints)) or "")
    INFO = (((info and (info > 0)) and ("%#StalineLspInfoIcon#" .. "\239\129\154 " .. "%#StalineLspInfo#" .. info)) or "")
  elseif (m == "fancy") then
    ERROR = (((errors and (errors > 0)) and ("%#StalineLspErrorIcon#" .. "\239\129\151 " .. "%#StalineLspError#" .. errors)) or "")
    WARNING = (((warnings and (warnings > 0)) and ("%#StalineLspWarningIcon#" .. "\239\129\177 " .. "%#StalineLspWarning#" .. warnings)) or "")
    HINT = (((hints and (hints > 0)) and ("%#StalineLspHintsIcon#" .. "\239\129\153 " .. "%#StalineLspHints#" .. hints)) or "")
    INFO = (((info and (info > 0)) and ("%#StalineLspInfoIcon#" .. "\239\129\154 " .. "%#StalineLspInfo#" .. info)) or "")
  else
    return "F"
  end
  return (ERROR .. " " .. WARNING .. " " .. HINT .. " " .. INFO .. " " .. "%#StalineEmptySpace#")
end
return M
