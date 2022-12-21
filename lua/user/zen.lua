local M = {}

M.hide_diagnostics = function()
  local clients = vim.lsp.get_active_clients()
  for _, client in ipairs(clients) do
    local ns = vim.lsp.diagnostic.get_namespace(client.id)
    vim.diagnostic.hide(ns)
  end

  if vim.bo.filetype == "rust" then
    vim.cmd "RustDisableInlayHints"
  end
end

M.show_diagnostics = function()
  local clients = vim.lsp.get_active_clients()
  for _, client in ipairs(clients) do
    local ns = vim.lsp.diagnostic.get_namespace(client.id)
    vim.diagnostic.show(ns, nil, nil, lvim.lsp.diagnostics)
  end

  if vim.bo.filetype == "rust" then
    vim.cmd "RustEnableInlayHints"
  end
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
          lua require('lsp-inlayhints').toggle()
          IndentBlanklineDisable!
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
          lua require('lsp-inlayhints').toggle()
          IndentBlanklineEnable!
          ]]
      if lvim.builtin.tmux_lualine == false then
        require("lualine").hide { unhide = true }
      end
    end,
  }
end

return M
