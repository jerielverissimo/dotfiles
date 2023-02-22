-- Neovim configuration Entrypoint
-- Bootstrap packer package manager
-- Aniseed compiles and loads fnl/core/init.fnl and required namespaces

local execute = vim.api.nvim_command
local fn = vim.fn

local pack_path = fn.stdpath("data") .. "/site/pack"
local fmt = string.format

function ensure(user, repo)
  -- Ensures a given github.com/USER/REPO is cloned in the pack/packer/start directory.
  local install_path = fmt("%s/packer/start/%s", pack_path, repo, repo)
  if fn.empty(fn.glob(install_path)) > 0 then
    execute(fmt("!git clone https://github.com/%s/%s %s", user, repo, install_path))
    execute(fmt("packadd %s", repo))
  end
end

-- Bootstrap essential plugins required for installing and loading the rest.
ensure("wbthomason", "packer.nvim")
-- ensure("Olical", "aniseed")

-- Enable Aniseed's automatic compilation and loading of Fennel source code.
-- vim.g["aniseed#env"] = {
--	module = "core.init",
--	compile = true
-- }

-- plugin manager
local pack = "packer"

local function bootstrap(url, ref)
  local name = url:gsub(".*/", "")
  local path = vim.fn.stdpath([[data]]) .. "/site/pack/" .. pack .. "/start/" .. name

  if vim.fn.isdirectory(path) == 0 then
    print(name .. ": installing in data dir...")

    vim.fn.system({ "git", "clone", url, path })
    if ref then
      vim.fn.system({ "git", "-C", path, "checkout", ref })
    end

    vim.cmd([[redraw]])
    print(name .. ": finished installing")
  end
end

-- bootstrap "https://github.com/lewis6991/impatient.nvim"
--bootstrap("https://github.com/rktjmp/hotpot.nvim")
bootstrap("https://github.com/udayvir-singh/tangerine.nvim", "v2.3")
-- require [[impatient]]

require("tangerine").setup({
  compiler = {
    -- disable popup showing compiled files
    verbose = false,

    -- compile every time changed are made to fennel files or on entering vim
    hooks = { "onsave", "oninit" },
  },
})

require("core")
