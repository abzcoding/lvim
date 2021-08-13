local M = {}

M.config = function()
  lvim.builtin.treesitter.ensure_installed = "maintained"
  lvim.builtin.treesitter.matchup.enable = true
  lvim.builtin.treesitter.ignore_install = { "haskell" }
  lvim.builtin.treesitter.context_commentstring.enable = true
  lvim.builtin.treesitter.indent = { enable = false } -- treesitter is buggy :(
  lvim.builtin.dashboard.active = true
  lvim.builtin.galaxyline.active = true
  lvim.builtin.telescope.defaults.path_display = { shorten = 10 }
  lvim.builtin.terminal.active = true
  lvim.builtin.terminal.execs = {
    { "lazygit", "gg", "LazyGit" },
    { "python manage.py test;read", "jt", "Django tests" },
    { "python manage.py makemigrations;read", "jm", "Django makemigrations" },
    { "python manage.py migrate;read", "ji", "Django migrate" },
  }
  lvim.builtin.dashboard.custom_section["m"] = {
    description = { "  Marks              " },
    command = "Telescope marks",
  }
  if lvim.builtin.tabnine.active then
    lvim.builtin.compe.source.tabnine = { kind = " ", priority = 150, max_reslts = 6 }
  end
  if lvim.builtin.orgmode.active then
    lvim.builtin.compe.source.orgmode = true
  end
  if lvim.builtin.lastplace.active == false then
    -- go to last loc when opening a buffer
    vim.cmd [[
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif
]]
  end
  lvim.builtin.compe.documentation.border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }
  lvim.builtin.treesitter.incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<C-n>",
      node_incremental = "<C-n>",
      scope_incremental = "<C-s>",
      node_decremental = "<C-r>",
    },
  }
  lvim.builtin.treesitter.query_linter = {
    enable = true,
    use_virtual_text = true,
    lint_events = { "BufWrite", "CursorHold" },
  }
  -- lvim.builtin.nvimtree.hide_dotfiles = 0
  -- lvim.treesitter.textsubjects.enable = true
  -- lvim.treesitter.playground.enable = true
end

return M
