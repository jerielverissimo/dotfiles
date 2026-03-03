-- [nfnl] fnl/core/au.fnl
local function _1_()
  local should_skip = false
  if (((vim.fn.argc() > 0) or (vim.fn.line2byte("$") ~= ( - 1))) or not vim.o.modifiable) then
    should_skip = true
  else
    for _, arg in pairs(vim.v.argv) do
      if ((((arg == "-b") or (arg == "-c")) or vim.startswith(arg, "+")) or (arg == "-S")) then
        should_skip = true
        break
      else
      end
    end
  end
  if not should_skip then
    return vim.cmd("Alpha")
  else
    return nil
  end
end
vim.api.nvim_create_autocmd({"UIEnter"}, {callback = _1_})
local function _5_()
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
vim.api.nvim_create_autocmd({"BufWritePre"}, {callback = _5_})
local clojure_group = vim.api.nvim_create_augroup("clojureFiles", {clear = true})
vim.api.nvim_create_autocmd("BufWinEnter", {command = "silent! set filetype=clojure", group = clojure_group, pattern = {"*.clj", "*.cljs", "*.edn", "*.edn.base"}})
local json_group = vim.api.nvim_create_augroup("jsonFiles", {clear = true})
return vim.api.nvim_create_autocmd("BufWinEnter", {command = "silent! set filetype=json", group = json_group, pattern = {"*.json.base"}})
