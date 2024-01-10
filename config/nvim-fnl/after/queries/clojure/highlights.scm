;; extends

; Function definitions
(list_lit
 .
 (sym_lit) @_keyword.function
 (#any-of? @_keyword.function "defn" "defn-")
 (#set! conceal ""))

(list_lit
 .
 (sym_lit) @_keyword.function
 (#any-of? @_keyword.function "fn" "fn*")
 (#set! conceal "λ"))
