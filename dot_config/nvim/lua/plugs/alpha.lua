-- [nfnl] Compiled from fnl/plugs/alpha.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local nvim = autoload("nvim")
local function _2_()
  local alpha = require("alpha")
  local startup_file = "/tmp/nvim-startuptime"
  local startup_time_pattern = "([%d.]+)  [%d.]+: [-]+ NVIM STARTED [-]+"
  local startup_time_file = ((io.open(startup_file) and io.open(startup_file):read("*a")) or nil)
  local startup_time = ((startup_time_file and tonumber(startup_time_file:match(startup_time_pattern))) or nil)
  local text = ""
  if (startup_time and (startup_time >= 1000)) then
    text = string.format("nomad loaded in %.1fs", (startup_time * 0.001))
  else
  end
  io.open(startup_file, "w"):close()
  local function button(sc, txt, keybind, keybind_opts)
    local sc_ = sc:gsub("%s", ""):gsub("SPC", "<leader>")
    local opts = {position = "center", shortcut = sc, cursor = 5, width = 50, align_shortcut = "right", hl = "DashboardCenter", hl_shortcut = "DashboardShortCut"}
    if keybind then
      opts.keymap = {"n", sc_, keybind, {noremap = true, silent = true, nowait = true}}
    else
    end
    local function on_press()
      local key = vim.api.nvim_replace_termcodes((keybind or (sc_ .. "<Ignore>")), true, false, true)
      return vim.api.nvim_feedkeys(key, "t", false)
    end
    return {type = "button", val = txt, on_press = on_press, opts = opts}
  end
  local sections
  local function _5_()
    return nil
  end
  sections = {header = {type = "text", val = {"\226\150\136\226\150\136\226\150\136\226\149\151   \226\150\136\226\150\136\226\149\151 \226\150\136\226\150\136\226\150\136\226\150\136\226\150\136\226\150\136\226\149\151 \226\150\136\226\150\136\226\150\136\226\149\151   \226\150\136\226\150\136\226\150\136\226\149\151 \226\150\136\226\150\136\226\150\136\226\150\136\226\150\136\226\149\151 \226\150\136\226\150\136\226\150\136\226\150\136\226\150\136\226\150\136\226\149\151 ", "\226\150\136\226\150\136\226\150\136\226\150\136\226\149\151  \226\150\136\226\150\136\226\149\145\226\150\136\226\150\136\226\149\148\226\149\144\226\149\144\226\149\144\226\150\136\226\150\136\226\149\151\226\150\136\226\150\136\226\150\136\226\150\136\226\149\151 \226\150\136\226\150\136\226\150\136\226\150\136\226\149\145\226\150\136\226\150\136\226\149\148\226\149\144\226\149\144\226\150\136\226\150\136\226\149\151\226\150\136\226\150\136\226\149\148\226\149\144\226\149\144\226\150\136\226\150\136\226\149\151", "\226\150\136\226\150\136\226\149\148\226\150\136\226\150\136\226\149\151 \226\150\136\226\150\136\226\149\145\226\150\136\226\150\136\226\149\145   \226\150\136\226\150\136\226\149\145\226\150\136\226\150\136\226\149\148\226\150\136\226\150\136\226\150\136\226\150\136\226\149\148\226\150\136\226\150\136\226\149\145\226\150\136\226\150\136\226\150\136\226\150\136\226\150\136\226\150\136\226\150\136\226\149\145\226\150\136\226\150\136\226\149\145  \226\150\136\226\150\136\226\149\145", "\226\150\136\226\150\136\226\149\145\226\149\154\226\150\136\226\150\136\226\149\151\226\150\136\226\150\136\226\149\145\226\150\136\226\150\136\226\149\145   \226\150\136\226\150\136\226\149\145\226\150\136\226\150\136\226\149\145\226\149\154\226\150\136\226\150\136\226\149\148\226\149\157\226\150\136\226\150\136\226\149\145\226\150\136\226\150\136\226\149\148\226\149\144\226\149\144\226\150\136\226\150\136\226\149\145\226\150\136\226\150\136\226\149\145  \226\150\136\226\150\136\226\149\145", "\226\150\136\226\150\136\226\149\145 \226\149\154\226\150\136\226\150\136\226\150\136\226\150\136\226\149\145\226\149\154\226\150\136\226\150\136\226\150\136\226\150\136\226\150\136\226\150\136\226\149\148\226\149\157\226\150\136\226\150\136\226\149\145 \226\149\154\226\149\144\226\149\157 \226\150\136\226\150\136\226\149\145\226\150\136\226\150\136\226\149\145  \226\150\136\226\150\136\226\149\145\226\150\136\226\150\136\226\150\136\226\150\136\226\150\136\226\150\136\226\149\148\226\149\157", "\226\149\154\226\149\144\226\149\157  \226\149\154\226\149\144\226\149\144\226\149\144\226\149\157 \226\149\154\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\157 \226\149\154\226\149\144\226\149\157     \226\149\154\226\149\144\226\149\157\226\149\154\226\149\144\226\149\157  \226\149\154\226\149\144\226\149\157\226\149\154\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\157 "}, opts = {position = "center", hl = "DashboardHeader"}}, buttons = {type = "group", val = {button("SPC q l", "\239\145\164  Reload last session", ":Telescope find_files <CR>"), button("SPC o A", "\239\145\149  Open agenda", ":Telescope oldfiles<CR>"), button("SPC f r", "\239\144\142  Recently opened files", ":Telescope oldfiles<CR>"), button("SPC p p", "\239\146\145  Open project", ":<CR>"), button("SPC RET", "\239\145\161  Jump to bookmark", ":Telescope marks<CR>"), button("SPC f P", "\239\144\165  Open private configuration", ":Telescope keymaps<CR>"), button("SPC h d h", "\239\144\133  Open documentation", ":Telescope keymaps<CR>")}, opts = {spacing = 1}}, footer = {type = "text", val = text, opts = {position = "center", hl = "Comment"}}, icon = {type = "button", val = "\239\175\153", opts = {position = "center", hl = "Decorator"}, on_press = _5_}}
  return alpha.setup({layout = {{type = "padding", val = 4}, sections.header, {type = "padding", val = 2}, sections.buttons, {type = "padding", val = 2}, sections.footer, {type = "padding", val = 1}, sections.icon}})
end
return {{"goolord/alpha-nvim", branch = "main", config = _2_}}
