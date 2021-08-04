local M = {}

M.setup = function()
  local fname = vim.fn.expand "%"
  lvim.lang.dockerfile.lsp = {
    provider = "dockerls",
    setup = {
      cmd = {
        DATA_PATH .. "/lspinstall/dockerfile/node_modules/.bin/docker-langserver",
        "--stdio",
      },
      filetypes = { "Dockerfile", "dockerfile" },
      root_dir = function()
        return require("lspconfig").util.root_pattern ".git"(fname) or require("lspconfig").util.path.dirname(fname)
      end,
    },
  }
  require("lsp").setup "dockerfile"
end

return M
