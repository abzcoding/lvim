local M = {}

M.config = function()
  local status_ok, noice = pcall(require, "noice")
  if not status_ok then
    return
  end
  noice.setup {
    cmdline = {
      view = "cmdline",
    },
    popupmenu = {
      enabled = not lvim.builtin.fancy_wild_menu.active,
    },
  }
end

return M
