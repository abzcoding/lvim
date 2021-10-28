local M = {}

M.config = function()
  local status_ok, todo = pcall(require, "todo-comments")
  if not status_ok then
    return
  end
  vim.cmd [[
  if !hlexists('TextSuccess')
    hi! link TextSuccess Normal
  endif
  ]]

  todo.setup {
    keywords = {
      FIX = { icon = "律" },
      TODO = { icon = " " },
      HACK = { icon = " ", color = "hack" },
      WARN = { icon = "裂" },
      PERF = { icon = "龍" },
      NOTE = { icon = " ", alt = { "INFO", "NB" } },
      LINK = { icon = " ", color = "ref", alt = { "LINKS", "REF", "REFS" } },
      SUCCESS = { icon = " ", color = "success", alt = { "OK", "DONE" } },
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
      success = { "TextSuccess" },
      default = { "Identifier" },
    },
  }
end

return M
