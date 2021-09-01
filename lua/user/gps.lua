local M = {}

M.config = function()
  local status_ok, gps = pcall(require, "nvim-gps")
  if not status_ok then
    return
  end
  gps.setup {
    icons = {
      ["class-name"] = " ",
      ["function-name"] = " ",
      ["method-name"] = " ",
    },
    languages = { -- You can disable any language individually here
      ["c"] = true,
      ["cpp"] = true,
      ["go"] = true,
      ["java"] = true,
      ["javascript"] = true,
      ["lua"] = true,
      ["python"] = true,
      ["rust"] = true,
      ["yaml"] = false,
    },
    separator = " > ",
  }
end

return M
