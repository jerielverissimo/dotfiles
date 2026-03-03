(local api vim.api)

(local modes {"\019" [:S-BLOCK :StalineSelectMode]
              "\022" [:V-BLOCK :StalineVisualMode]
              :! [:SHELL :StalineTerminalMode]
              :R [:REPLACE :StalineReplaceMode]
              :Rv [:V-REPLACE :StalineReplaceMode]
              :S [:S-LINE :StalineSelectMode]
              :V [:V-LINE :StalineVisualMode]
              :Vs ["V-LINE (Ctrl O)" :StalineVisualMode]
              :c [:COMMAND :StalineCommandMode]
              :ce [:COMMAND :StalineCommandMode]
              :cv [:COMMAND :StalineCommandMode]
              :i [:INSERT :StalineInsertMode]
              :ic ["INSERT (completion)" :StalineInsertMode]
              :ix ["INSERT completion" :StalineInsertMode]
              :n [:NORMAL :StalineNormalMode]
              :niI ["NORMAL i" :StalineNormalMode]
              :niR ["NORMAL r" :StalineNormalMode]
              :niV ["NORMAL v" :StalineNormalMode]
              :no [:N-PENDING :StalineNormalMode]
              :nt [:NTERMINAL :StalineNTerminalMode]
              :r [:PROMPT :StalineConfirmMode]
              :r? [:CONFIRM :StalineConfirmMode]
              :rm [:MORE :StalineConfirmMode]
              :s [:SELECT :StalineSelectMode]
              :t [:TERMINAL :StalineTerminalMode]
              :v [:VISUAL :StalineVisualMode]})

(fn M [m]
  (let [mode (. (api.nvim_get_mode) :mode)
        sep (.. "%#" (. (. modes mode) 2) :Sep "#" "  ")
        septwo (.. "%#StalineModeSepTwo" "#" " ")]
    (if (= m :minimal) (.. "%#" (. (. modes mode) 2) "#" " "
                           (. (. modes mode) 1) " ")
        (= m :fancy)
        (.. "%#" (. (. modes mode) 2) "#" "   " (. (. modes mode) 1) " " sep
            septwo "") :F)))

M	
