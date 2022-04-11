local M = {}

M.config = function()
  local status_ok, neoclip = pcall(require, "neoclip")
  if not status_ok then
    return
  end

  neoclip.setup {
    history = 50,
    enable_persistent_history = lvim.builtin.neoclip.enable_persistent_history,
    db_path = vim.fn.stdpath "data" .. "/neoclip.sqlite3",
    keys = {
      telescope = {
        i = { select = "<c-p>", paste = "<CR>", paste_behind = "<c-k>" },
        n = { select = "p", paste = "<CR>", paste_behind = "P" },
      },
    },
  }
  local function clip()
    local opts = {
      winblend = 10,
      layout_strategy = "flex",
      layout_config = {
        prompt_position = "top",
        width = 0.8,
        height = 0.6,
        horizontal = { width = { padding = 0.15 } },
        vertical = { preview_height = 0.70 },
      },
      borderchars = {
        prompt = { "─", "│", " ", "│", "╭", "╮", "│", "│" },
        results = { "─", "│", "─", "│", "├", "┤", "╯", "╰" },
        preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
      },
      border = {},
      shorten_path = false,
    }
    local dropdown = require("telescope.themes").get_dropdown(opts)
    require("telescope").extensions.neoclip.default(dropdown)
  end
  local whk_status, whk = pcall(require, "which-key")
  if not whk_status then
    return
  end
  whk.register {
    ["<leader>y"] = { clip, " open yank history" },
  }
end

return M
