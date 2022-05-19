local M = {}

M.config = function()
  local t = require "toggleterm"
  local terms = require "toggleterm.terminal"

  vim.g["test#custom_strategies"] = {
    toggleterm = function(cmd)
      t.exec(cmd, nil, nil, nil, "float")
    end,
    toggleterm_close = function(cmd)
      local term_id = 0
      t.exec(cmd, term_id)
      terms.get_or_create_term(term_id):close()
    end,
  }
end

return M
