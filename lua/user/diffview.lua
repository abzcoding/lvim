local M = {}

M.config = function()
  local status_ok, diff = pcall(require, "diffview")
  if not status_ok then
    return
  end

  diff.setup {
    default_args = {
      DiffviewFileHistory = { "%" },
    },
    hooks = {
      diff_buf_read = function()
        vim.wo.wrap = false
        vim.wo.list = false
        vim.wo.colorcolumn = ""
      end,
    },
    enhanced_diff_hl = true,
    keymaps = {
      view = { q = "<Cmd>DiffviewClose<CR>" },
      file_panel = { q = "<Cmd>DiffviewClose<CR>" },
      file_history_panel = { q = "<Cmd>DiffviewClose<CR>" },
    },
  }
end

return M
