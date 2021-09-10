local M = {}

M.config = function()
  local luadev = require("lua-dev").setup {
    library = {
      vimruntime = true, -- runtime path
      types = true, -- full signature, docs and completion of vim.api, vim.treesitter, vim.lsp and others
      plugins = false, -- installed opt or start plugins in packpath
      -- you can also specify the list of plugins to make available as a workspace library
      -- plugins = { "nvim-treesitter", "plenary.nvim", "telescope.nvim" },
    },
    lspconfig = lvim.lang.lua.lsp.setup,
  }
  lvim.lang.lua.lsp.setup = luadev
end

return M
