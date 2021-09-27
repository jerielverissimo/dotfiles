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
    use {"neovim/nvim-lspconfig"}
    use {"kabouzeid/nvim-lspinstall", event = "BufRead"}
    use "hrsh7th/nvim-compe"
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
    -- use {"npxbr/gruvbox.nvim", requires = {"rktjmp/lush.nvim"}}
    use "folke/which-key.nvim"
    use "hrsh7th/vim-vsnip"
    use "hrsh7th/vim-vsnip-integ"
    use "rafamadriz/friendly-snippets"
    use "mhartington/formatter.nvim"
    -- use 'lukas-reineke/indent-blankline.nvim'
    use "Yggdroot/indentLine"
    use "nvim-treesitter/playground"
    -- use 'jiangmiao/auto-pairs'
    use "jose-elias-alvarez/nvim-lsp-ts-utils"
    use "oberblastmeister/neuron.nvim"
    use "norcalli/nvim-colorizer.lua"
    use "sindrets/diffview.nvim"
    use "famiu/feline.nvim"
    -- Autopairs
    use "windwp/nvim-autopairs"
    use {
      "kyazdani42/nvim-tree.lua",
      requires = "kyazdani42/nvim-web-devicons",
      config = function()
        require "nvim-tree".setup {}
      end
    }
    -- Treesitter
    use {
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate"
    }

    use {
      "lewis6991/gitsigns.nvim",
      requires = {
        "nvim-lua/plenary.nvim"
      }
    }
    use "lewis6991/spellsitter.nvim"
  end
)
