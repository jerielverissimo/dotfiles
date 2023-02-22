(import-macros {: let!} :core.lib.macros)

(var chocolate {})

(set chocolate.base_30 {:white "#DCD7BA"
                        :darker_black "#191922"
                        :black "#1F1F28"
                        :black2 "#25252e"
                        :one_bg "#272730"
                        :one_bg2 "#2f2f38"
                        :one_bg3 "#363646"
                        :grey "#43434c"
                        :grey_fg "#4c4c55"
                        :grey_fg2 "#53535c"
                        :light_grey "#5c5c65"
                        :red "#d8616b"
                        :baby_pink "#D27E99"
                        :pink "#c8748f"
                        :line "#31313a"
                        :green "#98BB6C"
                        :vibrant_green "#a3c677"
                        :nord_blue "#7E9CD8"
                        :blue "#7FB4CA"
                        :yellow "#FF9E3B"
                        :sun "#FFA066"
                        :purple "#a48ec7"
                        :dark_purple "#9c86bf"
                        :teal "#7AA89F"
                        :orange "#fa9b61"
                        :cyan "#A3D4D5"
                        :statusline_bg "#24242d"
                        :lightbg "#33333c"
                        :pmenu_bg "#a48ec7"
                        :folder_bg "#7E9CD8"})

(set chocolate.base_16 {:base00 "#1f1f28"
                        :base01 "#2a2a37"
                        :base02 "#223249"
                        :base03 "#363646"
                        :base04 "#4c4c55"
                        :base05 "#c8c3a6"
                        :base06 "#d2cdb0"
                        :base07 "#DCD7BA"
                        :base08 "#d8616b"
                        :base09 "#ffa066"
                        :base0A "#dca561"
                        :base0B "#98bb6c"
                        :base0C "#7fb4ca"
                        :base0D "#7e9cd8"
                        :base0E "#9c86bf"
                        :base0F "#d8616b"})

;; fnlfmt: skip
(set chocolate.polish_hl
     {"@include" {:fg chocolate.base_30.purple}
                  "@uri" {:fg chocolate.base_30.blue}
                  "@tag.delimiter" {:fg chocolate.base_30.red}
                  :Number {:fg chocolate.base_30.baby_pink}})

(set vim.opt.bg :dark)

(local colors chocolate.base_30)

(local theme chocolate.base_16)

;; Defaults

(local defaults
       {:MatchWord {:bg colors.grey :fg colors.white}
        :Pmenu {:bg colors.one_bg}
        :PmenuSbar {:bg colors.one_bg}
        :PmenuSel {:bg colors.pmenu_bg :fg colors.black}
        :PmenuThumb {:bg colors.grey}
        :MatchParen {:link :MatchWord}
        :Comment {:fg colors.grey_fg}
        :CursorLineNr {:fg colors.white}
        :LineNr {:fg colors.grey}
        :FloatBorder {:fg colors.blue}
        :NormalFloat {:bg colors.darker_black}
        :NvimInternalError {:fg colors.red}
        :WinSeparator {:fg colors.line}
        :PackerPackageName {:fg colors.red}
        :PackerSuccess {:fg colors.green}
        :PackerStatusSuccess {:fg theme.base08}
        :PackerStatusCommit {:fg colors.blue}
        :PackeProgress {:fg colors.blue}
        :PackerOutput {:fg colors.red}
        :PackerStatus {:fg colors.blue}
        :PackerHash {:fg colors.blue}
        :Normal {:fg theme.base05 :bg theme.base00}
        :Bold {:bold true}
        :Debug {:fg theme.base08}
        :Directory {:fg theme.base0D}
        :Error {:fg theme.base00 :bg theme.base08}
        :ErrorMsg {:fg theme.base08 :bg theme.base00}
        :Exception {:fg theme.base08}
        :FoldColumn {:fg theme.base0C :bg theme.base01}
        :Folded {:fg theme.base03 :bg theme.base01}
        :IncSearch {:fg theme.base01 :bg theme.base09}
        :Italic {:italic true}
        :Macro {:fg theme.base08}
        :ModeMsg {:fg theme.base0B}
        :MoreMsg {:fg theme.base0B}
        :Question {:fg theme.base0D}
        :Search {:fg theme.base01 :bg theme.base0A}
        :Substitute {:fg theme.base01 :bg theme.base0A :sp :none}
        :SpecialKey {:fg theme.base03}
        :TooLong {:fg theme.base08}
        :UnderLined {:fg theme.base0B}
        :Visual {:bg theme.base02}
        :VisualNOS {:fg theme.base08}
        :WarningMsg {:fg theme.base08}
        :WildMenu {:fg theme.base08 :bg theme.base0A}
        :Title {:fg theme.base0D :sp :none}
        :Conceal {:bg :NONE}
        :Cursor {:fg theme.base00 :bg theme.base05}
        :NonText {:fg theme.base03}
        :SignColumn {:fg theme.base03 :sp :NONE}
        :ColorColumn {:bg theme.base01 :sp :none}
        :CursorColumn {:bg theme.base01 :sp :none}
        :CursorLine {:bg :none :sp :none}
        :QuickFixLine {:bg theme.base01 :sp :none}
        :SpellBad {:undercurl true :sp theme.base08}
        :SpellLocal {:undercurl true :sp theme.base0C}
        :SpellCap {:undercurl true :sp theme.base0D}
        :SpellRare {:undercurl true :sp theme.base0E}
        :healthSuccess {:bg colors.green :fg colors.black}})

