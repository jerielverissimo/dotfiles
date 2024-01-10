[{1 :lewis6991/gitsigns.nvim
    :config
    (fn []
      (let [gitsigns (require :gitsigns)]
        (gitsigns.setup {:signs {:add {:text "+"}
                        :change {:text "~"}
                        :changedelete {:text "~_"}
                        :delete {:text "_"}
                        :topdelete {:text "‾"}
                        :untracked {:text "┆"}}})))}]
