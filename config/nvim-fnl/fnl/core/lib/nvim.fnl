(local vim vim)

(local api vim.api)

(local inspect vim.inspect)

(fn extend [t o]
  (let [mt (getmetatable t)]
    (each [k v (pairs o)]
      (rawset mt k v))
    t))

(fn nvim-print [...]
  (if (= (select "#" ...) 1) (api.nvim_out_write (inspect ...))
      (api.nvim_out_write (inspect [...])))
  (api.nvim_out_write "\n"))

(fn nvim-echo [...]
  (for [i 1 (select "#" ...)]
    (local part (select i ...))
    (api.nvim_out_write (tostring part))
    (api.nvim_out_write " "))
  (api.nvim_out_write "\n"))

(local window-options {:arab true
                       :arabic true
                       :breakindent true
                       :breakindentopt true
                       :bri true
                       :briopt true
                       :cc true
                       :cocu true
                       :cole true
                       :colorcolumn true
                       :concealcursor true
                       :conceallevel true
                       :crb true
                       :cuc true
                       :cul true
                       :cursorbind true
                       :cursorcolumn true
                       :cursorline true
                       :diff true
                       :fcs true
                       :fdc true
                       :fde true
                       :fdi true
                       :fdl true
                       :fdm true
                       :fdn true
                       :fdt true
                       :fen true
                       :fillchars true
                       :fml true
                       :fmr true
                       :foldcolumn true
                       :foldenable true
                       :foldexpr true
                       :foldignore true
                       :foldlevel true
                       :foldmarker true
                       :foldmethod true
                       :foldminlines true
                       :foldnestmax true
                       :foldtext true
                       :lbr true
                       :lcs true
                       :linebreak true
                       :list true
                       :listchars true
                       :nu true
                       :number true
                       :numberwidth true
                       :nuw true
                       :previewwindow true
                       :pvw true
                       :relativenumber true
                       :rightleft true
                       :rightleftcmd true
                       :rl true
                       :rlc true
                       :rnu true
                       :scb true
                       :scl true
                       :scr true
                       :scroll true
                       :scrollbind true
                       :signcolumn true
                       :spell true
                       :statusline true
                       :stl true
                       :wfh true
                       :wfw true
                       :winbl true
                       :winblend true
                       :winfixheight true
                       :winfixwidth true
                       :winhighlight true
                       :winhl true
                       :wrap true})

(fn validate [conf]
  (assert (= (type conf) :table))
  (local type-names {:t :table
                     :s :string
                     :n :number
                     :b :boolean
                     :f :function
                     :c :callable
                     :table :table
                     :string :string
                     :number :number
                     :boolean :boolean
                     :function :function
                     :callable :callable
                     :nil :nil
                     :thread :thread
                     :userdata :userdata})
  (each [k v (pairs conf)]
    (when (and (not (and (. v 3) (= (. v 1) nil)))
               (not= (type (. v 1)) (. type-names (. v 2))))
      (error (string.format "validation_failed: %q: expected %s, received %s" k
                            (. type-names (. v 2)) (type (. v 1))))))
  true)

(fn make-meta-accessor [get ___set___ del]
  (validate {:get [get :f] :set [___set___ :f] :del [del :f true]})
  (local mt {})
  (if del (fn mt.__newindex [self k v]
            (when (= v nil)
              (let [___antifnl_rtns_1___ [(del k)]]
                (lua "return (table.unpack or _G.unpack)(___antifnl_rtns_1___)")))
            (___set___ k v))
      (fn mt.__newindex [self k v]
        (___set___ k v)))

  (fn mt.__index [self k]
    (get k))

  (setmetatable {} mt))

(fn pcall-ret [status ...]
  (when status
    ...))

(fn nil-wrap [___fn___]
  (fn [...]
    (pcall-ret (pcall ___fn___ ...))))

(local ___fn___ (setmetatable {}
                              {:__index (fn [t k]
                                          (fn f [...]
                                            (api.nvim_call_function k [...]))

                                          (rawset t k f)
                                          f)}))

(fn getenv [k]
  (let [v (___fn___.getenv k)]
    (when (= v vim.NIL)
      (lua "return nil"))
    v))

