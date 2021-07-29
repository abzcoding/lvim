local M = {}

function M.setup_nvim()
  local disabled_built_ins = {
    "netrw",
    "netrwPlugin",
    "netrwSettings",
    "netrwFileHandlers",
    "gzip",
    "zip",
    "zipPlugin",
    "tar",
    "tarPlugin", -- 'man',
    "getscript",
    "getscriptPlugin",
    "vimball",
    "vimballPlugin",
    "2html_plugin",
    "logipat",
    "rrhelper",
    "spellfile_plugin",
    -- 'matchit', 'matchparen', 'shada_plugin',
  }
  for _, _plugin in pairs(disabled_built_ins) do
    vim.g["loaded_" .. _plugin] = 1
  end
end

function M.terminal_commands()
  return {
    { "lazygit", "gg", "LazyGit" },
    { "python manage.py test;read", "jt", "Django tests" },
    { "python manage.py makemigrations;read", "jm", "Django makemigrations" },
    { "python manage.py migrate;read", "ji", "Django migrate" },
  }
end

function M.auto_commands()
  return {
    -- { "Filetype", "cpp", "nnoremap <leader>lh <Cmd>ClangdSwitchSourceHeader<CR>" },
    { "Filetype", "rust", "nnoremap <leader>lm <Cmd>RustExpandMacro<CR>" },
    { "Filetype", "rust", "nnoremap <leader>lH <Cmd>RustToggleInlayHints<CR>" },
    { "Filetype", "rust", "nnoremap <leader>le <Cmd>RustRunnables<CR>" },
    { "Filetype", "rust", "nnoremap <leader>lh <Cmd>RustHoverActions<CR>" },
    { "Filetype", "rust", "nnoremap <leader>lc <Cmd>!cargo clippy --all-targets<CR>" },
    { "Filetype", "rust", "nnoremap <leader>lt <Cmd>!cargo test -- --ignored<CR>" },
  }
end

return M
