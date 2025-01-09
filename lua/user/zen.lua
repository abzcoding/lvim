local M = {}

M.hide_diagnostics = function()
  vim.diagnostic.hide()
end

M.show_diagnostics = function()
  vim.diagnostic.show()
end

M.config = function()
  local status_ok, zen_mode = pcall(require, "zen-mode")
  if not status_ok then
    return
  end

  zen_mode.setup {
    window = {
      backdrop = 1,
      height = 0.9, -- height of the Zen window
      width = 0.6,
      options = {
        signcolumn = "no", -- disable signcolumn
        number = false, -- disable number column
        relativenumber = false, -- disable relative numbers
      },
    },
    plugins = {
      gitsigns = { enabled = false }, -- disables git signs
      tmux = { enabled = not lvim.builtin.tmux_lualine },
      twilight = { enabled = true },
      kitty = {
        enabled = false,
        font = "+2", -- font size increment
      },
    },
    on_open = function()
      lvim.builtin.cmp.active = false
      vim.cmd [[
          set foldlevel=10
          lua require("user.zen").hide_diagnostics()
          lua require("user.indent_blankline").disable()
          ]]
      if lvim.builtin.tmux_lualine == false then
        require("lualine").hide()
      end
    end,
    on_close = function()
      lvim.builtin.cmp.active = true
      vim.cmd [[
          set foldlevel=4
          set foldmethod=expr
          set foldexpr=nvim_treesitter#foldexpr()
          lua require("user.zen").show_diagnostics()
          lua require("user.indent_blankline").enable()
          ]]
      if lvim.builtin.tmux_lualine == false then
        require("lualine").hide { unhide = true }
      end
    end,
  }
end

return M
