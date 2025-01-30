local M = {}

M.config = function()
  local status_ok, see = pcall(require, "overseer")
  if not status_ok then
    return
  end
  local STATUS = require("overseer.constants").STATUS

  see.setup {
    templates = { builtin = true },
    strategy = { "jobstart" },
    task_list = {
      bindings = {
        dd = "Dispose",
      },
    },
    task_launcher = {
      bindings = {
        n = {
          ["<leader>c"] = "Cancel",
        },
      },
    },
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
        { "display_duration", detail_level = 2 },
      },
      default_neotest = {
        "unique",
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
end

return M
