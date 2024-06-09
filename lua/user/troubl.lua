local M = {}

M.config = function()
  local status_ok, trbl = pcall(require, "trouble")
  if not status_ok then
    return
  end

  trbl.setup {
    focus = true,
    preview = {
      type = "float",
      relative = "editor",
      border = "rounded",
      title = "Preview",
      title_pos = "center",
      position = { 0, -2 },
      size = { width = 0.4, height = 0.3 },
      zindex = 200,
    },
  }

  if lvim.transparent_window then
    vim.cmd [[ hi! TroubleNormal guibg=NONE ]]
    vim.cmd [[ hi! TroubleNormalNC guibg=NONE ]]
  end
end

return M
