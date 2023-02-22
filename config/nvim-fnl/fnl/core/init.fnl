(local core (require :core.lib))
(local packer (require :packer))

(fn safe-require-plugin-config [name]
  (let [(ok? val-or-err) (pcall require (.. :modules. name))]
    (when (not ok?)
      (print (.. "config error: " val-or-err)))))

(fn install [...]
  "Iterates through the arguments as pairs and calls packer's use function for
  each of them. Works around Fennel not liking mixed associative and sequential
  tables as well."
  (let [pkgs [...]]
    (packer.startup (fn [use]
                      (for [i 1 (core.count pkgs) 2]
                        (let [name (. pkgs i)
                              opts (. pkgs (+ i 1))]
                          (use (core.assoc opts 1 name))
                          (-?> (. opts :mod) (safe-require-plugin-config)))))))
  nil)

;; fnlfmt: skip
(install :wbthomason/packer.nvim {} 
         :udayvir-singh/tangerine.nvim {}
         :nvim-lua/plenary.nvim {} 
         :rebelot/kanagawa.nvim {}
         :nvim-tree/nvim-tree.lua
         {:mod :ui.nvimtree
         :tag :nightly
         :requires [:nvim-tree/nvim-web-devicons]}
         :lewis6991/gitsigns.nvim
         {:mod :ui.vc-gutter}
         :nvim-treesitter/nvim-treesitter
         ;; Tree-Sitter
         {:mod :tools.tree-sitter
         :requires [:nvim-treesitter/playground
                     ;; rainbow parens!
                     :p00f/nvim-ts-rainbow
                     ;; view the tree + highlight
                     :nvim-treesitter/nvim-treesitter-textobjects]}
         :TimUntersberger/neogit
         {:mod :tools.neogit}
         :sindrets/diffview.nvim
         {:mod :tools.neogit.+diffview}
         ;; LSP
         :neovim/nvim-lspconfig {:mod :tools.lsp} 
         :Olical/conjure {:mod :tools.eval} 
         :tpope/vim-dispatch {} 
         :clojure-vim/clojure.vim {}
         :clojure-vim/vim-jack-in {} 
         :akinsho/flutter-tools.nvim {:mod :lang.flutter
         :requires [:nvim-lua/plenary.nvim]}
         :rcarriga/nvim-dap
         {:mod :tools.debugger
         :requires [:rcarriga/nvim-dap-ui
                     :jbyuki/one-small-step-for-vimkind
                     ;; view the tree + highlight
                     :nvim-treesitter/nvim-treesitter-textobjects]}
         ;; CMP
         :L3MON4D3/LuaSnip {:requires [:rafamadriz/friendly-snippets]}
         :hrsh7th/nvim-cmp
         {:mod :completion.cmp
         :requires [:onsails/lspkind.nvim
                     :hrsh7th/cmp-path
                     :hrsh7th/cmp-buffer
                     :hrsh7th/cmp-cmdline
                     :hrsh7th/cmp-nvim-lsp
                     :hrsh7th/cmp-nvim-lsp-signature-help
                     :PaterJason/cmp-conjure
                     :saadparwaiz1/cmp_luasnip]}
         :jose-elias-alvarez/null-ls.nvim {:mod :checkers.diagnostics}
         ;; Telescope
         :nvim-lua/telescope.nvim
         {:mod :editor.telescope
         :requires [:nvim-telescope/telescope-ui-select.nvim
                     :nvim-telescope/telescope-file-browser.nvim
                     :nvim-telescope/telescope-media-files.nvim
                     :nvim-telescope/telescope-project.nvim
                     :LukasPietzschmann/telescope-tabs
                     :jvgrootveld/telescope-zoxide]} 
         :terrortylor/nvim-comment {:mod :editor.nvim-comment}
         :folke/todo-comments.nvim
         {:mod :editor.todo-comments
         :requires [:nvim-lua/plenary.nvim]}
         ;; Sexp
         :guns/vim-sexp
         {:config (tset vim.g :sexp_filetypes
                        "clojure,scheme,lisp,timl,fennel,janet,hy")
         :requires [:tpope/vim-sexp-mappings-for-regular-people]}
         :mg979/vim-visual-multi {}
         :tpope/vim-repeat {}
         :tpope/vim-surround {}
         :tpope/vim-unimpaired {}
         ;; Smartparens
         :windwp/nvim-autopairs {:mod :completion.autopair}
         :kevinhwang91/nvim-ufo 
         {:mod :editor.fold
         :requires [:kevinhwang91/promise-async]}
         :goolord/alpha-nvim {:mod :ui.dashboard})

(require :config)
(require :modules.editor.scratch)
