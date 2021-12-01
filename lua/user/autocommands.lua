local M = {}

M.config = function()
  -- Autocommands
  if lvim.builtin.nonumber_unfocus then
    vim.cmd [[
" don't show line number in unfocued window
augroup WindFocus
    autocmd!
    autocmd WinEnter * set relativenumber number cursorline
    autocmd WinLeave * set norelativenumber nonumber nocursorline
augroup END
  ]]
  end

  vim.cmd [[
" disable syntax highlighting in big files
function! DisableSyntaxTreesitter()
    echo("Big file, disabling syntax, treesitter and folding")
    if exists(':TSBufDisable')
        exec 'TSBufDisable autotag'
        exec 'TSBufDisable highlight'
    endif

    set foldmethod=manual
    syntax clear
    syntax off
    filetype off
    set noundofile
    set noswapfile
    set noloadplugins
    set lazyredraw
endfunction

augroup BigFileDisable
    autocmd!
    autocmd BufReadPre,FileReadPre * if getfsize(expand("%")) > 1024 * 1024 | exec DisableSyntaxTreesitter() | endif
augroup END
  ]]

  if lvim.builtin.sql_integration.active then
    -- Add vim-dadbod-completion in sql files
    vim.cmd [[
    augroup DadbodSql
      au!
      autocmd FileType sql,mysql,plsql lua require('cmp').setup.buffer { sources = { { name = 'vim-dadbod-completion' } } }
    augroup END
    ]]
  end

  local codelens_viewer = "lua require('nvim-lightbulb').update_lightbulb()"
  local user = os.getenv "USER"
  if user and user == "abz" then
    codelens_viewer = "lua require('user.codelens').show_line_sign()"
  end

  lvim.autocommands.custom_groups = {
    -- toggleterm
    { "TermOpen", "term://*", "lua require('user.keybindings').set_terminal_keymaps()" },

    -- dashboard
    { "FileType", "alpha", "nnoremap <silent> <buffer> q :q<CR>" },

    -- c, cpp
    { "Filetype", "c,cpp", "nnoremap <leader>H <Cmd>ClangdSwitchSourceHeader<CR>" },

    -- go
    { "CursorHold", "*.rs,*.go", codelens_viewer },
    {
      "Filetype",
      "go",
      "nnoremap <leader>H <cmd>lua require('lvim.core.terminal')._exec_toggle('go vet .;read')<CR>",
    },

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

    -- rust
    {
      "Filetype",
      "rust",
      "nnoremap <leader>H <cmd>lua require('lvim.core.terminal')._exec_toggle('cargo clippy;read')<CR>",
    },
    { "Filetype", "rust", "nnoremap <leader>lm <Cmd>RustExpandMacro<CR>" },
    { "Filetype", "rust", "nnoremap <leader>lH <Cmd>RustToggleInlayHints<CR>" },
    { "Filetype", "rust", "nnoremap <leader>le <Cmd>RustRunnables<CR>" },
    { "Filetype", "rust", "nnoremap <leader>lh <Cmd>RustHoverActions<CR>" },
    { "Filetype", "rust", "nnoremap <leader>lc <Cmd>RustOpenCargo<CR>" },
    { "Filetype", "rust", "nnoremap gA <Cmd>RustHoverActions<CR>" },

    -- typescript
    { "Filetype", "typescript,typescriptreact", "nnoremap gA <Cmd>TSLspImportAll<CR>" },
    { "Filetype", "typescript,typescriptreact", "nnoremap gr <Cmd>TSLspRenameFile<CR>" },
    { "Filetype", "typescript,typescriptreact", "nnoremap gS <Cmd>TSLspOrganize<CR>" },

    -- uncomment the following if you want to show diagnostics on hover
    -- { "CursorHold", "*", "lua vim.lsp.diagnostic.show_line_diagnostics({ show_header = false, border = 'single' })" },
  }
end

M.make_run = function()
  return {
    -- c, cpp
    {
      "Filetype",
      "c,cpp",
      "nnoremap <leader>m <cmd>lua require('lvim.core.terminal')._exec_toggle('make ;read')<CR>",
    },
    {
      "Filetype",
      "c,cpp",
      "nnoremap <leader>r <cmd>lua require('lvim.core.terminal')._exec_toggle('make run;read')<CR>",
    },

    -- go
    {
      "Filetype",
      "go",
      "nnoremap <leader>m <cmd>lua require('lvim.core.terminal')._exec_toggle('go build -v .;read')<CR>",
    },
    {
      "Filetype",
      "go",
      "nnoremap <leader>r <cmd>lua require('lvim.core.terminal')._exec_toggle('go run .;read')<CR>",
    },

    -- python
    {
      "Filetype",
      "python",
      "nnoremap <leader>r <cmd>lua require('lvim.core.terminal')._exec_toggle('python "
        .. vim.fn.expand "%"
        .. ";read')<CR>",
    },
    {
      "Filetype",
      "python",
      "nnoremap <leader>m <cmd>lua require('lvim.core.terminal')._exec_toggle('echo \"compile :pepelaugh:\";read')<CR>",
    },

    -- rust
    {
      "Filetype",
      "rust",
      "nnoremap <leader>m <cmd>lua require('lvim.core.terminal')._exec_toggle('cargo build;read')<CR>",
    },
    {
      "Filetype",
      "rust",
      "nnoremap <leader>r <cmd>lua require('rust-tools.runnables').runnables()<CR>",
    },
  }
end

return M
