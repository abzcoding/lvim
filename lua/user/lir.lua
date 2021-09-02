local status_ok, lir = pcall(require, "lir")
if not status_ok then
  return
end
local actions = require "lir.actions"
local mark_actions = require "lir.mark.actions"
local clipboard_actions = require "lir.clipboard.actions"

lir.setup {
  show_hidden_files = false,
  devicons_enable = true,
  mappings = {
    ["l"] = actions.edit,
    ["<cr>"] = actions.edit,
    ["<C-s>"] = actions.split,
    ["v"] = actions.vsplit,
    ["<C-t>"] = actions.tabedit,

    ["h"] = actions.up,
    ["q"] = actions.quit,

    ["A"] = actions.mkdir,
    ["a"] = actions.newfile,
    ["r"] = actions.rename,
    ["@"] = actions.cd,
    ["Y"] = actions.yank_path,
    ["."] = actions.toggle_show_hidden,
    ["D"] = actions.delete,

    ["J"] = function()
      mark_actions.toggle_mark()
      vim.cmd "normal! j"
    end,
    ["C"] = clipboard_actions.copy,
    ["X"] = clipboard_actions.cut,
    ["P"] = clipboard_actions.paste,
  },
  float = {
    winblend = 0,
    win_opts = function()
      return {
        border = "rounded",
      }
    end,
  },
  hide_cursor = false,
}

-- custom folder icon
require("nvim-web-devicons").setup {
  override = {
    lir_folder_icon = {
      icon = "",
      color = "#569CD6",
      name = "LirFolderNode",
    },
  },
}

-- use visual mode
function _G.LirSettings()
  vim.api.nvim_buf_set_keymap(
    0,
    "x",
    "J",
    ':<C-u>lua require"lir.mark.actions".toggle_mark("v")<CR>',
    { noremap = true, silent = true }
  )

  -- echo cwd
  vim.api.nvim_echo({ { vim.fn.expand "%:p", "Normal" } }, false, {})
end

vim.cmd [[augroup lir-settings]]
vim.cmd [[  autocmd!]]
vim.cmd [[  autocmd Filetype lir :lua LirSettings()]]
vim.cmd [[augroup END]]
