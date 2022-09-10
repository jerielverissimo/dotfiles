(module config.plugin.theme-lualine
  {autoload {core aniseed.core
             lualine lualine
             lsp config.plugin.lspconfig}})


;; Icon for LSP session
(defn lsp_connection []
  (if (vim.tbl_isempty (vim.lsp.buf_get_clients 0)) "" ""))

(def colors {:fg1     "#282828" 
             :color2  "#504945" 
             :fg2     "#ddc7a1" 
             :color3  "#32302f" 
             :color4  "#a89984" 
             :color5  "#7daea3" 
             :color6  "#a9b665" 
             :color7  "#d8a657" 
             :color8  "#d3869b" 
             :color9  "#ea6962" })

(def gruvbox-material-theme
  (core.assoc
    (require :lualine.themes.auto)
    :normal   {:a {:fg (. colors :fg1) :bg (. colors :color4) :gui :bold}
               :b {:fg (. colors :fg2) :bg (. colors :color2)}
               :c {:fg (. colors :fg2) :bg (. colors :color3)}}
    :command  {:a {:fg (. colors :fg1) :bg (. colors :color5) :gui :bold}}
    :inactive {:a {:fg (. colors :fg2) :bg (. colors :color2)}}
    :insert   {:a {:fg (. colors :fg1) :bg (. colors :color6) :gui :bold}}
    :replace  {:a {:fg (. colors :fg1) :bg (. colors :color7) :gui :bold}}
    :terminal {:a {:fg (. colors :fg1) :bg (. colors :color8) :gui :bold}}
    :visual   {:a {:fg (. colors :fg1) :bg (. colors :color9) :gui :bold}}))


(lualine.setup
  {:options {:theme gruvbox-material-theme
             :icons_enabled true
             :section_separators ["" ""]
             :component_separators ["" ""]}

   :sections {:lualine_a [[:mode {:upper true}]]
              :lualine_b [[:filename {:filestatus true
                                      :path 1}]]
              :lualine_c [[:branch]
                          [:diff
                           {:diff_color
                            {:added    :GitSignsAdd
                             :modified :GitSignsChange
                             :removed  :GitSignsDelete}
                            :symbols {:added " "
                                      :modified " "
                                      :removed " "}
                                  }]]
              :lualine_x [[:diagnostics
                           {:sections [:error :warn :info :hint]
                            :diagnostics_color
                            {:error :LualineDiagnosticError
                             :warn :LualineDiagnosticWarn
                             :info :LualineDiagnosticInfo
                             :hint :LualineDiagnosticHint}
                             :symbols {:error " "
                                       :warn " "
                                       :info " "
                                       :hint " "}
                             ;; :sources [:nvim_lsp]
                             :sources [:nvim_diagnostic]
                             }]
                          [lsp_connection]]
              :lualine_y [:location]
              :lualine_z [:filetype]}

   :inactive_sections {:lualine_a []
                       :lualine_b []
                       :lualine_c [[:filename {:filestatus true
                                               :path 1}]]
                       :lualine_x []
                       :lualine_y []
                       :lualine_z []}})
