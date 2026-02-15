-- [nfnl] Compiled from fnl/plugs/devicons.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local nvim = autoload("nvim")
local function _2_()
  local devicons = require("nvim-web-devicons")
  local config = {default = true, override = {Dockerfile = {icon = "\239\140\136", name = "Dockerfile"}, astro = {icon = "\243\176\145\163", name = "SVELTE"}, c = {icon = "\238\152\158", name = "C"}, css = {icon = "\238\157\137", name = "CSS"}, deb = {icon = "\239\140\134", name = "Deb"}, html = {icon = "\239\132\187", name = "HTML"}, jpeg = {icon = "\239\128\190 ", name = "JPEG"}, jpg = {icon = "\239\128\190 ", name = "JPG"}, js = {icon = "\238\158\129 ", name = "JS"}, kt = {icon = "\238\152\180", name = "Kt"}, lock = {icon = "\243\176\140\190", name = "Lock"}, md = {icon = "\238\152\137"}, mp3 = {icon = "\243\176\142\136", name = "MP3"}, mp4 = {icon = "\239\133\132", name = "MP4"}, out = {icon = "\238\152\146", name = "Out"}, png = {icon = "\239\128\190", name = "PNG"}, py = {icon = "\238\152\134", name = "Py"}, rb = {icon = "\243\176\180\173"}, ["robots.txt"] = {icon = "\243\177\154\163", name = "robots"}, rpm = {icon = "\239\140\150", name = "RPM"}, rust = {icon = "\243\177\152\151", name = "Rust"}, toml = {icon = "\239\128\147", name = "TOML"}, ts = {icon = "\243\176\155\166", name = "TS"}, ttf = {icon = "\239\128\177", name = "TrueTypeFont"}, vim = {icon = "\238\159\133", name = "Vim"}, vue = {icon = "\243\176\161\132", name = "Vue"}, woff = {icon = "\239\128\177", name = "WebOpenFontFormat"}, woff2 = {icon = "\239\128\177", name = "WebOpenFontFormat2"}, xz = {icon = "\239\135\134", name = "XZ"}, yuck = {icon = "\243\176\135\183", name = "Yuck"}, zip = {icon = "\239\135\134", name = "Zip"}}}
  devicons.set_default_icon("\243\176\136\154")
  return devicons.setup(config)
end
return {{"nvim-tree/nvim-web-devicons", branch = "master", event = "BufRead", lazy = true, config = _2_}}
