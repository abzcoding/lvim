local M = {}

M.config = function()
  local status_ok, noice = pcall(require, "noice")
  if not status_ok then
    return
  end
  noice.setup {
    views = {
      cmdline_popup = {
        win_options = {
          winblend = 5,
          winhighlight = {
            Normal = "NormalFloat",
            FloatBorder = "NoiceCmdlinePopupBorder",
            IncSearch = "",
            Search = "",
          },
          cursorline = false,
        },
        filter_options = {
          {
            filter = { event = "cmdline", find = "^%s*[/?]" },
            opts = {
              border = {
                text = {
                  top = " Search ",
                },
              },
              win_options = {
                winhighlight = {
                  Normal = "NormalFloat",
                  FloatBorder = "NoiceCmdlinePopupBorder",
                  IncSearch = "",
                  Search = "",
                },
              },
            },
          },
        },
      },
    },
    -- cmdline = {
    --   view = "cmdline",
    -- },
    popupmenu = {
      enabled = not lvim.builtin.fancy_wild_menu.active,
    },
    notify = {
      enabled = lvim.builtin.notify.active,
    },
    routes = {
      {
        view = "notify",
        filter = { event = "msg_showmode" },
      },
      {
        filter = { event = "msg_show", kind = "search_count" },
        opts = { skip = true },
      },
      {
        view = "split",
        filter = { event = "msg_show", min_height = 20 },
      },
      {
        filter = {
          event = "msg_show",
          find = "; before #",
        },
        opts = { skip = true },
      },
      {
        filter = {
          event = "msg_show",
          find = "; after #",
        },
        opts = { skip = true },
      },
      {
        filter = {
          event = "msg_show",
          find = " lines, ",
        },
        opts = { skip = true },
      },
      {
        filter = {
          event = "msg_show",
          find = "go up one level",
        },
        opts = { skip = true },
      },
      {
        filter = {
          event = "msg_show",
          find = "yanked",
        },
        opts = { skip = true },
      },
      {
        filter = { find = "No active Snippet" },
        opts = { skip = true },
      },
    },
  }
end

return M
