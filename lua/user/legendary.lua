local M = {}

local function default_commands() end

M.config = function()
  local status_ok, legend = pcall(require, "legendary")
  if not status_ok then
    return
  end

  legend.setup {
    select_prompt = " Legendary ",
    commands = {
      { ":Telescope live_grep", description = "Find Text ( live grep )" },
    },
  }
end

return M
