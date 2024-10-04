local lvim_lsp_utils = require "lvim.lsp.utils"
if lvim_lsp_utils.is_client_active "lua_ls" then
  return
end

local lvim_lsp = require "lvim.lsp"
local default_workspace = {
  library = {
    vim.fn.expand "$VIMRUNTIME",
    get_lvim_base_dir(),
    -- require("neodev.config").types(),
    "${3rd}/busted/library",
    "${3rd}/luassert/library",
    "${3rd}/luv/library",
  },

  maxPreload = 5000,
  preloadFileSize = 10000,
}
local opts = {
  settings = {
    Lua = {
      telemetry = { enable = false },
      runtime = {
        version = "LuaJIT",
        special = {
          reload = "require",
        },
      },
      diagnostics = {
        globals = { "vim", "lvim", "reload" },
      },
      workspace = default_workspace,
    },
  },
  on_attach = lvim_lsp.common_on_attach,
  on_init = lvim_lsp.common_on_init,
  on_exit = lvim_lsp.common_on_exit,
  capabilities = lvim_lsp.common_capabilities(),
}
-- require("lvim.lsp.manager").setup("lua_ls", opts)
vim.schedule(function()
  require("lspconfig").lua_ls.setup(opts)
  local bufnr = vim.api.nvim_get_current_buf()
  require("lspconfig").lua_ls.manager:try_add_wrapper(bufnr)
end)
