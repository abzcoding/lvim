-- Neovim
-- =========================================
lvim.format_on_save = false
lvim.leader = " "
lvim.colorscheme = "pablo"
lvim.debug = false
lvim.log.level = "warn"
local _time = os.date "*t"
if _time.hour >= 21 and _time.hour <= 24 then
  lvim.colorscheme = "onedarker"
end
vim.opt.relativenumber = true
vim.opt.wrap = true
vim.opt.timeoutlen = 200
vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.foldlevel = 4
vim.opt.guifont = "FiraCode Nerd Font:h13"
vim.opt.cmdheight = 1
vim.g.dashboard_enable_session = 0
vim.g.dashboard_disable_statusline = 0
vim.opt.pumblend = 10
vim.opt.joinspaces = false
vim.opt.list = true

-- Customization
-- =========================================
lvim.builtin.lastplace = { active = false } -- change to false if you are jumping to future
lvim.builtin.tabnine = { active = true } -- change to false if you don't like tabnine
lvim.builtin.persistence = { active = true } -- change to false if you don't want persistence
lvim.builtin.presence = { active = false } -- change to true if you want discord presence
lvim.builtin.orgmode = { active = false } -- change to true if you want orgmode.nvim
lvim.builtin.dap.active = false -- change this to enable/disable debugging
lvim.builtin.fancy_statusline = { active = true } -- change this to enable/disable fancy statusline
lvim.builtin.lua_dev = { active = true } -- change this to enable/disable folke/lua_dev
lvim.builtin.latex = {
  view_method = "skim", -- change to zathura if you are on linux
  preview_exec = "/Applications/Skim.app/Contents/SharedSupport/displayline", -- change this to zathura as well
}
require("user.builtin").config()

-- StatusLine
-- =========================================
if lvim.builtin.fancy_statusline.active then
  require("user.lualine").config()
end

-- Debugging
-- =========================================
if lvim.builtin.dap.active then
  require("user.dap").config()
end

-- Language Specific
-- =========================================
lvim.lang.markdown = {}
lvim.lang.dockerfile.lsp.setup.root_dir = function(fname)
  return require("lspconfig").util.root_pattern ".git"(fname) or require("lspconfig").util.path.dirname(fname)
end
lvim.builtin.lspinstall.on_config_done = function()
  lvim.lang.tailwindcss.lsp.setup.filetypes = { "markdown" }
  lvim.lang.tailwindcss.lsp.active = true
  require("lsp").setup "tailwindcss"
end
lvim.lang.typescript.on_attach = function(client, _)
  require("nvim-lsp-ts-utils").setup_client(client)
end
lvim.lang.typescriptreact.on_attach = lvim.lang.typescript.on_attach
lvim.lsp.diagnostics.virtual_text = false
lvim.lsp.override = { "rust", "java" }
require("user.json_schemas").setup()
require("user.yaml_schemas").setup()

-- Additional Plugins
-- =========================================
require("user.plugins").config()

-- Autocommands
-- =========================================
require("user.autocommands").config()

-- Additional keybindings
-- =========================================
require("user.keybindings").config()
