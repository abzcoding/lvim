local M = {}

local function default_commands()
end

M.config = function()
  local status_ok, legend = pcall(require, "legendary")
  if not status_ok then
    return
  end

  legend.setup {
    select_prompt = function(kind)
      if kind == "legendary.items" then
        return " Legendary "
      end

      -- Convert kind to Title Case (e.g. legendary.keymaps => Legendary Keymaps)
      return " " .. string.gsub(" " .. kind:gsub("%.", " "), "%W%l", string.upper):sub(2) .. " "
    end,
    commands = {
      { ':Telescope live_grep', description = 'Find Text ( live grep )' },
    }
  }
end


return M
