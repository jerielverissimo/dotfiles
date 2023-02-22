(local neogit (require :neogit))

(neogit.setup {:disable_signs false
               :disable_hint true
               :disable_context_highlighting false
               :disable_builtin_notifications true
               :status {:recent_commit_count 10}
               :signs {:section ["" ""]
                       :item ["" ""]
                       :hunk ["" ""]}
               :integrations {:diffview true}
               :sections {:recent {:folded false}}
               :mappings {:status {:B :BranchPopup}}})
