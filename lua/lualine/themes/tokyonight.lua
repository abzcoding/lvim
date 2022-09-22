local colors = require("tokyonight.colors").setup { transform = true }
local config = require("tokyonight.config").options

local tokyonight = {}

tokyonight.normal = {
  a = { bg = colors.blue, fg = colors.black },
  b = { bg = "#1f2335", fg = colors.blue },
  c = { bg = "#1a1b26", fg = colors.fg_sidebar },
}

tokyonight.insert = {
  a = { bg = colors.green, fg = colors.black },
  b = { bg = "#1f2335", fg = colors.green },
  c = { bg = "#1a1b26", fg = colors.fg_sidebar },
}

tokyonight.command = {
  a = { bg = colors.yellow, fg = colors.black },
  b = { bg = "#1f2335", fg = colors.yellow },
  c = { bg = "#1a1b26", fg = colors.fg_sidebar },
}

tokyonight.visual = {
  a = { bg = colors.magenta, fg = colors.black },
  b = { bg = "#1f2335", fg = colors.magenta },
  c = { bg = "#1a1b26", fg = colors.fg_sidebar },
}

tokyonight.replace = {
  a = { bg = colors.red, fg = colors.black },
  b = { bg = "#1f2335", fg = colors.red },
  c = { bg = "#1a1b26", fg = colors.fg_sidebar },
}

tokyonight.inactive = {
  a = { bg = colors.bg_statusline, fg = colors.blue },
  b = { bg = colors.bg_statusline, fg = colors.fg_gutter, gui = "bold" },
  c = { bg = colors.bg_statusline, fg = colors.fg_gutter },
}

if config.lualine_bold then
  for _, mode in pairs(tokyonight) do
    mode.a.gui = "bold"
  end
end

return tokyonight
