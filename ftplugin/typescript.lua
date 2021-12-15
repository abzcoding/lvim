local status_ok, ts_utils = pcall(require, "nvim-lsp-ts-utils")
if not status_ok then
  vim.cmd [[ packadd nvim-lsp-ts-utils ]]
  ts_utils = require "nvim-lsp-ts-utils"
end

local opts = {
  on_attach = function(client, bufnr)
    -- defaults
    ts_utils.setup {
      debug = false,
      disable_commands = false,
      enable_import_on_completion = false,
      import_all_timeout = 5000, -- ms

      -- eslint
      eslint_enable_code_actions = true,
      eslint_enable_disable_comments = true,
      eslint_bin = "eslint_d",
      eslint_config_fallback = nil,
      eslint_enable_diagnostics = true,

      -- formatting
      enable_formatting = false,
      formatter = "prettierd",
      formatter_config_fallback = nil,

      -- parentheses completion
      complete_parens = false,
      signature_help_in_parens = false,

      -- update imports on file move
      update_imports_on_move = false,
      require_confirmation_on_move = false,
      watch_dir = nil,
    }
    ts_utils.setup_client(client)
    require("lvim.lsp").common_on_attach(client, bufnr)
  end,
  init_options = require("nvim-lsp-ts-utils").init_options,
  on_init = require("lvim.lsp").common_on_init,
  capabilities = require("lvim.lsp").common_capabilities(),
}

local servers = require "nvim-lsp-installer.servers"
local server_available, requested_server = servers.get_server "tsserver"
if server_available then
  requested_server:setup(opts)
end
