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

M.gomodifytags = helpers.make_code_action {
  name = "gomodifytags",
  filetypes = { "go" },
  method = code_action,
  action_fn = function(params)
    local typ = helpers.extract_struct_name(params)
    if not typ then
      return
    end
    -- local tool = "gomodifytags"
  --   local config = {
  --     cmd = "./" .. tool,

  --     install_script = [[
  -- GOPATH=$(pwd) GOBIN=$(pwd) GO111MODULE=on go get -v github.com/fatih/gomodifytags
  -- GOPATH=$(pwd) GO111MODULE=on go clean -modcache
  -- ]],
  --   }
    local command = "gomodifytags"
    local actions = {
      {
        title = "[gomodifytags] Add struct tags",
        callback = function(invoke_cli)
          local tag = helpers.prompt_tag_name()
          if not tag then
            return
          end
          invoke_cli {
            command = command,
            args = { "-file", params.bufname, "-struct", typ, "-skip-unexported", "-add-tags", tag },
          }
        end,
      },
      {
        title = "[gomodifytags] Remove struct tags",
        callback = function(invoke_cli)
          local tag = helpers.prompt_tag_name()
          if not tag then
            return
          end
          invoke_cli {
            command = command,
            args = { "-file", params.bufname, "-struct", typ, "-skip-unexported", "-remove-tags", tag },
          }
        end,
      },
      {
        title = "[gomodifytags] Clear struct tags",
        command = command,
        args = { "-file", params.bufname, "-struct", typ, "-skip-unexported", "-clear-tags" },
      },
    }
    return actions
  end,
}

return M
