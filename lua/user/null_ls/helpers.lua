local M = {}
local methods = require "null-ls.methods"
local c = require "null-ls.config"
local loop = require "null-ls.loop"
local code_action = methods.internal.CODE_ACTION

M.extract_struct_name = function(params)
  local linenr = params.row
  local line = params.content[linenr]
  return line:match "^type (.*) struct"
end

M.prompt_tag_name = function()
  return vim.fn.input "Enter struct tag: "
end

M.make_code_action = function(opts)
  local name = opts.name
  local filetypes = opts.filetypes or {}
  local action_fn = opts.action_fn
  local save_on_return = opts.save_on_return or true

  return {
    name = name,
    method = code_action,
    filetypes = filetypes,
    generator = {
      fn = function(params)
        -- cli callback handler
        local handler = function(_, output)
          if not output then
            return
          end

          -- patch params method
          params.lsp_method = methods.lsp.FORMATTING
          require("null-ls.formatting").apply_edits({
            {
              row = 1,
              col = 1,
              end_row = vim.tbl_count(params.content) + 1,
              end_col = 1,
              text = output,
            },
          }, params)

          if save_on_return then
            vim.schedule(function()
              vim.cmd(params.bufnr .. "bufdo! silent keepjumps noautocmd update")
            end)
          end
        end

        -- function to invoke cli
        local invoke_cli = function(action)
          local command = action.command
          local args = action.args
          local timeout = action.timeout or c.get().default_timeout
          local stdin = action.stdin or false
          assert(
            vim.fn.executable(command) > 0,
            string.format("command %s is not executable (make sure it's installed and on your $PATH)", command)
          )

          local client = vim.lsp.get_client_by_id(params.client_id)
          local spawn_opts = {
            cwd = client and client.config.root_dir or vim.fn.getcwd(),
            input = content,
            handler = handler,
            timeout = timeout,
          }
          if stdin then
            local content = table.concat(params.content, "\n")
            spawn_opts["input"] = content
          end

          loop.spawn(command, args, spawn_opts)
        end

        local action_list = action_fn(params)
        if not action_list then
          return
        end

        local actions = {}
        for _, action in pairs(action_list) do
          table.insert(actions, {
            title = action.title,
            action = function()
              if action.callback then
                action.callback(invoke_cli)
              else
                invoke_cli(action)
              end
            end,
          })
        end

        return actions
      end,
    },
  }
end

return M
