(local colors 
       {:background "#1D1C19"
       :foreground "#ded9bc"
       :cursorline "#16161d"
       :comment    "#54546D"
       :darker "#0d0d11"
       :cursor "#ded9bc"
       :black "#1D1C19"
       :color0 "#1D1C19"
       :color1 "#c4746e"
       :color2 "#8a9a7b"
       :color3 "#f0965f"
       :color4 "#7a8382"
       :color5 "#8992a7"
       :color6 "#7FB4CA"
       :color7 "#d7d2b5"
       :color8 "#1D1C19"
       :color9 "#c4746e"
       :color10 "#87a987"
       :color11 "#df8f5e"
       :color12 "#7a96cd"
       :color13 "#a292a3"
       :color14 "#70aac2"
       :color15 "#d1ccb1"})

(fn hex-to-rgb [c]
  (set-forcibly! c (string.lower c))
  [(tonumber (c:sub 2 3) 16)
   (tonumber (c:sub 4 5) 16)
   (tonumber (c:sub 6 7) 16)])

(fn blend [foreground background alpha]
  (set-forcibly! alpha (or (and (= (type alpha) :string)
				(/ (tonumber alpha 16) 255))
			   alpha))
  (local bg (hex-to-rgb background))
  (local fg (hex-to-rgb foreground))

  (fn blend-channel [i]
    (let [ret (+ (* alpha (. fg i)) (* (- 1 alpha) (. bg i)))]
      (math.floor (+ (math.min (math.max 0 ret) 255) 0.5))))

  (string.format "#%02x%02x%02x" (blend-channel 1) (blend-channel 2)
		 (blend-channel 3)))	

(fn darken [hex bg amount] (blend hex bg amount))

(local statusline
       {:StalineBranch {:bg colors.background :fg colors.comment}
       :StalineCommandMode {:bg colors.color9 :fg colors.black}
       :StalineCommandModeSep {:bg colors.color8 :fg colors.color9}
       :StalineConfirmMode {:bg colors.color6 :fg colors.black}
       :StalineConfirmModeSep {:bg colors.color8 :fg colors.color6}
       :StalineDefaultFile {:bg colors.background :fg colors.foreground}
       :StalineDiffAdd {:bg colors.background :fg colors.color10}
       :StalineDiffAddFancy {:bg (darken colors.color2 colors.black 0.07)
       :fg colors.color10}
       :StalineDiffChange {:bg colors.background :fg colors.color11}
       :StalineDiffChangeFancy {:bg (darken colors.color11 colors.black 0.07)
       :fg colors.color11}
       :StalineDiffRemove {:bg colors.background :fg colors.color9}
       :StalineDiffRemoveFancy {:bg (darken colors.color9 colors.black 0.07)
       :fg colors.color9}
       :StalineEmptySpace {:bg colors.background :fg colors.color15}
       :StalineFilename {:bg colors.background :fg colors.color7}
       :StalineFilenameFancy {:bg colors.cursorline :fg colors.color7}
       :StalineFilenameSep {:bg colors.black :fg colors.cursorline}
       :StalineFolderIcon {:bg colors.color1 :fg colors.black}
       :StalineFolderSep {:bg colors.black :fg colors.color1}
       :StalineFolderText {:bg (darken colors.color1 colors.black 0.05)
       :fg colors.color1}
       :StalineInsertMode {:bg colors.color10 :fg colors.black}
       :StalineInsertModeSep {:bg colors.color8 :fg colors.color10}
       :StalineLogo {:bg colors.black :fg colors.color12}
       :StalineLspError {:bg colors.black :fg colors.color9}
       :StalineLspErrorIcon {:bg colors.black :fg colors.color9}
       :StalineLspHints {:bg colors.black :fg colors.color6}
       :StalineLspHintsIcon {:bg colors.black :fg colors.color6}
       :StalineLspIcon {:bg colors.color13 :fg colors.black}
       :StalineLspInfo {:bg colors.black :fg colors.color12}
       :StalineLspInfoIcon {:bg colors.black :fg colors.color12}
       :StalineLspName {:bg (darken colors.color5 colors.black 0.07)
       :fg colors.color5}
       :StalineLspNameNormal {:bg (darken colors.color5 colors.black 0.07)
       :fg colors.color5}
       :StalineLspWarning {:bg colors.black :fg colors.color11}
       :StalineLspWarningIcon {:bg colors.black :fg colors.color11}
       :StalineModeSepTwo {:bg colors.cursorline :fg colors.color8}
       :StalineNTerminalMode {:bg colors.color13 :fg colors.black}
       :StalineNTerminalModeSep {:bg colors.color8 :fg colors.color13}
       :StalineNormalMode {:bg colors.color4 :fg colors.black}
       :StalineNormalModeSep {:bg colors.color8 :fg colors.color4}
       :StalineProgress {:bg (darken colors.color2 colors.black 0.05)
       :fg colors.color2}
       :StalineProgressIcon {:bg colors.color10 :fg colors.color8}
       :StalineProgressSep {:bg colors.color8 :fg colors.color10}
       :StalineTerminalMode {:bg colors.color13 :fg colors.black}
       :StalineTerminalModeSep {:bg colors.color8 :fg colors.color13}
       :StalineVisualMode {:bg colors.color11 :fg colors.black}
       :StalineVisualModeSep {:bg colors.color8 :fg colors.color11}})	

(local rainbow-delimiters {:RainbowDelimiterRed {:fg "#C34043"}
                           :RainbowDelimiterYellow {:fg "#E6C384"}
                           :RainbowDelimiterBlue {:fg "#658594"}
                           :RainbowDelimiterOrange {:fg "#FFA066"}
                           :RainbowDelimiterGreen {:fg "#98BB6C"}
                           :RainbowDelimiterViolet {:fg "#957FB8"}
                           :RainbowDelimiterCyan {:fg "#6A9589"}})

(fn load-highlight [group]
  (each [hl col (pairs group)]
    (vim.api.nvim_set_hl 0 hl col)))

(load-highlight statusline)
(load-highlight rainbow-delimiters)
