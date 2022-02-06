local M = {}

M.config = function()
  vim.g["vista#renderer#enable_icon"] = 1
  vim.g["vista#renderer#enable_kind"] = 1
  vim.g.vista_disable_statusline = 1
  vim.g.vista_update_on_text_changed = 1
  vim.g.vista_default_executive = "nvim_lsp" -- ctag
  vim.g.vista_echo_cursor_strategy = "floating_win"
  vim.g.vista_vimwiki_executive = "markdown"
  vim.g.vista_executive_for = {
    vimwiki = "markdown",
    pandoc = "markdown",
    markdown = "toc",
    typescript = "nvim_lsp",
    typescriptreact = "nvim_lsp",
    go = "nvim_lsp",
    lua = "nvim_lsp",
    python = "nvim_lsp",
    rust = "nvim_lsp",
  }
end

return M
