local M = {}

M.config = function()
  local status_ok, neoclip = pcall(require, "neoclip")
  if not status_ok then
    return
  end

  neoclip.setup {
    enable_persistant_history = true,
    db_path = vim.fn.stdpath "data" .. "/neoclip.sqlite3",
    keys = {
      i = { select = "<c-p>", paste = "<CR>", paste_behind = "<c-k>" },
      n = { select = "p", paste = "<CR>", paste_behind = "P" },
    },
  }
  local function clip()
    require("telescope").extensions.neoclip.default(require("telescope.themes").get_dropdown())
  end
  local whk_status, whk = pcall(require, "which-key")
  if not whk_status then
    return
  end
  whk.register {
    ["<leader>y"] = { clip, "neoclip: open yank history" },
  }
end

return M
