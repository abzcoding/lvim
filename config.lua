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
lvim.debug = false

-- Default options
-- =========================================
vim.opt.relativenumber = true
vim.opt.wrap = true
vim.opt.timeoutlen = 200
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 5
vim.opt.guifont = "FiraCode Nerd Font:h15"
vim.opt.cmdheight = 1
-- if you want to choose the source of formatting
-- lvim.lsp.on_init_callback = function(client, _bufnr)
--   client.resolved_capabilities.document_formatting = true
-- end

-- Customization
-- =========================================
lvim.builtin.lastplace = { active = false } -- change to false if you are jumping to future
lvim.builtin.tabnine = { active = true } -- change to false if you don't like tabnine
lvim.builtin.persistence = { active = true } -- change to false if you don't want persistence
lvim.builtin.presence = { active = false } -- change to true if you want discord presence
lvim.builtin.orgmode = { active = false } -- change to true if you want orgmode.nvim
lvim.builtin.dap.active = false -- change this to enable/disable debugging
lvim.builtin.treesitter.indent = { enable = false }

-- Builtin
-- =========================================
lvim.builtin.treesitter.ensure_installed = "maintained"
lvim.builtin.treesitter.matchup.enable = true
lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.context_commentstring.enable = true
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
  lvim.builtin.compe.source.tabnine = { kind = " ", priority = 200, max_reslts = 6 }
end
if lvim.builtin.orgmode.active then
  lvim.builtin.compe.source.orgmode = true
end
-- lvim.builtin.nvimtree.hide_dotfiles = 0
-- lvim.treesitter.textsubjects.enable = true
-- lvim.treesitter.playground.enable = true

-- Additional keybindings
-- =========================================
lvim.keys.normal_mode["<C-n>i"] = { "<C-i>", { noremap = true } }
lvim.keys.normal_mode["<S-x>"] = ":BufferClose<CR>"
lvim.keys.normal_mode["<esc><esc>"] = "<cmd>nohlsearch<cr>"
lvim.keys.normal_mode["Y"] = "y$"
lvim.keys.visual_mode["p"] = [["_dP]]

-- StatusLine
-- =========================================
lvim.builtin.galaxyline.on_config_done = function(gl)
  require("user.galaxyline").config(gl)
end

-- Language Specific
-- =========================================
lvim.lang.markdown = {}
lvim.lang.dockerfile = {}
lvim.builtin.lspinstall.on_config_done = function()
  require("user.tailwind").setup()
  require("user.dockerls").setup()
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

-- Additional keybindings
-- =========================================
require("user.keybindings").config()
