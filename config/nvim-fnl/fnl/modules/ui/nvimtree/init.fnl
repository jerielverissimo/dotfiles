(local tree (require :nvim-tree))

(tree.setup {:sort_by :case_sensitive
             :view {:mappings {:list [{:key :u :action :dir_up}]}}
             ;; :renderer {:group_empty true}
             :filters {:dotfiles false}
             :disable_netrw true})
