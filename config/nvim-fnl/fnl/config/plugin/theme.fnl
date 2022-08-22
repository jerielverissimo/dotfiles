(module config.plugin.theme-gruvbox
  {autoload {theme gruvbox-material}})

;; Theme variants: dark/dimmed/dark_default/dark_colorblind/light/light_default/light_colorblind

(theme.setup {:theme_style "dark"
              :comment_style "italic"})
