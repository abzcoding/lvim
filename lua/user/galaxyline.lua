local M = {}

M.config = function(gl)
  local gls = gl.section
  local lsp_status = require "lsp-status"
  lsp_status.config {
    indicator_errors = "E",
    indicator_warnings = "W",
    indicator_info = "i",
    indicator_hint = "?",
    indicator_ok = "Ok",
    diagnostics = false,
    status_symbol = "",
  }
  lsp_status.register_progress()
  table.insert(gls.left, {
    LspStatus = {
      provider = function()
        return lsp_status.status()
      end,
      -- event = "BufEnter",
      separator = "",
      separator_highlight = { "NONE", "#262626" },
      highlight = { "#c8c9c1", "#262626" },
    },
  })
end

return M
