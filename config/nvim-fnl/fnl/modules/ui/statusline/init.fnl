(local ___fn___ vim.fn)
(local icons {})
(set icons.lspkind {:Namespace ""
                    :Text " "
                    :Method " "
                    :Function " "
                    :Constructor " "
                    :Field "ﰠ "
                    :Variable " "
                    :Class "ﴯ "
                    :Interface " "
                    :Module " "
                    :Property "ﰠ "
                    :Unit "塞 "
                    :Value " "
                    :Enum " "
                    :Keyword " "
                    :Snippet " "
                    :Color " "
                    :File " "
                    :Reference " "
                    :Folder " "
                    :EnumMember " "
                    :Constant " "
                    :Struct "פּ "
                    :Event " "
                    :Operator " "
                    :TypeParameter " "
                    :Table ""
                    :Object " "
                    :Tag ""
                    :Array "[]"
                    :Boolean " "
                    :Number " "
                    :Null "ﳠ"
                    :String " "
                    :Calendar ""
                    :Watch " "
                    :Package ""
                    :Copilot " "})

(set icons.statusline_separators
     {:default {:left "" :right " "}
      :round {:left "" :right ""}
      :block {:left "█" :right "█"}
      :arrow {:left "" :right ""}})

(set icons.devicons {:default_icon {:icon "" :name :Default}
                     :c {:icon "" :name :c}
                     :css {:icon "" :name :css}
                     :deb {:icon "" :name :deb}
                     :Dockerfile {:icon "" :name :Dockerfile}
                     :html {:icon "" :name :html}
                     :jpeg {:icon "" :name :jpeg}
                     :jpg {:icon "" :name :jpg}
                     :js {:icon "" :name :js}
                     :kt {:icon "" :name :kt}
                     :lock {:icon "" :name :lock}
                     :lua {:icon "" :name :lua}
                     :mp3 {:icon "" :name :mp3}
                     :mp4 {:icon "" :name :mp4}
                     :out {:icon "" :name :out}
                     :png {:icon "" :name :png}
                     :py {:icon "" :name :py}
                     :robots.txt {:icon "ﮧ" :name :robots}
                     :toml {:icon "" :name :toml}
                     :ts {:icon "ﯤ" :name :ts}
                     :ttf {:icon "" :name :TrueTypeFont}
                     :rb {:icon "" :name :rb}
                     :rpm {:icon "" :name :rpm}
                     :vue {:icon "﵂" :name :vue}
                     :woff {:icon "" :name :WebOpenFontFormat}
                     :woff2 {:icon "" :name :WebOpenFontFormat2}
                     :xz {:icon "" :name :xz}
                     :zip {:icon "" :name :zip}})

(local sep-style :default)
(local separators
       (or (and (= (type sep-style) :table) sep-style)
           (. (. icons :statusline_separators) sep-style)))

(local sep-l (. separators :left))
(local sep-r (. separators :right))
(local modes {:n [:NORMAL :St_NormalMode]
              :niI ["NORMAL i" :St_NormalMode]
              :niR ["NORMAL r" :St_NormalMode]
              :niV ["NORMAL v" :St_NormalMode]
              :no [:N-PENDING :St_NormalMode]
              :i [:INSERT :St_InsertMode]
              :ic ["INSERT (completion)" :St_InsertMode]
              :ix ["INSERT completion" :St_InsertMode]
              :t [:TERMINAL :St_TerminalMode]
              :nt [:NTERMINAL :St_NTerminalMode]
              :v [:VISUAL :St_VisualMode]
              :V [:V-LINE :St_VisualMode]
              :Vs ["V-LINE (Ctrl O)" :St_VisualMode]
              "\022" [:V-BLOCK :St_VisualMode]
              :R [:REPLACE :St_ReplaceMode]
              :Rv [:V-REPLACE :St_ReplaceMode]
              :s [:SELECT :St_SelectMode]
              :S [:S-LINE :St_SelectMode]
              "\019" [:S-BLOCK :St_SelectMode]
              :c [:COMMAND :St_CommandMode]
              :cv [:COMMAND :St_CommandMode]
              :ce [:COMMAND :St_CommandMode]
              :r [:PROMPT :St_ConfirmMode]
              :rm [:MORE :St_ConfirmMode]
              :r? [:CONFIRM :St_ConfirmMode]
              :! [:SHELL :St_TerminalMode]})

(local modules {})

(set modules.mode
     (fn []
       (let [m (. (vim.api.nvim_get_mode) :mode)
             current-mode (.. "%#" (. (. modes m) 2) "#" "  "
                              (. (. modes m) 1))
             mode-sep1 (.. "%#" (. (. modes m) 2) :Sep "#" sep-r)]
         (.. current-mode mode-sep1 "%#ST_EmptySpace#" sep-r))))

