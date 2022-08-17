(module config.plugin.treesitter
  {autoload {treesitter nvim-treesitter.configs}})

(treesitter.setup
  {:ensure_installed ["clojure" "fennel" "markdown" "org"]
   :sync_install true
   :highlight {:enable true}
   :indent    {:enable true}
    :rainbow  {
    :enable  true
    :extended_mode  true ;; Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
  }})