(local syntax {:Boolean {:fg theme.base09}
               :Character {:fg theme.base08}
               :Conditional {:fg theme.base0E}
               :Constant {:fg theme.base08}
               :Define {:fg theme.base0E :sp :none}
               :Delimiter {:fg theme.base0F}
               :Float {:fg theme.base09}
               :Variable {:fg theme.base05}
               :Function {:fg theme.base0D}
               :Identifier {:fg colors.yellow :sp :none}
               :Include {:fg theme.base0D}
               :Keyword {:fg theme.base0E}
               :Label {:fg theme.base0A}
               :Number {:fg theme.base09}
               :Operator {:fg theme.base05 :sp :none}
               :PreProc {:fg theme.base0A}
               :Repeat {:fg theme.base0A}
               :Special {:fg theme.base0C}
               :SpecialChar {:fg theme.base0F}
               :Statement {:fg theme.base08}
               :StorageClass {:fg theme.base0A}
               :String {:fg theme.base0B}
               :Structure {:fg theme.base0E}
               :Tag {:fg theme.base0A}
               :Todo {:fg theme.base0A :bg theme.base01}
               :Type {:fg theme.base0A :sp :none}
               :Typedef {:fg theme.base0A}})

;; fnlfmt: skip
(local treesitter
       {"@annotation" {:fg theme.base0F}
        "@attribute" {:fg chocolate.base_30.cyan}
        "@character" {:fg theme.base08}
        "@constructor" {:fg theme.base0C}
        "@constant.builtin" {:fg theme.base09}
        "@constant.macro" {:fg theme.base08}
        "@error" {:fg theme.base08}
        "@exception" {:fg theme.base08}
        "@float" {:fg theme.base09}
        "@keyword" {:fg theme.base0E}
        "@keyword.function" {:fg theme.base0E}
        "@keyword.return" {:fg theme.base0E}
        "@function" {:fg theme.base0D}
        "@function.builtin" {:fg chocolate.base_30.yellow}
        "@function.macro" {:fg theme.base08}
        "@keyword.operator" {:fg theme.base0E}
        "@method" {:fg theme.base0D}
        "@namespace" {:fg theme.base08}
        "@none" {:fg theme.base05}
        "@parameter" {:fg chocolate.base_30.green}
        "@reference" {:fg theme.base05}
        "@punctuation.bracket" {:fg chocolate.base_16.base06}
        "@punctuation.delimiter" {:fg theme.base0F}
        "@punctuation.special" {:fg theme.base08}
        "@string.regex" {:fg theme.base0C}
        "@string.escape" {:fg theme.base0C}
        "@symbol" {:fg theme.base0B}
        "@tag" {:link :Tag}
        "@tag.attribute" {:link "@property"}
        "@tag.delimiter" {:fg theme.base0F}
        "@text" {:fg theme.base05}
        "@text.strong" {:bold true}
        "@text.emphasis" {:fg theme.base09}
        "@text.strike" {:fg theme.base00 :strikethrough true}
        "@text.literal" {:fg theme.base09}
        "@text.uri" {:fg theme.base09 :underline true}
        "@type.builtin" {:fg theme.base0A}
        "@variable" {:fg chocolate.base_16.base06}
        "@variable.builtin" {:fg theme.base09}
        "@definition" {:sp theme.base04 :underline true}
        "TSDefinitionUsage" {:sp theme.base04 :underline true}
        "@scope" {:bold true}
        "@field" {:fg chocolate.base_30.purple}
        "@property" {:fg theme.base08}
        "@include" {:link :Include}
        "@conditional" {:link :Conditional}
        "@field" {:fg chocolate.base_30.purple}
        "@variable" {:fg chocolate.base_16.base06}
        "@module" {:fg chocolate.base_30.beige}
        "Operator" {:fg chocolate.base_30.blue}
        "@attribute" {:fg chocolate.base_30.cyan}
        "@punctuation.bracket" {:fg chocolate.base_16.base06}
        "@parenthesis" {:link "@punctuation.bracket"}
        "@parameter" {:fg chocolate.base_30.green}
        "@function.builtin" {:fg chocolate.base_30.yellow}})

