local M = {}

M.config = function()
  local status_ok, todo = pcall(require, "todo-comments")
  if not status_ok then
    return
  end

  todo.setup {
    keywords = {
      FIX = { icon = "律" },
      TODO = { icon = " ", alt = { "WIP" } },
      HACK = { icon = " ", color = "hack" },
      WARN = { icon = "裂" },
      PERF = { icon = "龍" },
      NOTE = { icon = " ", alt = { "INFO", "NB" } },
      ERROR = { icon = " ", color = "error", alt = { "ERR" } },
      REFS = { icon = "" },
    },
    highlight = { max_line_len = 120 },
    colors = {
      error = { "DiagnosticError" },
      warning = { "DiagnosticWarn" },
      info = { "DiagnosticInfo" },
      hint = { "DiagnosticHint" },
      hack = { "Function" },
      ref = { "FloatBorder" },
      default = { "Identifier" },
    },
  }
end

return M
