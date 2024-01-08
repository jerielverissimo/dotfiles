-- [nfnl] Compiled from fnl/ui/stl/modules/lsp.fnl by https://github.com/Olical/nfnl, do not edit.
local function M(m)
  for _, client in ipairs(vim.lsp.get_active_clients()) do
    if client.attached_buffers[vim.api.nvim_get_current_buf()] then
      if (m == "minimal") then
        local ___antifnl_rtn_1___ = ("%#StalineLspIcon#" .. " LSP " .. "%#StalineLspNameNormal#" .. " " .. client.name .. " %#StalineEmptySpace#" .. " ")
        return ___antifnl_rtn_1___
      elseif (m == "fancy") then
        local ___antifnl_rtn_1___ = ("%#StalineLspIcon#" .. " \239\132\181  " .. "%#StalineLspName#" .. " " .. client.name .. " " .. "%#StalineEmptySpace#" .. " ")
        return ___antifnl_rtn_1___
      else
        return "f"
      end
    else
    end
  end
  return nil
end
return M
