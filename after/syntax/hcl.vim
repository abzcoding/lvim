" Vim syntax file
" Language:   HashiCorp Configuration Language (HCL)
" Maintainer: Jussi Virtanen
" Repository: https://github.com/jvirtanen/vim-hcl
" License:    Vim

if exists('b:current_syntax')
  finish
end

syn match hclVariable /\<[A-Za-z0-9_.\[\]*]\+\>/

syn match hclParenthesis /(/
syn match hclFunction    /\w\+(/ contains=hclParenthesis

syn keyword hclKeyword for in if

syn region hclString start=/"/ end=/"/ contains=hclEscape,hclInterpolation
syn region hclString start=/<<-\?\z([A-Z]\+\)/ end=/^\s*\z1/ contains=hclEscape,hclInterpolation

syn match hclEscape /\\n/
syn match hclEscape /\\r/
syn match hclEscape /\\t/
syn match hclEscape /\\"/
syn match hclEscape /\\\\/
syn match hclEscape /\\u\x\{4\}/
syn match hclEscape /\\u\x\{8\}/

syn match hclNumber /\<\d\+\%([eE][+-]\?\d\+\)\?\>/
syn match hclNumber /\<\d*\.\d\+\%([eE][+-]\?\d\+\)\?\>/
syn match hclNumber /\<0[xX]\x\+\>/

syn keyword hclConstant true false null

syn region hclInterpolation start=/\${/ end=/}/ contained contains=hclInterpolation

syn region hclComment start=/\/\// end=/$/    contains=hclTodo
syn region hclComment start=/\#/   end=/$/    contains=hclTodo
syn region hclComment start=/\/\*/ end=/\*\// contains=hclTodo

syn match hclAttributeName /\w\+/ contained
syn match hclAttribute     /^[^=]\+=/ contains=hclAttributeName,hclComment,hclString

syn match hclBlockName /\w\+/ contained
syn match hclBlock     /^[^=]\+{/ contains=hclBlockName,hclComment,hclString

syn keyword hclTodo TODO FIXME XXX DEBUG NOTE contained

hi def link hclVariable      PreProc
hi def link hclFunction      Function
hi def link hclKeyword       Keyword
hi def link hclString        String
hi def link hclEscape        Special
hi def link hclNumber        Number
hi def link hclConstant      Constant
hi def link hclInterpolation PreProc
hi def link hclComment       Comment
hi def link hclTodo          Todo
hi def link hclBlockName     Structure

let b:current_syntax = 'hcl'
