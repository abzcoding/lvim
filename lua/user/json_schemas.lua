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
      fileMatch = {
        "tsconfig.json",
        "tsconfig.*.json",
      },
      url = "http://json.schemastore.org/tsconfig",
    },
    {
      description = "Lerna config",
      fileMatch = { "lerna.json" },
      url = "http://json.schemastore.org/lerna",
    },
    {
      description = "Babel configuration",
      fileMatch = {
        ".babelrc.json",
        ".babelrc",
        "babel.config.json",
      },
      url = "http://json.schemastore.org/lerna",
    },
    {
      description = "ESLint config",
      fileMatch = {
        ".eslintrc.json",
        ".eslintrc",
      },
      url = "http://json.schemastore.org/eslintrc",
    },
    {
      description = "Bucklescript config",
      fileMatch = { "bsconfig.json" },
      url = "https://bucklescript.github.io/bucklescript/docson/build-schema.json",
    },
    {
      description = "Prettier config",
      fileMatch = {
        ".prettierrc",
        ".prettierrc.json",
        "prettier.config.json",
      },
      url = "http://json.schemastore.org/prettierrc",
    },
    {
      description = "Vercel Now config",
      fileMatch = { "now.json" },
      url = "http://json.schemastore.org/now",
    },
    {
      description = "Stylelint config",
      fileMatch = {
        ".stylelintrc",
        ".stylelintrc.json",
        "stylelint.config.json",
      },
      url = "http://json.schemastore.org/stylelintrc",
    },
    {
      description = "A JSON schema for the ASP.NET LaunchSettings.json files",
      fileMatch = { "launchsettings.json" },
      url = "https://json.schemastore.org/launchsettings.json",
    },
    {
      description = "Schema for CMake Presets",
      fileMatch = {
        "CMakePresets.json",
        "CMakeUserPresets.json",
      },
      url = "https://raw.githubusercontent.com/Kitware/CMake/master/Help/manual/presets/schema.json",
    },
    {
      description = "Configuration file as an alternative for configuring your repository in the settings page.",
      fileMatch = {
        ".codeclimate.json",
      },
      url = "https://json.schemastore.org/codeclimate.json",
    },
    {
      description = "LLVM compilation database",
      fileMatch = {
        "compile_commands.json",
      },
      url = "https://json.schemastore.org/compile-commands.json",
    },
    {
      description = "Config file for Command Task Runner",
      fileMatch = {
        "commands.json",
      },
      url = "https://json.schemastore.org/commands.json",
    },
    {
      description = "AWS CloudFormation provides a common language for you to describe and provision all the infrastructure resources in your cloud environment.",
      fileMatch = {
        "*.cf.json",
        "cloudformation.json",
      },
      url = "https://raw.githubusercontent.com/awslabs/goformation/v4.18.2/schema/cloudformation.schema.json",
    },
    {
      description = "The AWS Serverless Application Model (AWS SAM, previously known as Project Flourish) extends AWS CloudFormation to provide a simplified way of defining the Amazon API Gateway APIs, AWS Lambda functions, and Amazon DynamoDB tables needed by your serverless application.",
      fileMatch = {
        "serverless.template",
        "*.sam.json",
        "sam.json",
      },
      url = "https://raw.githubusercontent.com/awslabs/goformation/v4.18.2/schema/sam.schema.json",
    },
    {
      description = "Json schema for properties json file for a GitHub Workflow template",
      fileMatch = {
        ".github/workflow-templates/**.properties.json",
      },
      url = "https://json.schemastore.org/github-workflow-template-properties.json",
    },
    {
      description = "JSON schema for configuring Gitlab CI",
      fileMatch = {
        "*.gitlab-ci.yml",
      },
      url = "https://json.schemastore.org/gitlab-ci.json",
    },
    {
      description = "golangci-lint configuration file",
      fileMatch = {
        ".golangci.toml",
        ".golangci.json",
      },
      url = "https://json.schemastore.org/golangci-lint.json",
    },
    {
      description = "JSON Schema for Grafana 5.x Dashboards",
      url = "https://json.schemastore.org/grafana-dashboard-5.x.json",
    },
    {
      description = "JSON schema for the JSON Feed format",
      fileMatch = {
        "feed.json",
      },
      url = "https://json.schemastore.org/feed.json",
      versions = {
        ["1"] = "https://json.schemastore.org/feed-1.json",
        ["1.1"] = "https://json.schemastore.org/feed.json",
      },
    },
    {
      description = "Packer template JSON configuration",
      fileMatch = {
        "packer.json",
      },
      url = "https://json.schemastore.org/packer.json",
    },
    {
      description = "NPM configuration file",
      fileMatch = {
        "package.json",
      },
      url = "https://json.schemastore.org/package.json",
    },
    {
      description = "Traefik v2 Dynamic Configuration File Provider",
      url = "https://json.schemastore.org/traefik-v2-file-provider.json",
    },
    {
      description = "JSON schema for Visual Studio component configuration files",
      fileMatch = {
        "*.vsconfig",
      },
      url = "https://json.schemastore.org/vsconfig.json",
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
