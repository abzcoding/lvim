local M = {}

M.config = function()
  local status_ok, nt = pcall(require, "neotest")
  if not status_ok then
    return
  end

  local namespace = vim.api.nvim_create_namespace "neotest"
  vim.diagnostic.config({
    virtual_text = {
      format = function(diagnostic)
        return diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
      end,
    },
  }, namespace)

  local opts = {
    running = {
      concurrent = false,
    },
    status = {
      virtual_text = true,
      signs = false,
    },
    strategies = {
      integrated = {
        width = 180,
      },
    },
    discovery = {
      enabled = true,
    },
    diagnostic = {
      enabled = true,
    },
    icons = {
      running = require("user.lsp_kind").icons.clock,
    },
    floating = {
      border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
    },
    adapters = {
      require "neotest-rust",
      require "neotest-go" {
        experimental = {
          test_table = true,
        },
      },
      require "neotest-python" {
        dap = { justMyCode = false, console = "integratedTerminal" },
      },
      require "neotest-plenary",
    },
  }

  if lvim.builtin.task_runner == "overseer" then
    opts.consumers = {
      overseer = require "neotest.consumers.overseer",
    }
    opts.overseer = {
      enabled = true,
      force_default = true,
    }
  end

  nt.setup(opts)
end

M.get_env = function()
  local env = {}
  for _, file in ipairs { ".env" } do
    if vim.fn.empty(vim.fn.glob(file)) ~= 0 then
      break
    end

    for _, line in ipairs(vim.fn.readfile(file)) do
      for name, value in string.gmatch(line, "(.+)=['\"]?(.*)['\"]?") do
        local str_end = string.sub(value, -1, -1)
        if str_end == "'" or str_end == '"' then
          value = string.sub(value, 1, -2)
        end

        env[name] = value
      end
    end
  end
  return env
end

M.run_all = function()
  local neotest = require "neotest"
  if lvim.builtin.task_runner == "overseer" then
    neotest.run.run(vim.fn.expand "%")
  else
    for _, adapter_id in ipairs(neotest.run.adapters()) do
      neotest.run.run { suite = true, adapter = adapter_id }
    end
  end
end

M.cancel = function()
  require("neotest").run.stop { interactive = true }
end

M.run_file_sync = function()
  require("neotest").run.run { vim.fn.expand "%", concurrent = false }
end

return M
