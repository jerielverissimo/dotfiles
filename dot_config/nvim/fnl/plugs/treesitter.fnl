[{1 :nvim-treesitter/nvim-treesitter
    :build ":TSUpdate"
    :lazy false
    :dependencies [:nvim-treesitter/nvim-treesitter-textobjects]
    :config
    (fn []
      (let [parsers [:lua :fennel :vim :vimdoc :query
                     :javascript :typescript :html :css
                     :json :yaml :toml :markdown :markdown_inline
                     :bash :python :rust :go :c]]
        ;; Install parsers via nvim-treesitter
        (let [install (require :nvim-treesitter.install)]
          (set install.ensure_installed parsers))
        ;; Enable native treesitter highlighting and indentation
        (vim.api.nvim_create_autocmd
          :FileType
          {:callback
           (fn [args]
             (pcall (fn []
                      (vim.treesitter.start args.buf)
                      (set vim.bo.indentexpr "v:lua.require'nvim-treesitter'.indentexpr()"))))})))}]
