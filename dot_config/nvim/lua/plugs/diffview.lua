-- [nfnl] Compiled from fnl/plugs/diffview.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  local diffview = require("diffview")
  local actions = require("diffview.actions")
  return diffview.setup({enhanced_diff_hl = true, git_cmd = {"git"}, use_icons = true, icons = {folder_closed = "\238\151\191", folder_open = "\238\151\190"}, signs = {fold_closed = "\239\145\160", fold_open = "\239\145\188"}, view = {merge_tool = {layout = "diff3_mixed", disable_diagnostics = true}}, file_panel = {listing_style = "tree", tree_options = {flatten_dirs = true, folder_statuses = "only_folded"}, win_config = {position = "left", width = 35}}, file_history_panel = {log_options = {single_file = {diff_merges = "combined"}, multi_file = {diff_merges = "first-parent"}}, win_config = {position = "bottom", height = 16}}, commit_log_panel = {win_config = {}}, default_args = {DiffviewOpen = {}, DiffviewFileHistory = {}}, keymaps = {view = {gf = actions.goto_file_edit, ["-"] = actions.toggle_stage_entry}, file_panel = {["<cr>"] = actions.focus_entry, s = actions.toggle_stage_entry, gf = actions.goto_file_edit, ["?"] = "<Cmd>h diffview-maps-file-panel<CR>"}, file_history_panel = {["<cr>"] = actions.focus_entry, gf = actions.goto_file_edit, ["?"] = "<Cmd>h diffview-maps-file-history-panel<CR>"}}, diff_binaries = false})
end
return {{"sindrets/diffview.nvim", config = _1_}}
