(local ___fn___ vim.fn)

(fn M [m]
  (let [current (___fn___.line ".")
        total (___fn___.line "$")]
    (if (= m :minimal)
        (.. "%#StalineProgress#" " " current "/" total " "
            "%#StalineProgressIcon#" " " "%#StalineEmptySpace#")
        (= m :fancy)
        (.. "%#StalineProgressIcon#" "   " "%#StalineProgress#" " " current
            "/" total " " "%#StalineEmptySpace#") :F)))

M	
