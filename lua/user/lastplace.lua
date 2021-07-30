local M = {}

M.config = function()
  local status_ok, last_place = pcall(require, "nvim-lastplace")
  if not status_ok then
    return
  end

  last_place.setup {
    lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
    lastplace_ignore_filetype = {
      "gitcommit",
      "gitrebase",
      "svn",
      "hgcommit",
    },
    lastplace_open_folds = true,
  }
end

return M
