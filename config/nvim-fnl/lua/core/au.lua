local function _1_()
  for _, client in ipairs(vim.lsp.get_active_clients()) do
    if client.attached_buffers[vim.api.nvim_get_current_buf()] then
      vim.lsp.buf.format()
      return 
    else
      return 
    end
  end
  return nil
end
return vim.api.nvim_create_autocmd({"BufWritePre"}, {callback = _1_})