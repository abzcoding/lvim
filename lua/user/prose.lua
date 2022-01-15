local M = {}

M.config = function()
  local lsp_configs = require "lspconfig.configs"

  lsp_configs.prosemd = {
    default_config = {
      -- Update the path to prosemd-lsp
      cmd = { "/usr/local/bin/prosemd-lsp", "--stdio" },
      filetypes = { "markdown" },
      root_dir = function(fname)
        return require("lspconfig").util.find_git_ancestor(fname) or vim.fn.getcwd()
      end,
      settings = {},
    },
  }

  -- Use your attach function here
  local status_ok, lsp = pcall(require, "lspconfig")
  if not status_ok then
    return
  end

  if lsp.prosemd.setup then
    lsp.prosemd.setup {
      on_attach = require("lvim.lsp").common_on_attach,
      on_init = require("lvim.lsp").common_on_init,
      capabilities = require("lvim.lsp").common_capabilities(),
    }
  end
end
return M
