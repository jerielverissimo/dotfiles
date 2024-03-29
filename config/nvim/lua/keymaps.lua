vim.cmd "nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>"
vim.cmd "nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>"
vim.cmd "nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>"
vim.cmd "nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>"
vim.cmd "nnoremap <space>ca <cmd>lua vim.lsp.buf.code_action()<CR>"
vim.api.nvim_set_keymap(
  "n",
  "gl",
  '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics({ show_header = false, border = "single" })<CR>',
  {noremap = true, silent = true}
)

vim.cmd "nnoremap <silent> gp <cmd>lua require'lsp'.PeekDefinition()<CR>"
vim.cmd "nnoremap <silent> K :lua vim.lsp.buf.hover()<CR>"
vim.cmd "nnoremap <silent> <C-p> :lua vim.lsp.diagnostic.goto_prev({popup_opts = {border = 'single'}})<CR>"
vim.cmd "nnoremap <silent> <C-n> :lua vim.lsp.diagnostic.goto_next({popup_opts = {border = 'single'}})<CR>"
vim.cmd "nnoremap <silent> <tab> <cmd>lua vim.lsp.buf.signature_help()<CR>"
-- scroll down hover doc or scroll in definition preview
-- scroll up hover doc
vim.cmd 'command! -nargs=0 LspVirtualTextToggle lua require("lsp/virtual_text").toggle()'

vim.cmd "nnoremap <leader>p :NvimTreeToggle<CR>"
vim.cmd "nnoremap <leader>r :NvimTreeRefresh<CR>"

vim.cmd "nnoremap <leader>ff <cmd>Telescope find_files<cr>"
vim.cmd "nnoremap <leader>fg <cmd>Telescope live_grep<cr>"
vim.cmd "nnoremap <leader>fb <cmd>Telescope buffers<cr>"
vim.cmd "nnoremap <leader>fh <cmd>Telescope help_tags<cr>"

vim.cmd "au BufWritePost <buffer> lua require('lint').try_lint()"

vim.api.nvim_exec(
  [[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost *.js,*.rs,*.lua FormatWrite
augroup END
]],
  true
)

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end
local map = vim.api.nvim_set_keymap

-- Various key mappings.
-- map("i", "<C-e>", "compe#close('<C-e>')", {silent = true, expr = true})
-- map("i", "<C-f>", "compe#scroll({delta = +4})", {silent = true, expr = true})
-- map("i", "<C-d>", "compe#scroll({delta = -4})", {silent = true, expr = true})

-- Use (s-)tab to:
--- move to prev/next item in completion menu
--- jump to prev/next snippet field
local check_back_space = function()
  local col = vim.fn.col(".") - 1
  if col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
    return true
  else
    return false
  end
end

_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif vim.fn.call("vsnip#available", {1}) == 1 then
    return t "<Plug>(vsnip-expand-or-jump)"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn["cmp#complete"]()
  end
end

_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
    return t "<Plug>(vsnip-jump-prev)"
  else
    return t "<S-Tab>"
  end
end

-- OnEnter = function()
--   if vim.fn.pumvisible() == 1 then
--     return vim.fn["compe#confirm"]()
--   end
-- end

map("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
map("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
map("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
map("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})

-- map("i", "<CR>", "v:lua.OnEnter()", {expr = true, noremap = true})

vim.cmd "au! BufRead,BufNewFile *.glsl,*.vert,*.frag set filetype=glsl"

-- Trouble
vim.api.nvim_set_keymap("n", "<leader>xx", "<cmd>Trouble<cr>", {silent = true, noremap = true})
vim.api.nvim_set_keymap("n", "<leader>xw", "<cmd>Trouble workspace_diagnostics<cr>", {silent = true, noremap = true})
vim.api.nvim_set_keymap("n", "<leader>xd", "<cmd>Trouble document_diagnostics<cr>", {silent = true, noremap = true})
vim.api.nvim_set_keymap("n", "<leader>xl", "<cmd>Trouble loclist<cr>", {silent = true, noremap = true})
vim.api.nvim_set_keymap("n", "<leader>xq", "<cmd>Trouble quickfix<cr>", {silent = true, noremap = true})
vim.api.nvim_set_keymap("n", "gR", "<cmd>Trouble lsp_references<cr>", {silent = true, noremap = true})

-- LSP
vim.api.nvim_set_keymap("n", "<leader>lf", "<cmd>lua vim.lsp.buf.formatting()<cr>", {silent = true, noremap = true})
-- vim .cmd "autocmd BufWritePost *.clj silent call vim.lsp.buf.formatting()"
