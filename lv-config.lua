-- Neovim
-- =========================================
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

-- General
-- =========================================
lvim.format_on_save = false
lvim.leader = " "
lvim.colorscheme = "spacegray"

-- Default options
-- =========================================
vim.opt.relativenumber = true
vim.opt.wrap = true
vim.opt.timeoutlen = 200
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 5
vim.opt.guifont = "FiraCode Nerd Font:h15"

-- Builtin
-- =========================================
lvim.builtin.treesitter.ensure_installed = "maintained"
lvim.builtin.treesitter.matchup.enable = true
lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.context_commentstring.enable = true
lvim.builtin.treesitter.indent = { enable = false }
lvim.builtin.compe.source.tabnine = { kind = " ", priority = 200, max_reslts = 6 }
-- lvim.builtin.compe.source.orgmode = true
lvim.builtin.dashboard.active = true
lvim.builtin.dap.active = true
lvim.builtin.galaxyline.active = true
lvim.builtin.telescope.defaults.path_display = { shorten = 10 }
lvim.builtin.terminal.active = true
lvim.builtin.terminal.execs = {
  { "lazygit", "gg", "LazyGit" },
  { "python manage.py test;read", "jt", "Django tests" },
  { "python manage.py makemigrations;read", "jm", "Django makemigrations" },
  { "python manage.py migrate;read", "ji", "Django migrate" },
}
-- lvim.builtin.nvimtree.hide_dotfiles = 0
-- lvim.treesitter.textsubjects.enable = true
-- lvim.treesitter.playground.enable = true

-- Language Specific
-- =========================================
lvim.lang.markdown = {}
lvim.builtin.lspinstall.on_config_done = function()
  require("user.tailwind").setup()
end
lvim.lsp.diagnostics.virtual_text = false
lvim.lsp.override = { "rust", "java" }
require("user.json_schemas").setup()

-- Additional Plugins
-- =========================================
require("user.plugins").config()

-- Autocommands
-- =========================================
require("user.autocommands").config()

-- Debugging
-- =========================================
lvim.builtin.dap.on_config_done = require("user.dap").config()

-- Additional Leader bindings for WhichKey
-- =========================================
require("user.keybindings").config()
