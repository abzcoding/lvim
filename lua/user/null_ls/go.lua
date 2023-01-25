local M = {}
local methods = require "null-ls.methods"
local code_action = methods.internal.CODE_ACTION
local helpers = require "user.null_ls.helpers"

M.gostructhelper = helpers.make_code_action {
  name = "gostructhelper",
  method = code_action,
  filetypes = { "go" },
  action_fn = function(params)
    local typ = helpers.extract_struct_name(params)
    if not typ then
      return
    end

    local command = "gostructhelper"
    local actions = {
      {
        title = "[gostructhelper] Generate constructor",
        command = command,
        stdin = true,
        args = { "-stdin", "-file", params.bufname, "-type", typ, "-constructor" },
      },
      {
        title = "[gostructhelper] Generate getter",
        command = command,
        stdin = true,
        args = { "-stdin", "-file", params.bufname, "-type", typ, "-getter" },
      },
    }
    return actions
  end,
}

return M
