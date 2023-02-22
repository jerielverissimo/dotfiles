(local {: djb2} (require :core.lib.crypt))
(local {: nil?
        : str?
        : tbl?
        : ->str
        : first
        : second
        : all?
        : begins-with?
        : count} (require :core.lib))

(lambda expr->str [expr]
  `(macrodebug ,expr nil))

;; This marker can be used by a post-processor to delete a useless byproduct line.
(local delete-marker :TANGERINE_DELETE_ME)

;; Various symbols we want to use multiple times.
;; Avoids the compiler complaining that we're introducing locals without gensym.
(local mod-name-sym (sym :*module-name*))
(local mod-sym (sym :*module*))
(local mod-locals-sym (sym :*module-locals*))
(local autoload-sym (sym :autoload))

(fn def- [name value]
  `[,delete-marker
    (local ,name ,value)
    (tset ,mod-locals-sym ,(tostring name) ,name)])

(fn def [name value]
  `[,delete-marker (local ,name ,value) (tset ,mod-sym ,(tostring name) ,name)])

(fn defn- [name ...]
  `[,delete-marker
    (fn ,name
      ,...)
    (tset ,mod-locals-sym ,(tostring name) ,name)])

(fn defn [name ...]
  `[,delete-marker
    (fn ,name
      ,...)
    (tset ,mod-sym ,(tostring name) ,name)])

(fn defonce- [name value]
  `(def- ,name (or (. ,mod-sym ,(tostring name)) ,value)))