(local nvimtree
       {:NvimTreeEmptyFolderName {:fg colors.folder_bg}
        :NvimTreeEndOfBuffer {:fg colors.darker_black}
        :NvimTreeFolderIcon {:fg colors.folder_bg}
        :NvimTreeFolderName {:fg colors.folder_bg}
        :NvimTreeGitDirty {:fg colors.red}
        :NvimTreeIndentMarker {:fg colors.grey_fg}
        :NvimTreeNormal {:bg colors.darker_black}
        :NvimTreeNormalNC {:bg colors.darker_black}
        :NvimTreeOpenedFolderName {:fg colors.folder_bg}
        :NvimTreeGitIgnored {:fg colors.light_grey}
        :NvimTreeWinSeparator {:fg colors.darker_black :bg colors.darker_black}
        :NvimTreeWindowPicker {:fg colors.red :bg colors.black2}
        :NvimTreeCursorLine {:bg colors.black2}
        :NvimTreeGitNew {:fg colors.yellow}
        :NvimTreeGitDeleted {:fg colors.red}
        :NvimTreeSpecialFile {:fg colors.yellow :bold true}
        :NvimTreeRootFolder {:fg colors.red :bold true}})

(local cmp {:CmpItemAbbr {:fg colors.white}
            :CmpItemAbbrMatch {:fg colors.blue :bold true}
            :CmpBorder {:fg colors.grey}
            :CmpDocBorder {:fg colors.darker_black :bg colors.darker_black}
            :CmPmenu {:bg colors.darker_black}
            :CmpItemKindConstant {:fg theme.base09}
            :CmpItemKindFunction {:fg theme.base0D}
            :CmpItemKindIdentifier {:fg theme.base08}
            :CmpItemKindField {:fg theme.base08}
            :CmpItemKindVariable {:fg theme.base0E}
            :CmpItemKindSnippet {:fg colors.red}
            :CmpItemKindText {:fg theme.base0B}
            :CmpItemKindStructure {:fg theme.base0E}
            :CmpItemKindType {:fg theme.base0A}
            :CmpItemKindKeyword {:fg theme.base07}
            :CmpItemKindMethod {:fg theme.base0D}
            :CmpItemKindConstructor {:fg colors.blue}
            :CmpItemKindFolder {:fg theme.base07}
            :CmpItemKindModule {:fg theme.base0A}
            :CmpItemKindProperty {:fg theme.base08}
            :CmpItemKindUnit {:fg theme.base0E}
            :CmpItemKindFile {:fg theme.base07}
            :CmpItemKindColor {:fg colors.red}
            :CmpItemKindReference {:fg theme.base05}
            :CmpItemKindStruct {:fg theme.base0E}
            :CmpItemKindOperator {:fg theme.base05}
            :CmpItemKindTypeParameter {:fg theme.base08}
            :CmpItemKindCopilot {:fg colors.green}})

