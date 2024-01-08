(local ___fn___ vim.fn)

(fn M [m]
  (var icon "  ")
  (var filename (or (and (= (___fn___.expand "%") "") "Empty ")
                    (___fn___.expand "%:t")))
  (if (not= filename "Empty ")
      (let [devicons (require :nvim-web-devicons)]
        (var (ft-icon icon-hl) (devicons.get_icon filename))
        (set icon (or (and (not= ft-icon nil) (.. " " ft-icon)) ""))
        (when (not icon-hl) (set icon-hl :StalineDefaultFile))
        (when (= filename :NvimTree_1) (set filename "File Explorer"))
        (when (= filename "[startuptime]") (set filename "Startup Time"))
        (when (string.find filename :toggleterm) (set filename :Terminal))
        (if (= m :minimal)
            (.. "%#StalineFilenameIcon#" "%#" icon-hl "# " icon
                "  %#StalineFilename#" filename "  ") (= m :fancy)
            (.. "%#StalineFilenameFancy#" icon "  " filename "   "
                "%#StalineFilenameSep#" " %#StalineEmptySpace#")))
      (if (= m :minimal)
          "%#StalineFilename#  Nomad " (= m :fancy)
          (.. "%#StalineFilenameFancy#" "  Nomad  " "%#StalineFilenameSep#"
              " %#StalineEmptySpace#"))))

M	
