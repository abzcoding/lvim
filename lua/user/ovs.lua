local M = {}

M.config = function()
  local status_ok, see = pcall(require, "overseer")
  if not status_ok then
    return
  end
  local STATUS = require("overseer.constants").STATUS

  see.setup {
    log = {
      {
        type = "echo",
        level = vim.log.levels.WARN,
      },
      {
        type = "file",
        filename = "overseer.log",
        level = vim.log.levels.DEBUG,
      },
    },
    component_aliases = {
      default = {
        "on_output_summarize",
        "on_exit_set_status",
        { "on_complete_notify", system = "unfocused" },
        "on_complete_dispose",
      },
      default_neotest = {
        { "on_complete_notify", system = "unfocused", on_change = true },
        "default",
      },
    },
    actions = {
      ["keep runnning"] = {
        desc = "restart the task even if it succeeds",
        run = function(task)
          task:add_components { { "on_complete_restart", statuses = { STATUS.FAILURE, STATUS.SUCCESS } } }
          if task.status == STATUS.FAILURE or task.status == STATUS.SUCCESS then
            task:restart()
          end
        end,
      },
      ["don't dispose"] = {
        desc = "keep the task until manually disposed",
        run = function(task)
          task:remove_components { "on_complete_dispose" }
        end,
      },
    },
  }

  see.register_template {
    generator = function()
      local logHandler = io.popen [[fd -e log]]
      local ret = {}
      if logHandler then
        local logs = logHandler:read "*a"
        logHandler:close()
        for log in logs:gmatch "([^\r\n]+)" do
          table.insert(ret, {
            name = "Show " .. log,
            builder = function()
              return {
                name = "Show " .. log,
                cmd = "tail --follow --retry " .. log,
              }
            end,
            priority = 1000,
            params = {},
          })
        end
      end
      return ret
    end,
  }
end

return M
