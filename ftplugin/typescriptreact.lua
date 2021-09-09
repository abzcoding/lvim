lvim.lang.typescriptreact.formatters = {
  {
    exe = "prettier",
    -- args = {},
  },
}
lvim.lang.typescriptreact.linters = {
  {
    exe = "eslint_d",
    -- args = {},
  },
}
local bufnr = vim.api.nvim_get_current_buf()
local opts = { silent = true }
vim.api.nvim_buf_set_keymap(bufnr, "n", "gS", ":TSLspOrganize<CR>", opts)
vim.api.nvim_buf_set_keymap(bufnr, "n", "gA", ":TSLspImportAll<CR>", opts)
