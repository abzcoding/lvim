local M = {}

M.config = function()
  local status_ok, crates = pcall(require, "crates")
  if not status_ok then
    return
  end

  -- NOTE: use the default values
  crates.setup {}
end

return M
