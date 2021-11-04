local M = {}

M.config = function()
  local status_ok, hop = pcall(require, "hop")
  if not status_ok then
    return
  end
  hop.setup()
  require("user.keybindings").set_hop_keymaps()
end

return M
