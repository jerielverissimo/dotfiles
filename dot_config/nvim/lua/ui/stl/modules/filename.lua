-- [nfnl] Compiled from fnl/ui/stl/modules/filename.fnl by https://github.com/Olical/nfnl, do not edit.
local ___fn___ = vim.fn
local function M(m)
  local icon = " \239\156\153 "
  local filename = (((___fn___.expand("%") == "") and "Empty ") or ___fn___.expand("%:t"))
  if (filename ~= "Empty ") then
    local devicons = require("nvim-web-devicons")
    local ft_icon, icon_hl = devicons.get_icon(filename)
    icon = (((ft_icon ~= nil) and (" " .. ft_icon)) or "")
    if not icon_hl then
      icon_hl = "StalineDefaultFile"
    else
    end
    if (filename == "NvimTree_1") then
      filename = "File Explorer"
    else
    end
    if (filename == "[startuptime]") then
      filename = "Startup Time"
    else
    end
    if string.find(filename, "toggleterm") then
      filename = "Terminal"
    else
    end
    if (m == "minimal") then
      return ("%#StalineFilenameIcon#" .. "%#" .. icon_hl .. "# " .. icon .. "  %#StalineFilename#" .. filename .. "  ")
    elseif (m == "fancy") then
      return ("%#StalineFilenameFancy#" .. icon .. "  " .. filename .. "   " .. "%#StalineFilenameSep#\238\130\188" .. " %#StalineEmptySpace#")
    else
      return nil
    end
  else
    if (m == "minimal") then
      return "%#StalineFilename#  Nomad "
    elseif (m == "fancy") then
      return ("%#StalineFilenameFancy#" .. "  Nomad  " .. "%#StalineFilenameSep#\238\130\188" .. " %#StalineEmptySpace#")
    else
      return nil
    end
  end
end
return M