(fn new-win-accessor [winnr]
  (fn get [k]
    (when (and (= winnr nil) (= (type k) :number))
      (let [___antifnl_rtns_1___ [(new-win-accessor k)]]
        (lua "return (table.unpack or _G.unpack)(___antifnl_rtns_1___)")))
    (api.nvim_win_get_var (or winnr 0) k))

  (fn ___set___ [k v]
    (api.nvim_win_set_var (or winnr 0) k v))

  (fn del [k]
    (api.nvim_win_del_var (or winnr 0) k))

  (make-meta-accessor (nil-wrap get) ___set___ del))

(fn new-win-opt-accessor [winnr]
  (fn get [k]
    (when (and (= winnr nil) (= (type k) :number))
      (let [___antifnl_rtns_1___ [(new-win-opt-accessor k)]]
        (lua "return (table.unpack or _G.unpack)(___antifnl_rtns_1___)")))
    (api.nvim_win_get_option (or winnr 0) k))

  (fn ___set___ [k v]
    (api.nvim_win_set_option (or winnr 0) k v))

  (make-meta-accessor (nil-wrap get) ___set___))

(fn new-buf-accessor [bufnr]
  (fn get [k]
    (when (and (= bufnr nil) (= (type k) :number))
      (let [___antifnl_rtns_1___ [(new-buf-accessor k)]]
        (lua "return (table.unpack or _G.unpack)(___antifnl_rtns_1___)")))
    (api.nvim_buf_get_var (or bufnr 0) k))

  (fn ___set___ [k v]
    (api.nvim_buf_set_var (or bufnr 0) k v))

  (fn del [k]
    (api.nvim_buf_del_var (or bufnr 0) k))

  (make-meta-accessor (nil-wrap get) ___set___ del))

(fn new-buf-opt-accessor [bufnr]
  (fn get [k]
    (when (. window-options k)
      (let [___antifnl_rtns_1___ [(api.nvim_err_writeln (.. k
                                                            " is a window option, not a buffer option"))]]
        (lua "return (table.unpack or _G.unpack)(___antifnl_rtns_1___)")))
    (when (and (= bufnr nil) (= (type k) :number))
      (let [___antifnl_rtns_1___ [(new-buf-opt-accessor k)]]
        (lua "return (table.unpack or _G.unpack)(___antifnl_rtns_1___)")))
    (api.nvim_buf_get_option (or bufnr 0) k))

  (fn ___set___ [k v]
    (when (. window-options k)
      (let [___antifnl_rtns_1___ [(api.nvim_err_writeln (.. k
                                                            " is a window option, not a buffer option"))]]
        (lua "return (table.unpack or _G.unpack)(___antifnl_rtns_1___)")))
    (api.nvim_buf_set_option (or bufnr 0) k v))

  (make-meta-accessor (nil-wrap get) ___set___))

(setmetatable {:print nvim-print
               :echo nvim-echo
               :fn (or (rawget vim :fn) ___fn___)
               : validate
               :g (or (rawget vim :g)
                      (make-meta-accessor (nil-wrap api.nvim_get_var)
                                          api.nvim_set_var api.nvim_del_var))
               :v (or (rawget vim :v)
                      (make-meta-accessor (nil-wrap api.nvim_get_vvar)
                                          api.nvim_set_vvar))
               :o (or (rawget vim :o)
                      (make-meta-accessor api.nvim_get_option
                                          api.nvim_set_option))
               :w (new-win-accessor nil)
               :b (new-buf-accessor nil)
               :env (or (rawget vim :env)
                        (make-meta-accessor getenv ___fn___.setenv))
               :wo (or (rawget vim :wo) (new-win-opt-accessor nil))
               :bo (or (rawget vim :bo) (new-buf-opt-accessor nil))
               :buf {:line api.nvim_get_current_line
                     :nr api.nvim_get_current_buf}
               :ex (setmetatable {}
                                 {:__index (fn [t k]
                                             (local command (k:gsub "_$" "!"))

                                             (fn f [...]
                                               (api.nvim_command (table.concat (vim.tbl_flatten [command
                                                                                                 ...])
                                                                               " ")))

                                             (rawset t k f)
                                             f)})}
              {:__index (fn [t k]
                          (local f (. api (.. :nvim_ k)))
                          (when f
                            (rawset t k f))
                          f)})
