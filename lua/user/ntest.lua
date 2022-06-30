local M = {}

M.config = function()
  local status_ok, nt = pcall(require, "neotest")
  if not status_ok then
    return
  end

  nt.setup {
    diagnostic = {
      enabled = false,
    },
    icons = {
      running = require("user.lsp_kind").icons.clock,
    },
    floating = {
      border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
    },
    adapters = {
      require "neotest-python" {
        dap = { justMyCode = false, console = "integratedTerminal" },
      },
      require "neotest-go" {
        experimental = {
          test_table = true,
        },
      },
      require "neotest-plenary" {
        ignore_file_types = { "python", "go" },
      },
      require "neotest-vim-test" {
        ignore_file_types = { "python", "go", "vim", "lua" },
      },
    },
  }
end

return M
