local M = {}

M.setup = function()
  lvim.lang.markdown.lsp = {
    provider = "tailwindcss",
    setup = {
      cmd = {
        DATA_PATH .. "/lspinstall/tailwindcss/tailwindcss-intellisense.sh",
        "--stdio",
      },
      on_attach = require("lsp").common_on_attach,
      on_init = require("lsp").common_on_init,
      capabilities = require("lsp").common_capabilities(),
      filetypes = { "markdown" },
      init_options = {
        userLanguages = {
          md = "markdown",
        },
      },
      on_new_config = function(new_config)
        if not new_config.settings then
          new_config.settings = {}
        end
        if not new_config.settings.editor then
          new_config.settings.editor = {}
        end
        if not new_config.settings.editor.tabSize then
          -- set tab size for hover
          new_config.settings.editor.tabSize = vim.lsp.util.get_effective_tabstop()
        end
      end,
      root_dir = require("lspconfig").util.root_pattern(
        "tailwind.config.js",
        "tailwind.config.ts",
        "postcss.config.js",
        "postcss.config.ts",
        "package.json",
        "node_modules",
        ".git"
      ),
      settings = {
        tailwindCSS = {
          lint = {
            cssConflict = "warning",
            invalidApply = "error",
            invalidConfigPath = "error",
            invalidScreen = "error",
            invalidTailwindDirective = "error",
            invalidVariant = "error",
            recommendedVariantOrder = "warning",
          },
          validate = true,
        },
      },
    },
  }
  require("lsp").setup "markdown"
end

return M
