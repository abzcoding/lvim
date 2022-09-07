local M = {}

M.config = function()
  local status_ok, ui = pcall(require, "dapui")
  if not status_ok then
    return
  end

  ui.setup {
    expand_lines = true,
    icons = {
      expanded = "",
      collapsed = "",
      circular = "",
    },
    layouts = {
      {
        elements = {
          { id = "scopes", size = 0.33 },
          { id = "breakpoints", size = 0.17 },
          { id = "stacks", size = 0.25 },
          { id = "watches", size = 0.25 },
        },
        size = 0.31,
        position = "left",
      },
      {
        elements = { { id = "repl", size = 0.45 }, { id = "console", size = 0.55 } },
        size = 0.26,
        position = "bottom",
      },
    },
    floating = { max_width = 0.9, max_height = 0.5, border = vim.g.border_chars },
  }
end

return M
