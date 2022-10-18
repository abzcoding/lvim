vim.cmd [[
highlight! link FocusedSymbol LspHighlight
highlight! SpecialComment guibg=bold guifg=#9ca0a4
highlight! link LspCodeLens SpecialComment
highlight! link LspDiagnosticsSignError DiagnosticError
highlight! link LspDiagnosticsSignHint DiagnosticHint
highlight! link LspDiagnosticsSignInfo DiagnosticInfo
highlight! link NeoTreeDirectoryIcon NvimTreeFolderIcon
highlight! link IndentBlanklineIndent1  @comment
]]
require("user.theme").telescope_theme()
require("user.dev_icons").define_dap_signs()
if lvim.use_icons == false and lvim.builtin.custom_web_devicons then
  require("user.dev_icons").set_icon()
end
