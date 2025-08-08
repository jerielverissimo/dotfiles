local function _1_()
  vim.api.nvim_set_keymap("x", "<leader>ea", "<Plug>(EasyAlign)", {})
  vim.api.nvim_set_keymap("n", "<leader>ea", "<Plug>(EasyAlign)", {})
  vim.api.nvim_set_keymap("n", "={", "vi{<C-v>$:EasyAlign\\ g/^\\S/<CR>", {})
  vim.api.nvim_set_keymap("n", "=[", "vi[<C-v>$:EasyAlign\\ g/^\\S/<CR>", {})
  return vim.api.nvim_set_keymap("n", "=(", "vi(<C-v>$:EasyAlign\\ g/^\\S/<CR>", {})
end
return {{"junegunn/vim-easy-align", init = _1_, lazy = false}}