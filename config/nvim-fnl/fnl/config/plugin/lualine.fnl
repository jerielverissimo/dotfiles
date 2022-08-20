(module config.plugin.lualine
  {autoload {core aniseed.core
             lualine lualine
             lsp config.plugin.lspconfig}})

(defn lsp_connection []
  (if (vim.tbl_isempty (vim.lsp.buf_get_clients 0)) "" ""))

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
    :normal   {:a {:fg (:fg1 colors) :bg (:color4 colors) :gui "bold"}
               :b {:fg (:fg2 colors) :bg (:color2 colors)}
               :c {:fg (:fg2 colors) :bg (:color3 colors)}}
    :command  {:a {:fg (:fg1 colors) :bg (:color5 colors) :gui "bold"}}
    :inactive {:a {:fg (:fg2 colors) :bg (:color2 colors)}}
    :insert   {:a {:fg (:fg1 colors) :bg (:color6 colors) :gui "bold"}}
    :replace  {:a {:fg (:fg1 colors) :bg (:color7 colors) :gui "bold"}}
    :terminal {:a {:fg (:fg1 colors) :bg (:color8 colors) :gui "bold"}}
    :visual   {:a {:fg (:fg1 colors) :bg (:color9 colors) :gui "bold"}}))

(lualine.setup
  {:options {:theme gruvbox-material-theme
             :icons_enabled true
             :section_separators ["" ""]
             :component_separators ["" ""]}
   :sections {:lualine_a []
              :lualine_b [[:mode {:upper true}]]
              :lualine_c [["FugitiveHead"]
                          [:filename {:filestatus true
                                      :path 1}]]
              :lualine_x [[:diagnostics {:sections [:error
                                                    :warn
                                                    :info
                                                    :hint]
                                         :sources [:nvim_lsp]}]
                          [lsp_connection]
                          :location
                          :filetype]
              :lualine_y [:encoding]
              :lualine_z []}
   :inactive_sections {:lualine_a []
                       :lualine_b []
                       :lualine_c [[:filename {:filestatus true
                                               :path 1}]]
                       :lualine_x []
                       :lualine_y []
                       :lualine_z []}})
