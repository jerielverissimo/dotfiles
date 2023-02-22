(local alpha (require :alpha))

(local startup-file :/tmp/nvim-startuptime)
(local startup-time-pattern "([%d.]+)  [%d.]+: [-]+ NVIM STARTED [-]+")
(local startup-time-file (or (and (io.open startup-file)
                                  (: (io.open startup-file) :read :*a))
                             nil))

(local startup-time (or (and startup-time-file
                             (tonumber (startup-time-file:match startup-time-pattern)))
                        nil))

(var text "")
(if (and startup-time (>= startup-time 1000))
    (set text (string.format "nomad loaded in %.1fs" (* startup-time 0.001))))

(: (io.open startup-file :w) :close)

(fn button [sc txt keybind keybind-opts]
  (let [sc- (: (sc:gsub "%s" "") :gsub :SPC :<leader>)
        opts {:position :center
              :shortcut sc
              :cursor 5
              :width 50
              :align_shortcut :right
              :hl :DashboardCenter
              :hl_shortcut :DashboardShortCut}]
    (when keybind
      (set opts.keymap
           [:n sc- keybind {:noremap true :silent true :nowait true}]))

    (fn on-press []
      (let [key (vim.api.nvim_replace_termcodes (or keybind (.. sc- :<Ignore>))
                                                true false true)]
        (vim.api.nvim_feedkeys key :t false)))

    {:type :button :val txt :on_press on-press : opts}))

(local sections
       {:header {:type :text
                 :val ["███╗   ██╗ ██████╗ ███╗   ███╗ █████╗ ██████╗ "
                       "████╗  ██║██╔═══██╗████╗ ████║██╔══██╗██╔══██╗"
                       "██╔██╗ ██║██║   ██║██╔████╔██║███████║██║  ██║"
                       "██║╚██╗██║██║   ██║██║╚██╔╝██║██╔══██║██║  ██║"
                       "██║ ╚████║╚██████╔╝██║ ╚═╝ ██║██║  ██║██████╔╝"
                       "╚═╝  ╚═══╝ ╚═════╝ ╚═╝     ╚═╝╚═╝  ╚═╝╚═════╝ "]
                 :opts {:position :center :hl :DashboardHeader}}
        :buttons {:type :group
                  :val [(button "SPC q l" "  Reload last session"
                                ":Telescope find_files <CR>")
                        (button "SPC o A" "  Open agenda"
                                ":Telescope oldfiles<CR>")
                        (button "SPC f r" "  Recently opened files"
                                ":Telescope oldfiles<CR>")
                        (button "SPC p p" "  Open project" ":<CR>")
                        (button "SPC RET" "  Jump to bookmark"
                                ":Telescope marks<CR>")
                        (button "SPC f P" "  Open private configuration"
                                ":Telescope keymaps<CR>")
                        (button "SPC h d h" "  Open documentation"
                                ":Telescope keymaps<CR>")]
                  :opts {:spacing 1}}
        :footer {:type :text :val text :opts {:position :center :hl :Comment}}
        :icon {:type :button
               :val "ﯙ"
               :opts {:position :center :hl :Decorator}
               :on_press (fn []
                           (if (= (vim.fn.has :mac) 1)
                               (os.execute "open https://github.com/nomad-engineering/nomad.nvim")
                               (os.execute "xdg-open https://github.com/nomad-engineering/nomad.nvim")))}})

(alpha.setup {:layout [{:type :padding :val 4}
                       sections.header
                       {:type :padding :val 2}
                       sections.buttons
                       {:type :padding :val 2}
                       sections.footer
                       {:type :padding :val 1}
                       sections.icon]})
