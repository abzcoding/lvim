local M = {}

M.config = function()
  local status_ok, bqf = pcall(require, "bqf")
  if not status_ok then
    return
  end

  bqf.setup {
    auto_enable = true,
    magic_window = true,
    auto_resize_height = false,
    func_map = {
      split = "s",
      vsplit = "v",
      stoggleup = "M",
      stoggledown = "m",
      stogglevm = "m",
      filterr = "f",
      filter = "F",
    },
    preview = {
      auto_preview = false,
      show_title = true,
      delay_syntax = 50,
      wrap = false,
      should_preview_cb = function(bufnr)
        local ret = true
        local filename = vim.api.nvim_buf_get_name(bufnr)
        local fsize = vim.fn.getfsize(filename)
        -- file size greater than 100k can't be previewed automatically
        if fsize > 100 * 1024 then
          ret = false
        end
        return ret
      end,
    },
  }
end

return M