(set modules.fileInfo (fn []
                        (var icon "  ")
                        (var filename
                             (or (and (= (___fn___.expand "%") "") "Empty ")
                                 (___fn___.expand "%:t")))
                        (when (not= filename "Empty ")
                          (local (devicons-present devicons)
                                 (pcall require :nvim-web-devicons))
                          (when devicons-present
                            (local ft-icon (devicons.get_icon filename))
                            (set icon
                                 (or (and (not= ft-icon nil) (.. " " ft-icon))
                                     "")))
                          (set filename (.. " " filename " ")))
                        (.. "%#St_file_info#" icon filename "%#St_file_sep#"
                            sep-r)))

(set modules.git
     (fn []
       (when (or (not vim.b.gitsigns_head) vim.b.gitsigns_git_status)
         (lua "return \"\""))
       (local git-status vim.b.gitsigns_status_dict)
       (local added (or (and (and git-status.added (not= git-status.added 0))
                             (.. "  " git-status.added))
                        ""))
       (local changed (or (and (and git-status.changed
                                    (not= git-status.changed 0))
                               (.. "  " git-status.changed))
                          ""))
       (local removed (or (and (and git-status.removed
                                    (not= git-status.removed 0))
                               (.. "  " git-status.removed))
                          ""))
       (local branch-name (.. "   " git-status.head " "))
       (.. "%#St_gitIcons#" branch-name added changed removed)))

(set modules.LSP_progress
     (fn []
       (when (not (rawget vim :lsp))
         (lua "return \"\""))
       (local Lsp (. (vim.lsp.util.get_progress_messages) 1))
       (when (or (< vim.o.columns 120) (not Lsp))
         (lua "return \"\""))
       (local msg (or Lsp.message ""))
       (local percentage (or Lsp.percentage 0))
       (local title (or Lsp.title ""))
       (local spinners ["" ""])
       (local ms (/ (vim.loop.hrtime) 1000000))
       (local frame (% (math.floor (/ ms 120)) (length spinners)))
       (local content (string.format " %%<%s %s %s (%s%%%%) "
                                     (. spinners (+ frame 1)) title msg
                                     percentage))
       (or (.. "%#St_LspProgress#" content) "")))

(set modules.LSP_Diagnostics
     (fn []
       (when (not (rawget vim :lsp))
         (lua "return \"\""))
       (var errors
            (length (vim.diagnostic.get 0
                                        {:severity vim.diagnostic.severity.ERROR})))
       (var warnings
            (length (vim.diagnostic.get 0
                                        {:severity vim.diagnostic.severity.WARN})))
       (var hints
            (length (vim.diagnostic.get 0
                                        {:severity vim.diagnostic.severity.HINT})))
       (var info
            (length (vim.diagnostic.get 0
                                        {:severity vim.diagnostic.severity.INFO})))
       (set errors (or (and (and errors (> errors 0))
                            (.. "%#St_lspError#" " " errors " "))
                       ""))
       (set warnings (or (and (and warnings (> warnings 0))
                              (.. "%#St_lspWarning#" "  " warnings " "))
                         ""))
       (set hints (or (and (and hints (> hints 0))
                           (.. "%#St_lspHints#" "ﯧ " hints " "))
                      ""))
       (set info (or (and (and info (> info 0))
                          (.. "%#St_lspInfo#" " " info " "))
                     ""))
       (.. errors warnings hints info)))

(set modules.LSP_status
     (fn []
       (when (rawget vim :lsp)
         (each [_ client (ipairs (vim.lsp.get_active_clients))]
           (when (. client.attached_buffers (vim.api.nvim_get_current_buf))
             (let [___antifnl_rtn_1___ (or (and (> vim.o.columns 100)
                                                (.. "%#St_LspStatus#"
                                                    "   LSP ~ " client.name
                                                    " "))
                                           "   LSP ")]
               (lua "return ___antifnl_rtn_1___")))))))

(set modules.cwd (fn []
                   (let [dir-icon (.. "%#St_cwd_icon#" " ")
                         dir-name (.. "%#St_cwd_text#" " "
                                      (___fn___.fnamemodify (___fn___.getcwd)
                                                            ":t")
                                      " ")]
                     (or (and (> vim.o.columns 85)
                              (.. "%#St_cwd_sep#" sep-l dir-icon dir-name))
                         ""))))

(set modules.cursor_position
     (fn []
       (let [left-sep (.. "%#St_pos_sep#" sep-l "%#St_pos_icon#" " ")
             current-line (___fn___.line ".")
             total-line (___fn___.line "$")]
         (var text (.. (math.modf (* (/ current-line total-line) 100))
                       (tostring "%%")))
         (set text (or (and (= current-line 1) :Top) text))
         (set text (or (and (= current-line total-line) :Bot) text))
         (.. left-sep "%#St_pos_text#" " " text " "))))

(local M {})

(set M.statusline
     (fn []
       (table.concat [(modules.mode)
                      (modules.fileInfo)
                      (modules.git)
                      "%="
                      (modules.LSP_progress)
                      "%="
                      (modules.LSP_Diagnostics)
                      (or (modules.LSP_status) "")
                      (modules.cwd)
                      (modules.cursor_position)])))

M
