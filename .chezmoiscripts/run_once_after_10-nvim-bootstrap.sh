#!/usr/bin/env bash
# Bootstrap Neovim on a fresh machine: compile Fennel sources to Lua, then
# install all plugins via lazy.nvim.
#
# Only .fnl sources are tracked in this dotfiles repo; the matching .lua is
# regenerated locally by nfnl. On a fresh checkout the lua/{core,hls,plugs,ui}/
# directories don't exist yet, so init.lua's lazy.setup("plugs") and nfnl's
# init=require("core") would both fail — we have to compile before running
# user init.

set -e

if ! command -v nvim >/dev/null 2>&1; then
  echo "[chezmoi] nvim not installed; skipping bootstrap" >&2
  exit 0
fi

NVIM_DATA="${XDG_DATA_HOME:-$HOME/.local/share}/nvim"
NFNL_PATH="$NVIM_DATA/lazy/nfnl"

# 1. Pre-clone nfnl so step 2 can compile .fnl without depending on init.lua.
if [ ! -d "$NFNL_PATH" ]; then
  echo "[chezmoi] cloning nfnl..."
  git clone --filter=blob:none --single-branch \
    https://github.com/Olical/nfnl.git "$NFNL_PATH"
fi

# 2. Compile all .fnl → .lua via a minimal nvim that bypasses user init.
echo "[chezmoi] compiling Fennel sources via nfnl..."
(
  cd "$HOME/.config/nvim" && nvim --headless --clean -u NONE \
    --cmd "set runtimepath+=$NFNL_PATH" \
    -c "lua require('nfnl.api')['compile-all-files']()" \
    -c "qa!" >/dev/null 2>&1
) || {
  echo "[chezmoi] nfnl compile failed" >&2
  exit 1
}

# 3. Now init.lua can load — sync all plugins via lazy.nvim.
echo "[chezmoi] syncing all plugins via lazy.nvim..."
nvim --headless "+Lazy! sync" +qa >/dev/null 2>&1 || true

echo "[chezmoi] nvim bootstrap complete"
