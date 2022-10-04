; extends
(
 (function_call
   (identifier) @require_call
   (#match? @require_call "require")
   )
 (set! "priority" 105)
 (#set! conceal "")
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
    (#eq? @keyword  "vim.opt_local" )
  (#set! conceal "l")
)

(
  (dot_index_expression
  )@keyword
    (#eq? @keyword  "vim.keymap.set" )
  (#set! conceal "")
)

(
  (dot_index_expression
  )@keyword
    (#eq? @keyword  "vim.lsp" )
  (#set! conceal "歷")
)

(((dot_index_expression) @field (#eq? @field "vim.wo"      )) (#set! conceal ""))
(((dot_index_expression) @field (#eq? @field "vim.bo"      )) (#set! conceal ""))
(((dot_index_expression) @field (#eq? @field "vim.o"       )) (#set! conceal "O"))
(((dot_index_expression) @field (#eq? @field "vim.g"       )) (#set! conceal ""))
(((dot_index_expression) @field (#eq? @field "vim.env"     )) (#set! conceal "$"))
(((dot_index_expression) @field (#eq? @field "vim.schedule")) (#set! conceal ""))

(("return" @keyword) (#set! conceal ""))
(("local" @keyword) (#set! conceal ""))
(("function" @keyword) (#set! conceal ""))
(("then" @keyword) (#set! conceal ""))
(("do" @keyword) (#set! conceal ""))
(("not" @keyword) (#set! conceal ""))
(("for" @repeat) (#set! conceal ""))
(("while" @repeat) (#set! conceal "∞"))
;; (("end"      @keyword) (#set! conceal "–"))
;;(("if"       @keyword) (#set! conceal "?"))
;;(("else"     @keyword) (#set! conceal "!"))
;;(("elseif"   @keyword) (#set! conceal "¿"))

(
  (break_statement)@keyword
  (#eq? @keyword  "break" )
  (#set! conceal "")
)
(("comment_start"    @comment) (#set! conceal ""))
((function_call name: (identifier) @TSFuncMacro (#eq? @TSFuncMacro "require")) (#set! conceal ""))
((function_call name: (identifier) @TSFuncMacro (#eq? @TSFuncMacro "print"  )) (#set! conceal " "))
((function_call name: (identifier) @TSFuncMacro (#eq? @TSFuncMacro "pairs"  )) (#set! conceal ""))
((function_call name: (identifier) @TSFuncMacro (#eq? @TSFuncMacro "ipairs" )) (#set! conceal ""))
((dot_index_expression table: (identifier) @keyword  (#eq? @keyword  "math" )) (#set! conceal ""))
(((break_statement) @keyword) (#set! conceal "ﰈ"))
