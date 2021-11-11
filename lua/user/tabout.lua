local M = {}

M.config = function()
  local status_ok, tabout = pcall(require, "tabout")
  if not status_ok then
    return
  end

  tabout.setup {
    completion = false,
    ignore_beginning = false,
    tabouts = {
      { open = "'", close = "'" },
      { open = '"', close = '"' },
      { open = "`", close = "`" },
      { open = "(", close = ")" },
      { open = "[", close = "]" },
      { open = "{", close = "}" },
    },
  }
end

return M
