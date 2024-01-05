local M = {}

M.config = function()
  local opts = {
    tools = {
      executor = require "rustaceanvim.executors.termopen", -- can be quickfix or termopen
      reload_workspace_from_cargo_toml = true,
      inlay_hints = {
        auto = true,
        only_current_line = false,
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
      on_attach = function(client, bufnr)
        require("lvim.lsp").common_on_attach(client, bufnr)
      end,
      on_init = require("lvim.lsp").common_on_init,
      capabilities = require("lvim.lsp").common_capabilities(),
      default_settings = {
        ["rust-analyzer"] = {
          inlayHints = { locationLinks = false },
          lens = {
            enable = true,
          },
          checkOnSave = {
            enable = true,
            command = "clippy",
          },
          diagnostics = {
            experimental = true,
          },
        },
      },
    },
  }
  local mason_path = vim.fn.glob(vim.fn.stdpath "data" .. "/mason/packages/codelldb/extension/")
  local vscode_path = vim.fn.expand "~/" .. ".vscode/extensions/vadimcn.vscode-lldb-1.10.0/"

  local path = ""
  local debugger_found = true
  if M.dir_exists(mason_path) then
    path = mason_path
  elseif M.dir_exists(vscode_path) then
    path = vscode_path
  else
    debugger_found = false
    vim.notify("please install codelldb using :Mason or via vscode", vim.log.levels.WARN)
  end

  if debugger_found then
    local codelldb_path = path .. "adapter/codelldb"
    local liblldb_path = path .. "lldb/lib/liblldb.so"

    if vim.fn.has "mac" == 1 then
      liblldb_path = path .. "lldb/lib/liblldb.dylib"
    end

    if vim.fn.filereadable(codelldb_path) and vim.fn.filereadable(liblldb_path) then
      local cfg = require "rustaceanvim.config"
      opts.dap = {
        adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
      }
    else
      vim.notify("please reinstall codellb, i cannot find liblldb or codelldb itself", vim.log.levels.WARN)
    end
  end
  vim.g.rustaceanvim = function()
    return opts
  end
end

M.dir_exists = function(file)
  local ok, _, code = os.rename(file, file)
  if not ok then
    if code == 13 then
      -- Permission denied, but it exists
      return true
    end
  end
  return ok
end

return M
