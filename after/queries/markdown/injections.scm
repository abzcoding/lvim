;; extends

(fenced_code_block
  (info_string
    (language) @_lang)
  (#match? @_lang "shell")
  (code_fence_content) @injection.content
  (#set! injection.language "bash"))
