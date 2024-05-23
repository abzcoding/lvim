local M = {}

local SIGN_GROUP = "nvim-lightbulblens"
local SIGN_NAME = "LightBulbSign"

-- Set default sign
if vim.tbl_isempty(vim.fn.sign_getdefined(SIGN_NAME)) then
  vim.fn.sign_define(SIGN_NAME, { text = require("user.lsp_kind").icons.code_action, texthl = "MoreMsg" })
end


M.show_line_sign = function()
  -- Check for code action capability
  local code_action_cap_found = false
  for _, client in pairs(vim.lsp.get_clients()) do
    if client then
      if client.supports_method("textDocument/codeAction") then
        code_action_cap_found = true
      end
    end
  end
  if not code_action_cap_found then
    return
  end

  local context = { diagnostics = vim.lsp.diagnostic.get_line_diagnostics() }
  local params = require("vim.lsp.util").make_range_params()
  params.context = context
  local bufnr = vim.api.nvim_get_current_buf()
  vim.lsp.buf_request_all(0, "textDocument/codeAction", params, M.handler_factory(params.range.start.line, bufnr))
end

--- Check if the current line contains a codelens action
---@param cursor {number, number} The cursor position
---@return boolean True if the line contains a codelens action
M.code_lens_available = function(cursor)
  local codelens_actions = {}
  for _, l in ipairs(vim.lsp.codelens.get(0)) do
    table.insert(codelens_actions, { start = l.range.start, finish = l.range["end"] })
  end
  for _, action in ipairs(codelens_actions) do
    if action.start.line <= cursor[1]
        and cursor[1] <= action.finish.line
        and action.start.character <= cursor[2]
        and cursor[2] <= action.finish.character
    then
      return true
    end
  end
  return false
end

--- Handler factory to keep track of current lightbulb line.
---
--- @param line number The line when the the code action request is called
--- @param bufnr number|nil Buffer handle
M.handler_factory = function(line, bufnr)
  --- Handler for textDocument/codeAction.
  ---
  --- See lsp-handler for more information.
  ---
  --- @private
  local function code_action_handler(responses)
    local ignored_messages = {
      "Extract Block",
      "Extract Block To File",
      "Extract Function",
      "Extract Function To File",
      "Extract Variable",
      "Inline Variable",
    }
    -- Check for available code actions from all LSP server responses
    local has_actions = false
    for _, resp in pairs(responses) do
      if resp.result and not vim.tbl_isempty(resp.result) then
        for _, action in ipairs(resp.result) do
          if not vim.tbl_contains(ignored_messages, action.title) then
            has_actions = true
            goto continue
          end
        end
        ::continue::
        break
      end
    end

    local cursor = vim.api.nvim_win_get_cursor(0)
    cursor[1] = cursor[1] - 1
    if M.code_lens_available(cursor) then
      M.update_sign(10, vim.b.lightbulb_line, cursor[1] + 1, bufnr, "code_lens_action")
      return
    end

    -- No available code actions
    if not has_actions then
      M.update_sign(10, vim.b.lightbulb_line, nil, bufnr, "code_action")
    else
      M.update_sign(10, vim.b.lightbulb_line, line + 1, bufnr, "code_action")
    end
  end

  return M.mk_handler(code_action_handler)
end

--- Patch for breaking neovim master update to LSP handlers
--- See: https://github.com/neovim/neovim/issues/14090#issuecomment-913198455
M.mk_handler = function(fn)
  return function(...)
    local config_or_client_id = select(4, ...)
    local is_new = type(config_or_client_id) ~= "number"
    if is_new then
      fn(...)
    else
      local err = select(1, ...)
      local method = select(2, ...)
      local result = select(3, ...)
      local client_id = select(4, ...)
      local bufnr = select(5, ...)
      local config = select(6, ...)
      fn(err, result, { method = method, client_id = client_id, bufnr = bufnr }, config)
    end
  end
end

--- Update sign position from `old_line` to `new_line`.
---
--- Either line can be optional, and will result in just adding/removing
--- the sign on the given line.
---
--- @param priority number The priority of the sign to add
--- @param old_line number|nil The line to remove the sign on
--- @param new_line number|nil The line to add the sign on
--- @param bufnr number|nil Buffer handle
--- @param text string the sign icon
---
M.update_sign = function(priority, old_line, new_line, bufnr, text)
  bufnr = bufnr or 0

  if old_line then
    vim.fn.sign_unplace(SIGN_GROUP, { id = old_line, buffer = bufnr })

    -- Update current lightbulb line
    vim.b.lightbulb_line = nil
  end

  -- Avoid redrawing lightbulb if code action line did not change
  if new_line and (vim.b.lightbulb_line ~= new_line) then
    vim.fn.sign_place(new_line, SIGN_GROUP, SIGN_NAME, bufnr, { lnum = new_line, priority = priority })
    -- Update current lightbulb line
    vim.b.lightbulb_line = new_line
  end
  local icon = require("user.lsp_kind").icons.code_action
  if text == "code_lens_action" then
    icon = require("user.lsp_kind").icons.code_lens_action
  end
  vim.fn.sign_define(SIGN_NAME, { text = icon, texthl = "MoreMsg" })
end

return M
