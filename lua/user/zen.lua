local M = {}

M.config = function()
  local status_ok, zen_mode = pcall(require, "zen-mode")
  if not status_ok then
    return
  end

  zen_mode.setup {
    window = {
      backdrop = 1,
      height = 0.9, -- height of the Zen window
      width = 0.85,
      options = {
        signcolumn = "no", -- disable signcolumn
        number = false, -- disable number column
        relativenumber = false, -- disable relative numbers
      },
    },
    plugins = {
      gitsigns = { enabled = false }, -- disables git signs
      tmux = { enabled = true },
      twilight = { enabled = true },
    },
    on_open = function()
      vim.lsp.diagnostic.set_virtual_text = false
      vim.cmd [[
          set foldlevel=10
          ]]
    end,
    on_close = function()
      vim.lsp.diagnostic.set_virtual_text = {
        prefix = "",
        spacing = 0,
      }
      vim.cmd [[
          set foldlevel=4
          set foldmethod=expr
          set foldexpr=nvim_treesitter#foldexpr()
          ]]
    end,
  }
end

return M
