-- Neovim
local custom = require "lv-custom"
custom.setup_nvim()


-- General
lvim.format_on_save = false
lvim.leader = " "
lvim.colorscheme = "spacegray"


-- Default options
vim.opt.relativenumber = true
vim.opt.wrap = true
vim.opt.timeoutlen = 200
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 5
vim.opt.guifont = "FiraCode Nerd Font:h15"
-- vim.opt.shiftwidth = 4
-- vim.opt.tabstop = 8


-- Builtin Customization
-- lvim.builtin.compe.autocomplete = true
lvim.builtin.compe.source.tabnine = { kind = " ", priority = 200, max_reslts = 6 }
lvim.builtin.treesitter.ensure_installed = "maintained"
lvim.builtin.treesitter.matchup.enable = true
lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.context_commentstring.enable = true
-- lvim.treesitter.textsubjects.enable = true
-- lvim.treesitter.playground.enable = true
lvim.builtin.treesitter.indent = { enable = false }
lvim.builtin.dashboard.active = true
lvim.builtin.dap.active = true
lvim.builtin.galaxyline.active = true
lvim.builtin.telescope.defaults.path_display = { shorten = 10 }
-- lvim.builtin.nvimtree.hide_dotfiles = 0
lvim.builtin.terminal.active = true
lvim.builtin.terminal.execs = custom.terminal_commands()


-- Language Specific
lvim.lsp.override = { "rust" }
lvim.lang.go.formatter.exe = "goimports"
lvim.lang.python.formatter.exe = "yapf"
local function clangd_common_on_attach(client, bufnr)
  require("lsp").common_on_attach(client, bufnr) -- this line is optional

  local opts = { noremap = true, silent = true }
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>lh", "<Cmd>ClangdSwitchSourceHeader<CR>", opts)
end
lvim.lang.cpp.lsp.setup.on_attach = clangd_common_on_attach
-- lvim.lsp.document_highlight = false
-- lvim.lsp.diagnostics.virtual_text = false


-- Autocommands
lvim.autocommands.custom_groups = custom.auto_commands()


-- Debugging
lvim.builtin.dap.on_config_done = require("lv-debug").dap_setup()


-- Additional Plugins
lvim.plugins = require("lv-plugin").list()


-- Additional Leader bindings for WhichKey
local keys = require "lv-keys"
keys.setup_nvim_keys()
keys.setup_which_keys()