(local alpha {:DashboardHeader {:fg colors.pink}
              :AlphaButtons {:fg colors.light_grey}})

(local statusline
       {:StatusLine {:bg colors.statusline_bg}
        :St_gitIcons {:fg colors.light_grey
                      :bg colors.statusline_bg
                      :bold true}
        :St_lspError {:fg colors.red :bg colors.statusline_bg}
        :St_lspWarning {:fg colors.yellow :bg colors.statusline_bg}
        :St_LspHints {:fg colors.purple :bg colors.statusline_bg}
        :St_LspInfo {:fg colors.green :bg colors.statusline_bg}
        :St_LspStatus {:fg colors.nord_blue :bg colors.statusline_bg}
        :St_LspProgress {:fg colors.green :bg colors.statusline_bg}
        :St_LspStatus_Icon {:fg colors.black :bg colors.nord_blue}
        :St_NormalMode {:bg colors.nord_blue :fg colors.black :bold true}
        :St_InsertMode {:bg colors.dark_purple :fg colors.black :bold true}
        :St_TerminalMode {:bg colors.green :fg colors.black :bold true}
        :St_NTerminalMode {:bg colors.yellow :fg colors.black :bold true}
        :St_VisualMode {:bg colors.cyan :fg colors.black :bold true}
        :St_ReplaceMode {:bg colors.orange :fg colors.black :bold true}
        :St_ConfirmMode {:bg colors.teal :fg colors.black :bold true}
        :St_CommandMode {:bg colors.green :fg colors.black :bold true}
        :St_SelectMode {:bg colors.nord_blue :fg colors.black :bold true}
        :St_NormalModeSep {:fg colors.nord_blue :bg colors.grey}
        :St_InsertModeSep {:fg colors.dark_purple :bg colors.grey}
        :St_TerminalModeSep {:fg colors.green :bg colors.grey}
        :St_NTerminalModeSep {:fg colors.yellow :bg colors.grey}
        :St_VisualModeSep {:fg colors.cyan :bg colors.grey}
        :St_ReplaceModeSep {:fg colors.orange :bg colors.grey}
        :St_ConfirmModeSep {:fg colors.teal :bg colors.grey}
        :St_CommandModeSep {:fg colors.green :bg colors.grey}
        :St_SelectModeSep {:fg colors.nord_blue :bg colors.grey}
        :St_EmptySpace {:fg colors.grey :bg colors.lightbg}
        :St_EmptySpace2 {:fg colors.grey :bg colors.statusline_bg}
        :St_file_info {:bg colors.lightbg :fg colors.white}
        :St_file_sep {:bg colors.statusline_bg :fg colors.lightbg}
        :St_cwd_icon {:fg colors.one_bg :bg colors.red}
        :St_cwd_text {:fg colors.white :bg colors.lightbg}
        :St_cwd_sep {:fg colors.red :bg colors.statusline_bg}
        :St_pos_sep {:fg colors.green :bg colors.lightbg}
        :St_pos_icon {:fg colors.black :bg colors.green}
        :St_pos_text {:fg colors.green :bg colors.lightbg}})

