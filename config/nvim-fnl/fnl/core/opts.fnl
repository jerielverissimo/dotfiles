(local {: autoload} (require :nfnl.module))

(local str (autoload :nfnl.string))
(local nvim (autoload :nvim))
(local core (autoload :nfnl.core))

;sets a nvim global options
(let [options
       {:encoding      "utf-8"
       :spelllang      "en_us"
       :backspace      "2"
       :colorcolumn    "80"
       :errorbells     true
       :backup         false
       :swapfile       false
       :showmode       false
       ;show           line numbers
       :number         true
       :relativenumber true
       ;show           line and column number
       :ruler          true
       ;settings       needed for compe autocompletion
       :completeopt    "menuone,noselect"
       ;turn           on the wild menu, auto complete for commands in command line
       :wildmenu       true
       :wildignore     "*/tmp/*,*.so,*.swp,*.zip"
       ;case           insensitive search
       :ignorecase     true
       ;smart          search case
       :smartcase      true
       ;shared         clipboard with linux
       :clipboard      "unnamedplus"
       ;show           invisible characters
       :list           false
       :listchars      (str.join "," ["tab:▶-" "trail:•" "extends:»" "precedes:«" "eol:¬"])
       ;tabs           is space
       :expandtab      true
       ;tab/indent     size
       :tabstop        2
       :shiftwidth     2
       :softtabstop    2
       ;persistent     undo
       :undofile       true
       ;open           new horizontal panes on down pane
       :splitbelow     true
       ;open           new vertical panes on right pane
       :splitright     true
       ;enable         highlighting search
       :hlsearch       true
       ;makes          signcolumn always one column with signs and linenumber
       ;;:signcolumn   "number"
       :laststatus     3
       :numberwidth    3
       :conceallevel   2
       :concealcursor  :nc
       :fillchars      (str.join "," ["vert:│" "diff:╱" "foldclose:" "foldopen:" "fold: " "msgsep:─"])}]
  (each [option value (pairs options)]
    (core.assoc nvim.o option value)))

