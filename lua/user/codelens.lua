local M = {}

M.show_line_sign = function()
  local SIGN_GROUP = "nvim-lightbulblens"
  local SIGN_NAME = "LightBulbLensSign"
  if vim.tbl_isempty(vim.fn.sign_getdefined(SIGN_NAME)) then
    vim.fn.sign_define(SIGN_NAME, { text = " ", texthl = "MoreMsg" })
  end
  local codelens_actions = {}
  for _, l in ipairs(vim.lsp.codelens.get(0)) do
    table.insert(codelens_actions, { start = l.range.start, finish = l.range["end"] })
  end
  local cursor = vim.api.nvim_win_get_cursor(0)
  cursor[1] = cursor[1] - 1
  -- local bufnr = vim.api.nvim_get_current_buf()
  local codelens_found = false
  for _, action in ipairs(codelens_actions) do
    if
      action.start.line <= cursor[1]
      and cursor[1] <= action.finish.line
      and action.start.character <= cursor[2]
      and cursor[2] <= action.finish.character
    then
      codelens_found = true
      if vim.b.codelens_line == cursor[1] + 1 then
        break
      end
      vim.fn.sign_place(cursor[1] + 1, SIGN_GROUP, SIGN_NAME, "%", { lnum = cursor[1] + 1, priority = 12 })
      vim.b.codelens_line = cursor[1] + 1
      break
    end
  end
  if codelens_found == false then
    vim.fn.sign_unplace(SIGN_GROUP, { id = vim.b.codelens_line, buffer = "%" })
    vim.b.codelens_line = nil
  end
  require("nvim-lightbulb").update_lightbulb()
end

return M
