local M = {}

local function truncate(str, max_len)
  assert(str and max_len, "string and max_len must be provided")
  return vim.api.nvim_strwidth(str) > max_len and str:sub(1, max_len) .. "…" or str
end

local function render(props)
  local fmt = string.format
  local devicons = require "nvim-web-devicons"
  local bufname = vim.api.nvim_buf_get_name(props.buf)
  if bufname == "" then
    return "[No name]"
  end
  local ret = vim.api.nvim_get_hl(0, { name = "Directory" })
  local directory_color = string.format("#%06x", ret["fg"])
  local parts = vim.split(vim.fn.fnamemodify(bufname, ":."), "/")
  local result = {}
  for idx, part in ipairs(parts) do
    if next(parts, idx) then
      vim.list_extend(result, {
        { truncate(part, 20) },
        { fmt(" %s ", ""), guifg = directory_color },
      })
    else
      table.insert(result, { part, gui = "bold", guisp = directory_color })
    end
  end
  local icon, color = devicons.get_icon_color(bufname, nil, { default = true })
  table.insert(result, #result, { icon .. " ", guifg = color })
  return result
end

M.config = function()
  local status_ok, incl = pcall(require, "incline")
  if not status_ok then
    return
  end

  incl.setup {
    window = {
      zindex = 49,
      winhighlight = {
        inactive = {
          Normal = "Directory",
        },
      },
      width = "fit",
      padding = { left = 2, right = 1 },
      placement = { vertical = "top", horizontal = "right" },
      margin = {
        horizontal = 0,
      },
    },
    hide = {
      cursorline = false,
      focused_win = true,
      only_win = false,
    },
    render = render,
  }
end

return M
