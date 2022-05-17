local M = {}

local create_aucmd = vim.api.nvim_create_autocmd

M.config = function()
  vim.api.nvim_create_augroup("_lvim_user", {})
  -- Autocommands
  if lvim.builtin.nonumber_unfocus then
    create_aucmd("WinEnter", { group = "_lvim_user", pattern = "*", command = "set relativenumber number cursorline" })
    create_aucmd(
      "WinLeave",
      { group = "_lvim_user", pattern = "*", command = "set norelativenumber nonumber nocursorline" }
    )
  end

  -- TODO: change this to lua
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
    create_aucmd("FileType", {
      group = "_lvim_user",
      pattern = { "sql", "mysql", "plsql" },
      command = "lua require('cmp').setup.buffer { sources = { { name = 'vim-dadbod-completion' } } }",
    })
  end

  create_aucmd("TermOpen", {
    group = "_lvim_user",
    pattern = "term://*",
    command = "lua require('user.keybindings').set_terminal_keymaps()",
  })
  -- { "FileType", { group = "_lvim_user", pattern="alpha", command = "nnoremap <silent> <buffer> q :q<CR>" } },
  create_aucmd("Filetype", {
    group = "_lvim_user",
    pattern = { "c", "cpp" },
    command = "nnoremap <leader>H <Cmd>ClangdSwitchSourceHeader<CR>",
  })
  create_aucmd("Filetype", {
    group = "_lvim_user",
    pattern = "go",
    command = "nnoremap <leader>H <cmd>lua require('lvim.core.terminal')._exec_toggle({cmd='go vet .;read',count=2,direction='float'})<CR>",
  })
  create_aucmd("Filetype", {
    group = "_lvim_user",
    pattern = { "scala", "sbt", "java" },
    command = "lua require('user.metals').config()",
  })
  create_aucmd("FileType", {
    group = "_lvim_user",
    pattern = "java",
    callback = function()
      vim.keymap.set(
        "n",
        "<leader>r",
        "<cmd>lua require('toggleterm.terminal').Terminal:new {cmd='mvn package;read', hidden =false}:toggle()<CR>"
      )
      vim.keymap.set(
        "n",
        "<leader>m",
        "<cmd>lua require('toggleterm.terminal').Terminal:new {cmd='mvn compile;read', hidden =false}:toggle()<CR>"
      )
    end,
  })
  create_aucmd("FileType", {
    group = "_lvim_user",
    pattern = "rust",
    callback = function()
      vim.keymap.set(
        "n",
        "<leader>H",
        "<cmd>lua require('lvim.core.terminal')._exec_toggle({cmd='cargo clippy;read',count=2,direction='float'})<CR>"
      )
      vim.keymap.set("n", "<leader>lm", "<Cmd>RustExpandMacro<CR>")
      vim.keymap.set("n", "<leader>lH", "<Cmd>RustToggleInlayHints<CR>")
      vim.keymap.set("n", "<leader>le", "<Cmd>RustRunnables<CR>")
      vim.keymap.set("n", "<leader>lh", "<Cmd>RustHoverActions<CR>")
      vim.keymap.set("n", "<leader>lc", "<Cmd>RustOpenCargo<CR>")
    end,
  })
  create_aucmd("FileType", {
    group = "_lvim_user",
    pattern = { "typescript", "typescriptreact" },
    callback = function()
      vim.keymap.set("n", "<leader>lA", "<Cmd>TSLspImportAll<CR>")
      vim.keymap.set("n", "<leader>lR", "<Cmd>TSLspRenameFile<CR>")
      vim.keymap.set("n", "<leader>lO", "<Cmd>TSLspOrganize<CR>")
    end,
  })
  create_aucmd("FileType", {
    group = "_lvim_user",
    pattern = "toml",
    command = "lua require('cmp').setup.buffer { sources = { { name = 'crates' } } }",
  })

  local codelens_viewer = "lua require('user.codelens').show_line_sign()"
  local user = os.getenv "USER"
  if user and user == "abz" then
    create_aucmd("CursorHold", {
      group = "_lvim_user",
      pattern = { "*.rs", "*.go", "*.ts", "*.tsx" },
      command = codelens_viewer,
    })
  end
end

M.make_run = function()
  create_aucmd("FileType", {
    group = "_lvim_user",
    pattern = { "c", "cpp" },
    callback = function()
      vim.keymap.set(
        "n",
        "<leader>m",
        "<cmd>lua require('lvim.core.terminal')._exec_toggle({cmd='make ;read',count=2,direction='float'})<CR>"
      )
      vim.keymap.set(
        "n",
        "<leader>r",
        "<cmd>lua require('lvim.core.terminal')._exec_toggle({cmd='make run;read',count=3,direction='float'})<CR>"
      )
    end,
  })
  create_aucmd("FileType", {
    group = "_lvim_user",
    pattern = "go",
    callback = function()
      vim.keymap.set(
        "n",
        "<leader>m",
        "<cmd>lua require('lvim.core.terminal')._exec_toggle({cmd='go build -v .;read',count=2,direction='float'})<CR>"
      )
      vim.keymap.set(
        "n",
        "<leader>r",
        "<cmd>lua require('lvim.core.terminal')._exec_toggle({cmd='go run .;read',count=3,direction='float'})<CR>"
      )
    end,
  })
  create_aucmd("FileType", {
    group = "_lvim_user",
    pattern = "python",
    callback = function()
      vim.keymap.set(
        "n",
        "<leader>r",
        "<cmd>lua require('lvim.core.terminal')._exec_toggle({cmd='python "
          .. vim.fn.expand "%"
          .. ";read',count=2,direction='float'})<CR>"
      )
      vim.keymap.set(
        "n",
        "<leader>m",
        "<cmd>lua require('lvim.core.terminal')._exec_toggle({cmd='echo \"compile :pepelaugh:\";read',count=2,direction='float'})<cr>"
      )
    end,
  })
  create_aucmd("FileType", {
    group = "_lvim_user",
    pattern = "rust",
    callback = function()
      vim.keymap.set(
        "n",
        "<leader>m",
        "<cmd>lua require('lvim.core.terminal')._exec_toggle({cmd='cargo build;read',count=2,direction='float'})<CR>"
      )
      vim.keymap.set("n", "<leader>r", "<cmd>lua require('rust-tools.runnables').runnables()<CR>")
    end,
  })
end

return M
