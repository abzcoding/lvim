vim.cmd [[
highlight! link FocusedSymbol LspHighlight
highlight! link LspCodeLens SpecialComment
highlight! SpecialComment guibg=bold guifg=#9ca0a4
highlight! link LspDiagnosticsSignError DiagnosticError
highlight! link LspDiagnosticsSignHint DiagnosticHint
highlight! link LspDiagnosticsSignInfo DiagnosticInfo
highlight! link CmpItemKindText  String
highlight! link CmpItemKindMethod  TSMethod
highlight! link CmpItemKindFunction  Function
highlight! link CmpItemKindConstructor  TSConstructor
highlight! link CmpItemKindField  TSField
highlight! link CmpItemKindVariable  TSVariable
highlight! link CmpItemKindClass  Class
highlight! link CmpItemKindInterface  Constant
highlight! link CmpItemKindModule  Include
highlight! link CmpItemKindProperty  TSProperty
highlight! link CmpItemKindUnit  Constant
highlight! link CmpItemKindValue  TSVariable
highlight! link CmpItemKindEnum  Type
highlight! link CmpItemKindKeyword  TSKeyword
highlight! link CmpItemKindFile  Directory
highlight! link CmpItemKindReference  Question
highlight! link CmpItemKindConstant  Constant
highlight! link CmpItemKindStruct  Type
highlight! link CmpItemKindEvent  TSVariable
highlight! link CmpItemKindOperator  Operator
highlight! link CmpItemKindTypeParameter  Type
highlight! link CmpItemKindSnippet  Statement
highlight! link NeoTreeDirectoryIcon NvimTreeFolderIcon
" hi HlSearchNear guibg=None guifg=#bb9af7 gui=underline
" hi HlSearchFloat guibg=None guifg=#bb9af7 gui=underline
" hi HlSearchLensNear guibg=None guifg=#bb9af7 gui=italic
" hi HlSearchLens guibg=None guifg=#bb9af7 gui=underline
highlight! link IndentBlanklineIndent1  TSComment
highlight! link IndentBlanklineIndent2  TSComment
highlight! link IndentBlanklineIndent3  TSComment
highlight! link IndentBlanklineIndent4  TSComment
highlight! link IndentBlanklineIndent5  TSComment
highlight! link IndentBlanklineIndent6  TSComment
highlight! IlluminatedWordRead NONE
highlight! IlluminatedWordWrite NONE
highlight! IlluminatedWordText NONE
]]
require("user.theme").telescope_theme()
require("user.dev_icons").define_dap_signs()
if lvim.use_icons == false and lvim.builtin.custom_web_devicons then
  require("user.dev_icons").set_icon()
end
