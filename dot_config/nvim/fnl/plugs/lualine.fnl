[{1 :nvim-lualine/lualine.nvim
  :dependencies [:nvim-tree/nvim-web-devicons]
  :config
  (fn []
    (let [lualine (require :lualine)]
      (lualine.setup {:options {:component_separators {:left "" :right ""} 
:section_separators {:left "" :right ""} 
:always_divide_middle false
:disabled_filetypes ["nvim-tree"]
                     }
                     :sections {:lualine_a ["mode"]
:lualine_b ["branch" "diff" "diagnostics"]
:lualine_c ["filename"]
:lualine_x []
:lualine_y []
:lualine_z []

                     }

                     })))}]
