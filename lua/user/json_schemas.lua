-- https://www.schemastore.org/json/
local M = {}

M.setup = function()
  local schemas = {
    {
      description = "Package JSON file",
      fileMatch = { "package.json" },
      url = "https://json.schemastore.org/package.json",
    },
    {
      description = "TypeScript compiler configuration file",
      fileMatch = { "tsconfig.json", "tsconfig.*.json" },
      url = "http://json.schemastore.org/tsconfig",
    },
    {
      description = "Lerna config",
      fileMatch = { "lerna.json" },
      url = "http://json.schemastore.org/lerna",
    },
    {
      description = "Babel configuration",
      fileMatch = { ".babelrc.json", ".babelrc", "babel.config.json" },
      url = "http://json.schemastore.org/lerna",
    },
    {
      description = "ESLint config",
      fileMatch = { ".eslintrc.json", ".eslintrc" },
      url = "http://json.schemastore.org/eslintrc",
    },
    {
      description = "Bucklescript config",
      fileMatch = { "bsconfig.json" },
      url = "https://bucklescript.github.io/bucklescript/docson/build-schema.json",
    },
    {
      description = "Prettier config",
      fileMatch = { ".prettierrc", ".prettierrc.json", "prettier.config.json" },
      url = "http://json.schemastore.org/prettierrc",
    },
    {
      description = "Vercel Now config",
      fileMatch = { "now.json" },
      url = "http://json.schemastore.org/now",
    },
    {
      description = "Stylelint config",
      fileMatch = { ".stylelintrc", ".stylelintrc.json", "stylelint.config.json" },
      url = "http://json.schemastore.org/stylelintrc",
    },
  }

  local function extend(tab1, tab2)
    for _, value in ipairs(tab2) do
      table.insert(tab1, value)
    end
    return tab1
  end

  local extended_schemas = extend(schemas, require("nlspsettings.jsonls").get_default_schemas())

  lvim.lang.json.lsp.setup.settings = {
    json = {
      schemas = extended_schemas,
    },
  }
end

return M
