local M = {}

M.config = function()
  -- Autocommands
  lvim.autocommands.custom_groups = {
    -- c, cpp
    { "Filetype", "c,cpp", "nnoremap <leader>m <cmd>lua require('core.terminal')._exec_toggle('make ;read')<CR>" },
    { "Filetype", "c,cpp", "nnoremap <leader>r <cmd>lua require('core.terminal')._exec_toggle('make run;read')<CR>" },
    { "Filetype", "c,cpp", "nnoremap <leader>H <Cmd>ClangdSwitchSourceHeader<CR>" },

    -- java
    {
      "Filetype",
      "java",
      "nnoremap <leader>r <cmd>lua require('toggleterm.terminal').Terminal:new {cmd='mvn package;read', hidden =false}:toggle()<CR>",
    },
    {
      "Filetype",
      "java",
      "nnoremap <leader>m <cmd>lua require('toggleterm.terminal').Terminal:new {cmd='mvn compile;read', hidden =false}:toggle()<CR>",
    },

    -- python
    {
      "Filetype",
      "python",
      "nnoremap <leader>r <cmd>lua require('core.terminal')._exec_toggle('python " .. vim.fn.expand "%" .. ";read')<CR>",
    },
    {
      "Filetype",
      "python",
      "nnoremap <leader>m <cmd>lua require('core.terminal')._exec_toggle('echo \"compile :pepelaugh:\";read')<CR>",
    },

    -- rust
    { "Filetype", "rust", "nnoremap <leader>m <cmd>lua require('core.terminal')._exec_toggle('cargo build;read')<CR>" },
    { "Filetype", "rust", "nnoremap <leader>r <cmd>lua require('core.terminal')._exec_toggle('cargo run;read')<CR>" },
    { "Filetype", "rust", "nnoremap <leader>H <cmd>lua require('core.terminal')._exec_toggle('cargo clippy;read')<CR>" },
    { "Filetype", "rust", "nnoremap <leader>lm <Cmd>RustExpandMacro<CR>" },
    { "Filetype", "rust", "nnoremap <leader>lH <Cmd>RustToggleInlayHints<CR>" },
    { "Filetype", "rust", "nnoremap <leader>le <Cmd>RustRunnables<CR>" },
    { "Filetype", "rust", "nnoremap <leader>lh <Cmd>RustHoverActions<CR>" },
    -- uncomment the following if you want to show diagnostics on hover
    -- { "CursorHold", "*", "lua vim.lsp.diagnostic.show_line_diagnostics({ show_header = false, border = 'single' })" },
  }
end

return M
