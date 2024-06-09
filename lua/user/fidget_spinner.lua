local M = {}

M.config = function()
  local status_ok, fidget = pcall(require, "fidget")
  if not status_ok then
    return
  end

  fidget.setup {
    progress = {
      poll_rate = 0,
      suppress_on_insert = false,
      ignore_done_already = true,
      ignore_empty_message = true,
      ignore = { "null-ls", "none-ls" },

      display = {
        done_icon = "",
        done_style = "Constant",
        progress_icon = {
          pattern = {
            " ",
            " ",
            " ",
            " ",
            " ",
            " ",
            " ",
            " ",
            " ",
            " ",
            " ",
            " ",
            " ",
            " ",
            " ",
            " ",
            " ",
            " ",
            " ",
            " ",
            " ",
            " ",
            " ",
            " ",
            " ",
            " ",
            " ",
            " ",
          },
          period = 1,
        },
        format_message = function(msg)
          local message = msg.message
          if not message then
            message = msg.done and " " or " "
          end
          if msg.percentage ~= nil then
            message = string.format("%s (%.0f%%)", message, msg.percentage)
          end
          return message
        end,
      },
    },
    notification = {
      window = {
        winblend = 0,
      },
    },
    integration = {
      ["nvim-tree"] = {
        enable = lvim.builtin.tree_provider == "nvimtree",
      },
    },
  }
end

return M