(local lsp {:LspReferenceText {:fg colors.darker_black :bg colors.white}
            :LspReferenceRead {:fg colors.darker_black :bg colors.white}
            :LspReferenceWrite {:fg colors.darker_black :bg colors.white}
            :DiagnosticHint {:fg colors.purple}
            :DiagnosticError {:fg colors.red}
            :DiagnosticWarn {:fg colors.yellow}
            :DiagnosticInformation {:fg colors.green}
            :LspSignatureActiveParameter {:fg colors.black :bg colors.green}
            :RenamerTitle {:fg colors.black :bg colors.red}
            :RenamerBorder {:fg colors.red}})

(local git {:DiffAdd {:fg colors.blue}
            :DiffAdded {:fg colors.green}
            :DiffChange {:fg colors.light_grey}
            :DiffChangeDelete {:fg colors.red}
            :DiffModified {:fg colors.orange}
            :DiffDelete {:fg colors.red}
            :DiffRemoved {:fg colors.red}
            :gitcommitOverflow {:fg theme.base08}
            :gitcommitSummary {:fg theme.base08}
            :gitcommitComment {:fg theme.base03}
            :gitcommitUntracked {:fg theme.base03}
            :gitcommitDiscarded {:fg theme.base03}
            :gitcommitSelected {:fg theme.base03}
            :gitcommitHeader {:fg theme.base0E}
            :gitcommitSelectedType {:fg theme.base0D}
            :gitcommitUnmergedType {:fg theme.base0D}
            :gitcommitDiscardedType {:fg theme.base0D}
            :gitcommitBranch {:fg theme.base09 :bold true}
            :gitcommitUntrackedFile {:fg theme.base0A}
            :gitcommitUnmergedFile {:fg theme.base08 :bold true}
            :gitcommitDiscardedFile {:fg theme.base08 :bold true}
            :gitcommitSelectedFile {:fg theme.base0B :bold true}})

(local telescope
       {:TelescopeBorder {:fg colors.darker_black :bg colors.darker_black}
        :TelescopePromptBorder {:fg colors.black2 :bg colors.black2}
        :TelescopePromptNormal {:fg colors.white :bg colors.black2}
        :TelescopePromptPrefix {:fg colors.red :bg colors.black2}
        :TelescopeNormal {:bg colors.darker_black}
        :TelescopePreviewTitle {:fg colors.black :bg colors.green}
        :TelescopePromptTitle {:fg colors.black :bg colors.red}
        :TelescopeResultsTitle {:fg colors.darker_black
                                :bg colors.darker_black}
        :TelescopeSelection {:bg colors.black2 :fg colors.white}
        :TelescopeResultsDiffAdd {:fg colors.green}
        :TelescopeResultsDiffChange {:fg colors.yellow}
        :TelescopeResultsDiffDelete {:fg colors.red}})

;;(set! termguicolors true)

;(let! terminal_color_0 theme.base01)
;(let! terminal_color_1 theme.base08)
;(let! terminal_color_2 theme.base0B)
;(let! terminal_color_3 theme.base0A)
;(let! terminal_color_4 theme.base0D)
;(let! terminal_color_5 theme.base0E)
;(let! terminal_color_6 theme.base0C)
;(let! terminal_color_7 theme.base05)
;;;(let! terminal_color_8 theme.base03)
;(let! terminal_color_9 theme.base08)
;(let! terminal_color_10 theme.base0B)
;(let! terminal_color_11 theme.base0A)
;(let! terminal_color_12 theme.base0D)
;(let! terminal_color_13 theme.base0E)
;(let! terminal_color_14 theme.base0C)
;(let! terminal_color_15 theme.base07)

(fn load_highlight [group]
  (each [hl col (pairs group)]
    (vim.api.nvim_set_hl 0 hl col)))

(fn load_theme []
  ;(load_highlight defaults)
  (load_highlight statusline)
  (load_highlight telescope)
  ;(load_highlight syntax)
  ;(load_highlight treesitter)
  ;(load_highlight nvimtree)
  ;(load_highlight cmp)
  ;(load_highlight alpha)
  ;(load_highlight lsp)
  ;(load_highlight git)
  ;(load_highlight chocolate.polish_hl)
  )

(load_theme)
