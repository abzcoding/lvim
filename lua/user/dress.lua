local M = {}

M.config = function()
  local status_ok, dressing = pcall(require, "dressing")
  if not status_ok then
    return
  end
  local ignored_buftypes = { "neo-tree" }
  if lvim.builtin.noice.active then
    table.insert(ignored_buftypes, "text")
  end

  dressing.setup {
    input = {
      get_config = function()
        local filetype = vim.api.nvim_buf_get_option(0, "filetype")
        if vim.tbl_contains(ignored_buftypes, filetype) then
          return { enabled = false }
        end
      end,
    },
    select = {
      format_item_override = {
        codeaction = function(action_tuple)
          local title = action_tuple[2].title:gsub("\r\n", "\\r\\n")
          local client = vim.lsp.get_client_by_id(action_tuple[1])
          return string.format("%s\t[%s]", title:gsub("\n", "\\n"), client.name)
        end,
      },
    },
  }
end

return M
