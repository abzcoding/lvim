(
 (function_call
   (identifier) @require_call
   (#match? @require_call "require")
   )
 (set! "priority" 105)
 (#set! conceal "")
)

(
 (function_call
   (identifier) @pairs
   (#match? @pairs "pairs")
   )
 (set! "priority" 105)
 )

(function_declaration
  (identifier)@function_definition
  )
(
 (function_declaration
   (dot_index_expression
     (identifier)
     (identifier)@function_definition
     )
   )
 (set! "priority" 105)
 )

(
 (assignment_statement
   (variable_list
     (identifier)@function_definition
     )
   (
    expression_list
    (function_definition)
    )
   )
 (set! "priority" 105)
 )
(
 (assignment_statement
   (variable_list
     (dot_index_expression
       (identifier)
       (identifier)@function_definition
       )
     )
   (
    expression_list
    (function_definition)
    )
   )
 (set! "priority" 105)
 )

(
  (function_call
    name: (identifier) @function
    (#eq? @function "pairs")
  )
  (#set! conceal "P")
)

(
  (function_call
    name: (identifier) @function
    (#eq? @function "ipairs")
  )
  (#set! conceal "I")
)

(
  (identifier) @function
  (#eq? @function "utils")
  (#set! conceal "")
  ; (#set! conceal "U")
)

(
  (dot_index_expression
    table: (identifier) @keyword
    (#eq? @keyword  "utils" )
  )
  (#set! conceal "U")
)

(
  (dot_index_expression) @function
    (#eq? @function  "vim.cmd" )
  (#set! conceal "")
)

(
  (dot_index_expression) @function
    (#eq? @function  "vim.api" )
  (#set! conceal "")
)

(
  (dot_index_expression) @function
    (#eq? @function  "vim.fn" )
  (#set! conceal "")
)

(
  (dot_index_expression) @keyword
    (#eq? @keyword  "vim.opt" )
  (#set! conceal "opt")
)

(
  (dot_index_expression) @keyword
    (#eq? @keyword  "vim.wo" )
  (#set! conceal "wo")
)

(
  (dot_index_expression) @keyword
    (#eq? @keyword  "vim.g" )
  (#set! conceal "g")
)

(
  (dot_index_expression) @keyword
    (#eq? @keyword  "vim.bo" )
  (#set! conceal "b")
)

(
  (dot_index_expression) @keyword
    (#eq? @keyword  "vim.opt_local" )
  (#set! conceal "l")
)

(
  (dot_index_expression
  )@keyword
    (#eq? @keyword  "vim.keymap.set" )
  (#set! conceal "")
)

; (
;   (dot_index_expression
;   )@keyword
;     (#eq? @keyword  "lvim.keys" )
;   (#set! conceal "")
; )

; (
;   (dot_index_expression
;   )@keyword
;     (#eq? @keyword  "lvim.builtin.which_key" )
;   (#set! conceal "גּ")
; )

; (
;   (dot_index_expression
;   )@keyword
;     (#eq? @keyword  "lvim.builtin.telescope" )
;   (#set! conceal "")
; )

; (
;   (dot_index_expression
;   )@keyword
;     (#eq? @keyword  "lvim.builtin.bufferline" )
;   (#set! conceal "")
; )

; (
;   (dot_index_expression
;   )@keyword
;     (#eq? @keyword  "lvim.builtin.comment" )
;   (#set! conceal "")
; )

; (
;   (dot_index_expression
;   )@keyword
;     (#eq? @keyword  "lvim.builtin.treesitter" )
;   (#set! conceal "")
; )

; (
;   (dot_index_expression
;   )@keyword
;     (#eq? @keyword  "lvim.builtin.dap" )
;   (#set! conceal "")
; )

; (
;   (dot_index_expression
;   )@keyword
;     (#eq? @keyword  "lvim.builtin.terminal" )
;   (#set! conceal "")
; )

; (
;   (dot_index_expression
;   )@keyword
;     (#eq? @keyword  "lvim.lsp" )
;   (#set! conceal "")
; )

(
  (dot_index_expression
  )@keyword
    (#eq? @keyword  "vim.lsp" )
  (#set! conceal "歷")
)

(("return" @keyword) (#set! conceal ""))
(("local" @keyword) (#set! conceal ""))
(("function" @keyword) (#set! conceal ""))
(("then" @keyword) (#set! conceal ""))
(("do" @keyword) (#set! conceal ""))
(("not" @keyword) (#set! conceal ""))
(("for" @repeat) (#set! conceal ""))
(("while" @repeat) (#set! conceal "∞"))

(
  (break_statement)@keyword
  (#eq? @keyword  "break" )
  (#set! conceal "")
)
