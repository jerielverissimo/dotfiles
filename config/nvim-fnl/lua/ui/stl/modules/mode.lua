-- [nfnl] Compiled from fnl/ui/stl/modules/mode.fnl by https://github.com/Olical/nfnl, do not edit.
local api = vim.api
local modes = {["\19"] = {"S-BLOCK", "StalineSelectMode"}, ["\22"] = {"V-BLOCK", "StalineVisualMode"}, ["!"] = {"SHELL", "StalineTerminalMode"}, R = {"REPLACE", "StalineReplaceMode"}, Rv = {"V-REPLACE", "StalineReplaceMode"}, S = {"S-LINE", "StalineSelectMode"}, V = {"V-LINE", "StalineVisualMode"}, Vs = {"V-LINE (Ctrl O)", "StalineVisualMode"}, c = {"COMMAND", "StalineCommandMode"}, ce = {"COMMAND", "StalineCommandMode"}, cv = {"COMMAND", "StalineCommandMode"}, i = {"INSERT", "StalineInsertMode"}, ic = {"INSERT (completion)", "StalineInsertMode"}, ix = {"INSERT completion", "StalineInsertMode"}, n = {"NORMAL", "StalineNormalMode"}, niI = {"NORMAL i", "StalineNormalMode"}, niR = {"NORMAL r", "StalineNormalMode"}, niV = {"NORMAL v", "StalineNormalMode"}, no = {"N-PENDING", "StalineNormalMode"}, nt = {"NTERMINAL", "StalineNTerminalMode"}, r = {"PROMPT", "StalineConfirmMode"}, ["r?"] = {"CONFIRM", "StalineConfirmMode"}, rm = {"MORE", "StalineConfirmMode"}, s = {"SELECT", "StalineSelectMode"}, t = {"TERMINAL", "StalineTerminalMode"}, v = {"VISUAL", "StalineVisualMode"}}
local function M(m)
  local mode = api.nvim_get_mode().mode
  local sep = ("%#" .. modes[mode][2] .. "Sep" .. "#" .. "\238\130\188  ")
  local septwo = ("%#StalineModeSepTwo" .. "#" .. "\238\130\188 ")
  if (m == "minimal") then
    return ("%#" .. modes[mode][2] .. "#" .. " " .. modes[mode][1] .. " ")
  elseif (m == "fancy") then
    return ("%#" .. modes[mode][2] .. "#" .. " \238\152\171  " .. modes[mode][1] .. " " .. sep .. septwo .. "")
  else
    return "F"
  end
end
return M