(fn defonce [name value]
  `(def ,name (or (. ,mod-sym ,(tostring name)) ,value)))

(fn deftest [name ...]
  `(let [tests# (or (. ,mod-sym :aniseed/tests) {})]
     (tset tests# ,(tostring name) (fn [,(sym :t)]
                                     ,...))
     (tset ,mod-sym :aniseed/tests tests#)))

(fn time [...]
  `(let [start# (vim.loop.hrtime)
         result# (do
                   ,...)
         end# (vim.loop.hrtime)]
     (print (.. "Elapsed time: " (/ (- end# start#) 1000000) " msecs"))
     result#))

(fn conditional-let [branch bindings ...]
  (assert (= 2 (length bindings)) "expected a single binding pair")
  (let [[bind-expr value-expr] bindings]
    (if ;; Simple symbols
        ;; [foo bar]
        (sym? bind-expr)
        `(let [,bind-expr ,value-expr]
           (,branch ,bind-expr ,...))
        ;; List / values destructure
        ;; [(a b) c]
        (list? bind-expr)
        (do
          ;; Even if the user isn't using the first slot, we will.
          ;; [(_ val) (pcall #:foo)]
          ;;  => [(bindGENSYM12345 val) (pcall #:foo)]
          (when (= `_ (. bind-expr 1))
            (tset bind-expr 1 (gensym :bind)))
          `(let [,bind-expr ,value-expr]
             (,branch ,(. bind-expr 1) ,...)))
        ;; Sequential and associative table destructure
        ;; [[a b] c]
        ;; [{: a : b} c]
        (table? bind-expr)
        `(let [value# ,value-expr
               ,bind-expr (or value# {})]
           (,branch value# ,...))
        ;; We should never get here, but just in case.
        (assert (.. "unknown bind-expr type: " (type bind-expr))))))

(fn if-let [bindings ...]
  (assert (<= (length [...]) 2)
          (.. "if-let does not support more than two branches"))
  (conditional-let `if bindings ...))

(fn when-let [bindings ...]
  (conditional-let `when bindings ...))

(lambda fn? [x]
  "Checks if `x` is a function definition.
  Cannot check if a symbol is a function in compile time."
  (and (list? x)
       (or (= `fn (first x)) (= `hashfn (first x)) (= `lambda (first x))
           (= `partial (first x)))))

(lambda quoted? [x]
  "Check if `x` is a list that begins with `quote`."
  (and (list? x) (= `quote (first x))))

(lambda quoted->fn [expr]
  "Converts an expression like `(quote (+ 1 1))` into `(fn [] (+ 1 1))`."
  (assert-compile (quoted? expr) "expected quoted expression for expr" expr)
  (let [non-quoted (second expr)]
    `(fn []
       ,non-quoted)))

(lambda quoted->str [expr]
  "Converts a quoted expression like `(quote (+ 1 1))` into an string with its shorthand form."
  (assert-compile (quoted? expr) "expected quoted expression for expr" expr)
  (let [non-quoted (second expr)]
    (.. "'" (view non-quoted))))

(lambda expand-exprs [exprs]
  "Converts a list of expressions into either an expression - if only one
  expression is in the list - or a do-expression containing the expressions."
  (if (> (length exprs) 1)
      `(do
         ,(unpack exprs))
      (first exprs)))

(lambda gensym-checksum [x ?options]
  "Generates a new symbol from the checksum of the object passed as a parameter
  after it is casted into an string using the `view` function.
  You can also pass a prefix or a suffix into the options optional table.
  This function depends on the djb2 hash function."
  (let [options (or ?options {})
        prefix (or options.prefix "")
        suffix (or options.suffix "")]
    (sym (.. prefix (djb2 (view x)) suffix))))

(lambda vlua [x]
  "Return a symbol mapped to `v:lua.%s()` where `%s` is the symbol."
  (assert-compile (sym? x) "expected symbol for x" x)
  (string.format "v:lua.%s()" (->str x)))

(lambda colorscheme [scheme]
  "Set a colorschem using the vim.api.nvim_cmd API.
  Accepts the following arguments:
  scheme -> a symbol.
  Example of use:
  ```fennel
  (colorscheme carbon)
  ```"
  (assert-compile (sym? scheme) "expected symbol for name" scheme)
  (let [scheme (->str scheme)]
    `(vim.api.nvim_cmd {:cmd :colorscheme :args [,scheme]} {})))

(lambda autocmd! [event pattern command ?options]
  "Create an autocommand using the nvim_create_autocmd API.
  Accepts the following arguments:
  event -> can be either a symbol or a list of symbols.
  pattern -> can be either a symbol or a list of symbols. If it's <buffer> the
             buffer option is set to 0. If the buffer option is set this value
             is ignored.
  command -> can be an string, a symbol, a function or a quoted expression.
  options -> a table of options. Optional. If the :desc option is not specified
             it will be inferred.
  Example of use:
  ```fennel
  (autocmd! VimEnter *.py '(print \"Hello World\")
            {:once true :group \"custom\" :desc \"This is a description\"})
  ```
  That compiles to:
  ```fennel
  (vim.api.nvim_create_autocmd :VimEnter
                               {:pattern \"*.py\"
                                :callback (fn [] (print \"Hello World\"))
                                :once true
                                :group \"custom\"
                                :desc \"This is a description\"})
  ```"
  (assert-compile (or (sym? event) (and (tbl? event) (all? #(sym? $) event))
                      "expected symbol or list of symbols for event" event))
  (assert-compile (or (sym? pattern)
                      (and (tbl? pattern) (all? #(sym? $) pattern))
                      "expected symbol or list of symbols for pattern" pattern))
  (assert-compile (or (str? command) (sym? command) (fn? command)
                      (quoted? command))
                  "expected string, symbol, function or quoted expression for command"
                  command)
  (assert-compile (or (nil? ?options) (tbl? ?options))
                  "expected table for options" ?options)
  (let [event (if (and (tbl? event) (not (sym? event)))
                  (icollect [_ v (ipairs event)]
                    (->str v))
                  (->str event))
        pattern (if (and (tbl? pattern) (not (sym? pattern)))
                    (icollect [_ v (ipairs pattern)]
                      (->str v))
                    (->str pattern))
        options (or ?options {})
        options (if (nil? options.buffer)
                    (if (= :<buffer> pattern)
                        (doto options
                          (tset :buffer 0))
                        (doto options
                          (tset :pattern pattern)))
                    options)
        options (if (str? command)
                    (doto options
                      (tset :command command))
                    (doto options
                      (tset :callback
                            (if (quoted? command)
                                (quoted->fn command)
                                command))))
        options (if (nil? options.desc)
                    (doto options
                      (tset :desc
                            (if (quoted? command) (quoted->str command)
                                (str? command) command
                                (view command))))
                    options)]
    `(vim.api.nvim_create_autocmd ,event ,options)))

(lambda autocmd! [event pattern command ?options]
  "Create an autocommand using the nvim_create_autocmd API.
  Accepts the following arguments:
  event -> can be either a symbol or a list of symbols.
  pattern -> can be either a symbol or a list of symbols. If it's <buffer> the
             buffer option is set to 0. If the buffer option is set this value
             is ignored.
  command -> can be an string, a symbol, a function or a quoted expression.
  options -> a table of options. Optional. If the :desc option is not specified
             it will be inferred.
  Example of use:
  ```fennel
  (autocmd! VimEnter *.py '(print \"Hello World\")
            {:once true :group \"custom\" :desc \"This is a description\"})
  ```
  That compiles to:
  ```fennel
  (vim.api.nvim_create_autocmd :VimEnter
                               {:pattern \"*.py\"
                                :callback (fn [] (print \"Hello World\"))
                                :once true
                                :group \"custom\"
                                :desc \"This is a description\"})
  ```"
  (assert-compile (or (sym? event) (and (tbl? event) (all? #(sym? $) event))
                      "expected symbol or list of symbols for event" event))
  (assert-compile (or (sym? pattern)
                      (and (tbl? pattern) (all? #(sym? $) pattern))
                      "expected symbol or list of symbols for pattern" pattern))
  (assert-compile (or (str? command) (sym? command) (fn? command)
                      (quoted? command))
                  "expected string, symbol, function or quoted expression for command"
                  command)
  (assert-compile (or (nil? ?options) (tbl? ?options))
                  "expected table for options" ?options)
  (let [event (if (and (tbl? event) (not (sym? event)))
                  (icollect [_ v (ipairs event)]
                    (->str v))
                  (->str event))
        pattern (if (and (tbl? pattern) (not (sym? pattern)))
                    (icollect [_ v (ipairs pattern)]
                      (->str v))
                    (->str pattern))
        options (or ?options {})
        options (if (nil? options.buffer)
                    (if (= :<buffer> pattern)
                        (doto options
                          (tset :buffer 0))
                        (doto options
                          (tset :pattern pattern)))
                    options)
        options (if (str? command)
                    (doto options
                      (tset :command command))
                    (doto options
                      (tset :callback
                            (if (quoted? command)
                                (quoted->fn command)
                                command))))
        options (if (nil? options.desc)
                    (doto options
                      (tset :desc
                            (if (quoted? command) (quoted->str command)
                                (str? command) command
                                (view command))))
                    options)]
    `(vim.api.nvim_create_autocmd ,event ,options)))

(lambda augroup! [name ...]
  "Create an augroup using the nvim_create_augroup API.
  Accepts either a name or a name and a list of autocmd statements.
  Example of use:
  ```fennel
  (augroup! a-nice-group
    (autocmd! Filetype *.py '(print \"Hello World\"))
    (autocmd! Filetype *.sh '(print \"Hello World\")))
  ```
  That compiles to:
  ```fennel
  (do
    (vim.api.nvim_create_augroup \"a-nice-group\" {:clear false})
    (autocmd! Filetype *.py '(print \"Hello World\") {:group \"a-nice-group\"})
    (autocmd! Filetype *.sh '(print \"Hello World\") {:group \"a-nice-group\"}))
  ```"
  (assert-compile (or (str? name) (sym? name))
                  "expected string or symbol for name" name)
  (assert-compile (all? #(and (list? $)
                              (or (= `clear! (first $)) (= `autocmd! (first $))))
                        [...])
                  "expected autocmd exprs for body" ...)
  (expand-exprs (let [name (->str name)]
                  (icollect [_ expr (ipairs [...]) &into [`(vim.api.nvim_create_augroup ,name
                                                                                        {:clear false})]]
                    (if (= `autocmd! (first expr))
                        (let [[_ event pattern command ?options] expr
                              options (or ?options {})
                              options (doto options
                                        (tset :group name))]
                          `(autocmd! ,event ,pattern ,command ,options))
                        (let [[_ ?options] expr]
                          `(clear! ,name ,?options)))))))

(lambda clear! [name ?options]
  "Clears an augroup using the nvim_clear_autocmds API.
  Example of use:
  ```fennel
  (clear! some-group)
  ```
  That compiles to:
  ```fennel
  (vim.api.nvim_clear_autocmds {:group \"some-group\"})
  ```"
  (assert-compile (or (str? name) (sym? name))
                  "expected string or symbol for name" name)
  (assert-compile (or (nil? ?options) (tbl? ?options))
                  "expected table for options" ?options)
  (let [name (->str name)
        options (or ?options {})
        options (doto options
                  (tset :group name))]
    `(vim.api.nvim_clear_autocmds ,options)))

(lambda let-with-scope! [[scope] name value]
  (assert-compile (or (str? scope) (sym? scope))
                  "expected string or symbol for scope" scope)
  (assert-compile (or (= :b (->str scope)) (= :w (->str scope))
                      (= :t (->str scope)) (= :g (->str scope)))
                  "expected scope to be either b, w, t or g" scope)
  (assert-compile (or (str? name) (sym? name))
                  "expected string or symbol for name" name)
  (let [name (->str name)
        scope (->str scope)]
    `(tset ,(match scope
              :b `vim.b
              :w `vim.w
              :t `vim.t
              :g `vim.g) ,name ,value)))

(lambda let-global! [name value]
  (assert-compile (or (str? name) (sym? name))
                  "expected string or symbol for name" name)
  (let [name (->str name)]
    `(tset vim.g ,name ,value)))

(lambda let! [...]
  "Set a vim variable using the vim.<scope>.name API.
  Accepts the following arguments:
  [scope] -> optional. Can be either [g], [w], [t] or [b]. It's either a symbol
             or a string surrounded by square brackets.
  name -> either a symbol or a string.
  value -> anything.
  Example of use:
  ```fennel
  (let! hello :world)
  (let! [w] hello :world)
  ```
  That compiles to:
  ```fennel
  (tset vim.g :hello :world)
  (tset vim.w :hello :world)
  ```"
  (match [...]
    [[scope] name value] (let-with-scope! [scope] name value)
    [name value] (let-global! name value)
    _ (error "expected let! to have at least two arguments: name value")))

(lambda shared-command! [api-function name command ?options]
  (assert-compile (sym? api-function) "expected symbol for api-function"
                  api-function)
  (assert-compile (sym? name) "expected symbol for name" name)
  (assert-compile (or (str? command) (sym? command) (fn? command)
                      (quoted? command))
                  "expected string, symbol, function or quoted expression for command"
                  command)
  (assert-compile (or (nil? ?options) (tbl? ?options))
                  "expected table for options" ?options)
  (let [name (->str name)
        options (or ?options {})
        options (if (nil? options.desc)
                    (doto options
                      (tset :desc
                            (if (quoted? command) (quoted->str command)
                                (str? command) command
                                (view command))))
                    options)
        command (if (quoted? command) (quoted->fn command) command)]
    `(,api-function ,name ,command ,options)))

(lambda command! [name command ?options]
  "Create a new user command using the vim.api.nvim_create_user_command API.
  Accepts the following arguments:
  name -> must be a symbol.
  command -> can be an string, a symbol, a function or a quoted expression.
  options -> a table of options. Optional. If the :desc option is not specified
             it will be inferred.
  Example of use:
  ```fennel
  (command! Salute '(print \"Hello World\")
            {:bang true :desc \"This is a description\"})
  ```
  That compiles to:
  ```fennel
  (vim.api.nvim_create_user_command \"Salute\" (fn [] (print \"Hello World\"))
                                    {:bang true
                                     :desc \"This is a description\"})
  ```"
  (shared-command! `vim.api.nvim_create_user_command name command ?options))

(lambda map! [[modes] lhs rhs ?options]
  "Add a new mapping using the vim.keymap.set API.
  Accepts the following arguments:
  modes -> is a sequence containing a symbol, each character of the symbol is
           a mode.
  lhs -> must be an string.
  rhs -> can be an string, a symbol, a function or a quoted expression.
  options -> a table of options. Optional. If the :desc option is not specified
             it will be inferred.
  Example of use:
  ```fennel
  (map! [nv] \"<leader>lr\" vim.lsp.references
        {:silent true :buffer 0 :desc \"This is a description\"})
  ```
  That compiles to:
  ```fennel
  (vim.keymap.set [:n :v] \"<leader>lr\" vim.lsp.references
                  {:silent true
                   :buffer 0
                   :desc \"This is a description\"})
  ```"
  (assert-compile (sym? modes) "expected symbol for modes" modes)
  (assert-compile (str? lhs) "expected string for lhs" lhs)
  (assert-compile (or (str? rhs) (sym? rhs) (fn? rhs) (quoted? rhs))
                  "expected string, symbol, function or quoted expression for rhs"
                  rhs)
  (assert-compile (or (nil? ?options) (tbl? ?options))
                  "expected table for options" ?options)
  (let [modes (icollect [char (string.gmatch (->str modes) ".")]
                char)
        options (or ?options {})
        options (if (nil? options.desc)
                    (doto options
                      (tset :desc
                            (if (quoted? rhs) (quoted->str rhs)
                                (str? rhs) rhs
                                (view rhs))))
                    options)
        rhs (if (quoted? rhs) (quoted->fn rhs) rhs)]
    `(vim.keymap.set ,modes ,lhs ,rhs ,options)))

(lambda set! [name ?value]
  "Set a vim option using the vim.opt.<name> API.
  Accepts the following arguments:
  name -> must be a symbol.
          - If it ends with '+' it appends to the current value.
          - If it ends with '-' it removes from the current value.
          - If it ends with with '^' it prepends to the current value.
  value -> anything.
           - If it is not specified, whether the name begins with 'no' is used
             as a boolean value.
           - If it is a quoted expression or a function it becomes
             v:lua.<symbol>()."
  (assert-compile (sym? name) "expected symbol for name" name)
  (let [name (->str name)
        value (if (nil? ?value)
                  (not (begins-with? :no name))
                  ?value)
        value (if (quoted? value)
                  (quoted->fn value)
                  value)
        name (if (and (nil? ?value) (begins-with? :no name))
                 (name:match "^no(.+)$")
                 name)
        exprs (if (fn? value) [`(tset _G
                                      ,(->str (gensym-checksum value
                                                               {:prefix "__"}))
                                      ,value)] [])
        value (if (fn? value)
                  (vlua (gensym-checksum value {:prefix "__"}))
                  value)
        exprs (doto exprs
                (table.insert (match (name:sub -1)
                                "+" `(: (. vim.opt ,(name:sub 1 -2)) :append
                                        ,value)
                                "-" `(: (. vim.opt ,(name:sub 1 -2)) :remove
                                        ,value)
                                "^" `(: (. vim.opt ,(name:sub 1 -2)) :prepend
                                        ,value)
                                _ `(tset vim.opt ,name ,value))))]
    (expand-exprs exprs)))

(lambda local-set! [name ?value]
  "Set a vim option using the vim.opt_local.<name> API.
  Accepts the following arguments:
  name -> must be a symbol.
          - If it ends with '+' it appends to the current value.
          - If it ends with '-' it removes from the current value.
          - If it ends with with '^' it prepends to the current value.
  value -> anything.
           - If it is not specified, whether the name begins with 'no' is used
             as a boolean value.
           - If it is a quoted expression or a function it becomes
             v:lua.<symbol>()."
  (assert-compile (sym? name) "expected symbol for name" name)
  (let [name (->str name)
        value (if (nil? ?value)
                  (not (begins-with? :no name))
                  ?value)
        value (if (quoted? value)
                  (quoted->fn value)
                  value)
        name (if (and (nil? ?value) (begins-with? :no name))
                 (name:match "^no(.+)$")
                 name)
        exprs (if (fn? value) [`(tset _G
                                      ,(->str (gensym-checksum value
                                                               {:prefix "__"}))
                                      ,value)] [])
        value (if (fn? value)
                  (vlua (gensym-checksum value {:prefix "__"}))
                  value)
        exprs (doto exprs
                (table.insert (match (name:sub -1)
                                "+" `(: (. vim.opt_local ,(name:sub 1 -2))
                                        :append ,value)
                                "-" `(: (. vim.opt_local ,(name:sub 1 -2))
                                        :remove ,value)
                                "^" `(: (. vim.opt_local ,(name:sub 1 -2))
                                        :prepend ,value)
                                _ `(tset vim.opt_local ,name ,value))))]
    (expand-exprs exprs)))

{: def-
 : def
 : defn-
 : defn
 : defonce-
 : defonce
 : if-let
 : when-let
 : deftest
 : time
 : expr->str
 : vlua
 : colorscheme
 : autocmd!
 : augroup!
 : clear!
 : map!
 : let!
 : set!
 : local-set!
 : command!}
