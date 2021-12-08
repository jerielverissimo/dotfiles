local g = vim.g

vim.o.termguicolors = true

-- g.nvim_tree_add_trailing = 1 -- append a trailing slash to folder names
g.nvim_tree_allow_resize = 1
g.nvim_tree_git_hl = git_status
g.nvim_tree_highlight_opened_files = 0
-- g.nvim_tree_indent_markers = 1
g.nvim_tree_quit_on_open = 0 -- closes tree when file's opened
g.nvim_tree_side = "left"

g.nvim_tree_show_icons = {
  folders = 1,
  folder_arrows = 1,
  files = 1,
  git = git_status
}

g.nvim_tree_icons = {
  default = "",
  symlink = "",
  git = {
    deleted = "",
    ignored = "◌",
    renamed = "➜",
    staged = "✓",
    unmerged = "",
    unstaged = "✗",
    untracked = "★"
  },
  folder = {
    arrow_open = "",
    arrow_closed = "",
    default = "",
    empty = "", -- 
    empty_open = "",
    open = "",
    symlink = "",
    symlink_open = ""
  },
  lsp = {
    hint = "",
    info = "",
    warning = "",
    error = ""
  }
}

require("nvim-tree").setup {
  disable_netrw = true,
  hijack_netrw = true,
  auto_close = false,
  open_on_tab = false,
  hijack_cursor = true,
  update_cwd = true,
  update_focused_file = {
    enable = true,
    update_cwd = true
  }
}
