local M = {}

M.config = function()
  local status_ok, mk = pcall(require, "render-markdown")
  if not status_ok then
    return
  end
  mk.setup {
    start_enabled = true,
    latex_enabled = false,
    max_file_size = 3,
    log_level = "error",
    file_types = { "markdown" },
    headings = { "󰼏 ", "󰎨 ", "󰼑 ", "󰎲 ", "󰼓 ", "󰼏 " },
    dash = "─",
    bullets = { "●", "○", "◆", "◇" },
    checkbox = {
      unchecked = "󰄱 ",
      checked = "󰄵 ",
    },
    win_options = {
      conceallevel = {
        default = vim.api.nvim_get_option_value("conceallevel", {}),
        rendered = 1,
      },
      concealcursor = {
        default = vim.api.nvim_get_option_value("concealcursor", {}),
        rendered = "nvic",
      },
    },
    quote = "▋",
    callout = {
      note = " Note",
      tip = "󰌶 Tip",
      important = " Important",
      warning = " Warning",
      caution = " Caution",
    },
    table_style = "full",
    cell_style = "overlay",
    custom_handlers = {},
    highlights = {
      heading = {
        -- backgrounds = { 'diffRemoved', 'diffNewFile', 'diffOldFile', 'diffAdded', 'diffChanged', 'String' },
        -- backgrounds = { 'DiffDelete', 'DiffChange', 'DiffText', 'DiffAdd', 'DiffNew', 'String' },
        backgrounds = {},
        foregrounds = {
          "rainbow1",
          "rainbow2",
          "rainbow3",
          "rainbow4",
          "rainbow5",
          "rainbow6",
        },
      },
    },
  }
end

return M
