local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({"git", "clone", "https://github.com/wbthomason/packer.nvim", install_path})
  execute "packadd packer.nvim"
end

return require("packer").startup(
  function()
    -- Packer can manage itself
    use "wbthomason/packer.nvim"
    use {"kabouzeid/nvim-lspinstall", event = "BufRead"}
    use {"neovim/nvim-lspconfig"}
    use "hrsh7th/nvim-cmp" -- Autocompletion plugin
    use "hrsh7th/cmp-nvim-lsp" -- LSP source for nvim-cmp
    use "hrsh7th/cmp-buffer"
    use "saadparwaiz1/cmp_luasnip" -- Snippets source for nvim-cmp
    use "L3MON4D3/LuaSnip" -- Snippets plugin
    use "ray-x/lsp_signature.nvim"
    use "kyazdani42/nvim-web-devicons"
    use "onsails/lspkind-nvim"
    use "simrat39/rust-tools.nvim"
    use "tpope/vim-commentary"
    use "ruanyl/coverage.vim"
    use "nvim-lua/plenary.nvim"
    use "nvim-lua/popup.nvim"
    use "nvim-telescope/telescope.nvim"
    use "nvim-telescope/telescope-fzy-native.nvim"
    use "nvim-lua/lsp-status.nvim"
    use "nvim-lua/lsp_extensions.nvim"
    use "sainnhe/gruvbox-material"
    use "folke/which-key.nvim"
    use "hrsh7th/vim-vsnip"
    use "hrsh7th/vim-vsnip-integ"
    use "rafamadriz/friendly-snippets"
    use "mhartington/formatter.nvim"
    use "Yggdroot/indentLine"
    use "nvim-treesitter/playground"
    use "jose-elias-alvarez/nvim-lsp-ts-utils"
    use "norcalli/nvim-colorizer.lua"
    use "sindrets/diffview.nvim"
    use "famiu/feline.nvim"
    use "p00f/nvim-ts-rainbow"
    use 'Olical/conjure'
    use 'clojure-vim/vim-jack-in'
    use 'guns/vim-sexp'
    use 'tpope/vim-sexp-mappings-for-regular-people'
    use 'tpope/vim-repeat'
    use {"akinsho/flutter-tools.nvim", requires = "nvim-lua/plenary.nvim"}
    use 'tpope/vim-dispatch'
    -- Autopairs
    use "windwp/nvim-autopairs"
    use {
      "kyazdani42/nvim-tree.lua",
      requires = "kyazdani42/nvim-web-devicons"
    }
    -- Treesitter
    use {
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate"
    }
    use {
      "lewis6991/gitsigns.nvim"
    }
    use "lewis6991/spellsitter.nvim"
    use {
      "nvim-neorg/neorg",
      requires = "nvim-lua/plenary.nvim"
    }
  end
)
