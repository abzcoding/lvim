local M = {}

M.config = function()
  local status_ok, rust_tools = pcall(require, "rust-tools")
  if not status_ok then
    return
  end

  local lsp_installer_servers = require "nvim-lsp-installer.servers"
  local _, requested_server = lsp_installer_servers.get_server "rust_analyzer"

  local opts = {
    tools = {
      autoSetHints = true,
      hover_with_actions = true,
      executor = require("rust-tools/executors").termopen, -- can be quickfix or termopen
      inlay_hints = {
        only_current_line = false,
        only_current_line_autocmd = "CursorHold",
        show_variable_name = false,
        show_parameter_hints = true,
        parameter_hints_prefix = "<-",
        other_hints_prefix = "=>",
        max_len_align = false,
        max_len_align_padding = 1,
        right_align = false,
        right_align_padding = 7,
        highlight = "Comment",
      },
      hover_actions = {
        border = {
          { "╭", "FloatBorder" },
          { "─", "FloatBorder" },
          { "╮", "FloatBorder" },
          { "│", "FloatBorder" },
          { "╯", "FloatBorder" },
          { "─", "FloatBorder" },
          { "╰", "FloatBorder" },
          { "│", "FloatBorder" },
        },
        auto_focus = true,
      },
    },
    server = {
      cmd_env = requested_server._default_options.cmd_env,
      on_attach = require("lvim.lsp").common_on_attach,
      on_init = require("lvim.lsp").common_on_init,
    },
  }
  local extension_path = vim.fn.expand "~/" .. ".vscode/extensions/vadimcn.vscode-lldb-1.7.0/"

  local codelldb_path = extension_path .. "adapter/codelldb"
  local liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"

  opts.dap = {
    adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
  }
  rust_tools.setup(opts)
end

return M
