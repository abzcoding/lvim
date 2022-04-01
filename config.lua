-- Neovim
-- =========================================
lvim.format_on_save = false
lvim.leader = " "
lvim.colorscheme = "dracula"
lvim.debug = false
lvim.transparent_window = true -- Transparent window
vim.lsp.set_log_level "warn"
lvim.lsp.document_highlight = true
lvim.log.level = "warn"
vim.g.instant_username = os.getenv "USER"
require("user.neovim").config()

-- Customization
-- =========================================
lvim.builtin.dashboard.active = true
lvim.builtin.tabout = { active = true }
lvim.builtin.sell_your_soul_to_devil = true -- if you want microsoft to abuse your soul
lvim.builtin.lastplace = { active = true } -- change to false if you are jumping to future
lvim.builtin.tabnine = { active = true } -- change to false if you don't like tabnine
lvim.builtin.persistence = { active = true } -- change to false if you don't want persistence
lvim.builtin.presence = { active = false } -- change to true if you want discord presence
lvim.builtin.orgmode = { active = false } -- change to true if you want orgmode.nvim
lvim.builtin.dap.active = true -- change this to enable/disable debugging
lvim.builtin.fancy_statusline = { active = true } -- enable/disable fancy statusline
lvim.builtin.fancy_wild_menu = { active = true } -- enable/disable use wilder.nvim
lvim.builtin.fancy_rename = { active = true } -- enable/disable custom rename
lvim.builtin.fancy_diff = { active = false } -- enable/disable fancier git diff
lvim.builtin.lua_dev = { active = true } -- change this to enable/disable folke/lua_dev
lvim.builtin.test_runner = { active = true } -- change this to enable/disable vim-test, ultest
lvim.builtin.cheat = { active = true } -- enable cheat.sh integration
lvim.builtin.sql_integration = { active = true } -- use sql integration
lvim.builtin.neoscroll = { active = true } -- smooth scrolling
lvim.builtin.neoclip = { active = true, enable_persistent_history = false }
lvim.builtin.nonumber_unfocus = true -- differntiate between focused and non focused windows
lvim.builtin.harpoon = { active = true } -- use the harpoon plugin
lvim.builtin.remote_dev = { active = false } -- enable/disable remote development
lvim.builtin.cursorline = { active = true } -- use a bit fancier cursorline
lvim.builtin.motion_provider = "hop" -- change this to use different motion providers ( hop or lightspeed )
lvim.builtin.hlslens = { active = false } -- enable/disable hlslens
lvim.builtin.csv_support = true -- enable/disable csv support
lvim.builtin.sidebar = { active = true } -- enable/disable sidebar
lvim.builtin.async_tasks = { active = true } -- enable/disable async tasks
lvim.builtin.metals = {
  active = false, -- enable/disable nvim-metals for scala development
  fallbackScalaVersion = "2.13.7",
  serverVersion = "0.10.9+271-a8bb69f6-SNAPSHOT",
}
lvim.builtin.collaborative_editing = { active = true } -- enable/disable collaborative editing
lvim.builtin.file_browser = { active = true } -- enable/disable telescope file browser
lvim.builtin.sniprun = { active = false } -- enable/disable sniprun
lvim.builtin.tag_provider = "symbols-outline" -- change this to use different tag providers ( symbols-outline or vista )
lvim.builtin.editorconfig = { active = true } -- enable/disable editorconfig
lvim.builtin.fancy_telescope = { active = true } -- telescope to the moon
lvim.builtin.global_statusline = true -- set true to use global statusline

require("user.prose").config() -- setup prosemd-lsp for my local use

lvim.lsp.diagnostics.virtual_text = true -- remove this line if you want to see inline errors
lvim.builtin.latex = {
  view_method = "skim", -- change to zathura if you are on linux
  preview_exec = "/Applications/Skim.app/Contents/SharedSupport/displayline", -- change this to zathura as well
  rtl_support = true, -- if you want to use xelatex, it's a bit slower but works very well for RTL langs
}
lvim.builtin.notify.active = true
lvim.lsp.automatic_servers_installation = true
if lvim.builtin.cursorline.active then
  lvim.lsp.document_highlight = false
end
lvim.lsp.code_lens_refresh = true
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
vim.list_extend(lvim.lsp.override, {
  "clangd",
  "dockerls",
  "gopls",
  "pyright",
  "r_language_server",
  "rust_analyzer",
  "sumneko_lua",
  "taplo",
  "texlab",
  "tsserver",
  "yamlls",
})
require("user.null_ls").config()

-- Additional Plugins
-- =========================================
require("user.plugins").config()

-- Autocommands
-- =========================================
require("user.autocommands").config()

-- Additional keybindings
-- =========================================
require("user.keybindings").config()

local formatters = require "lvim.lsp.null-ls.formatters"

formatters.setup {
  {
    command = "prettierd",
    ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
    filetypes = { "typescript", "typescriptreact", "vue" },
  },
}
