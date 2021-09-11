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
      description = "Kubernetes native configuration management",
      fileMatch = {
        "kustomization.yaml",
        "kustomization.yml",
      },
      url = "https://json.schemastore.org/kustomization.json",
    },
    {
      description = "A JSON schema for the ASP.NET LaunchSettings.json files",
      fileMatch = { "launchsettings.json" },
      url = "https://json.schemastore.org/launchsettings.json",
    },
    {
      description = "Ansible role task files",
      url = "https://json.schemastore.org/ansible-role-2.9.json",
      fileMatch = {
        "**/roles/**/tasks/*.yml",
        "**/roles/**/tasks/*.yaml",
      },
      versions = {
        ["2.0"] = "https://json.schemastore.org/ansible-role-2.0.json",
        ["2.1"] = "https://json.schemastore.org/ansible-role-2.1.json",
        ["2.2"] = "https://json.schemastore.org/ansible-role-2.2.json",
        ["2.3"] = "https://json.schemastore.org/ansible-role-2.3.json",
        ["2.4"] = "https://json.schemastore.org/ansible-role-2.4.json",
        ["2.5"] = "https://json.schemastore.org/ansible-role-2.5.json",
        ["2.6"] = "https://json.schemastore.org/ansible-role-2.6.json",
        ["2.7"] = "https://json.schemastore.org/ansible-role-2.7.json",
        ["2.9"] = "https://json.schemastore.org/ansible-role-2.9.json",
      },
    },
    {
      description = "Ansible playbook files",
      url = "https://json.schemastore.org/ansible-playbook.json",
      fileMatch = {
        "playbook.yml",
        "playbook.yaml",
      },
    },
    {
      description = "Ansible inventory files",
      url = "https://json.schemastore.org/ansible-inventory.json",
      fileMatch = {
        "inventory.yml",
        "inventory.yaml",
      },
    },
    {
      description = "Ansible Collection Galaxy metadata",
      url = "https://raw.githubusercontent.com/ansible-community/schemas/main/f/ansible-galaxy.json",
      fileMatch = {
        "galaxy.yml",
      },
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
      description = "The Chart.yaml file is required for a chart.",
      fileMatch = {
        "Chart.yaml",
      },
      url = "https://json.schemastore.org/chart.json",
    },
    {
      description = "The Chart.lock file locks dependencies from Chart.yaml",
      fileMatch = {
        "Chart.lock",
      },
      url = "https://json.schemastore.org/chart-lock.json",
    },
    {
      description = "Schema for CircleCI 2.0 config files",
      fileMatch = {
        ".circleci/config.yml",
      },
      url = "https://json.schemastore.org/circleciconfig.json",
    },
    {
      description = "Configuration file as an alternative for configuring your repository in the settings page.",
      fileMatch = {
        ".codeclimate.yml",
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
        "*.cf.yml",
        "*.cf.yaml",
        "cloudformation.json",
        "cloudformation.yml",
        "cloudformation.yaml",
      },
      url = "https://raw.githubusercontent.com/awslabs/goformation/v4.18.2/schema/cloudformation.schema.json",
    },
    {
      description = "The AWS Serverless Application Model (AWS SAM, previously known as Project Flourish) extends AWS CloudFormation to provide a simplified way of defining the Amazon API Gateway APIs, AWS Lambda functions, and Amazon DynamoDB tables needed by your serverless application.",
      fileMatch = {
        "serverless.template",
        "*.sam.json",
        "*.sam.yml",
        "*.sam.yaml",
        "sam.json",
        "sam.yml",
        "sam.yaml",
      },
      url = "https://raw.githubusercontent.com/awslabs/goformation/v4.18.2/schema/sam.schema.json",
    },
    {
      description = "YAML schema for GitHub Actions",
      fileMatch = {
        "action.yml",
        "action.yaml",
      },
      url = "https://json.schemastore.org/github-action.json",
    },
    {
      description = "YAML schema for GitHub issue forms",
      fileMatch = {
        ".github/ISSUE_TEMPLATE/**.yml",
        ".github/ISSUE_TEMPLATE/**.yaml",
      },
      url = "https://json.schemastore.org/github-issue-forms.json",
    },
    {
      description = "YAML schema for GitHub Workflow",
      fileMatch = {
        ".github/workflows/**.yml",
        ".github/workflows/**.yaml",
      },
      url = "https://json.schemastore.org/github-workflow.json",
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
        ".golangci.yml",
        ".golangci.yaml",
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
      description = "Jenkins X Pipeline YAML configuration files",
      fileMatch = {
        "jenkins-x*.yml",
      },
      url = "https://jenkins-x.io/schemas/jx-schema.json",
    },
    {
      description = "Jenkins X Requirements YAML configuration file",
      fileMatch = {
        "jx-requirements.yml",
      },
      url = "https://jenkins-x.io/schemas/jx-requirements.json",
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
      description = "Semgrep code scanning patterns and rules",
      fileMatch = {
        ".semgrep/**.yaml",
        ".semgrep/**.yml",
        ".semgrep.yaml",
        ".semgrep.yml",
      },
      url = "https://json.schemastore.org/semgrep.json",
    },
    {
      description = "Read the Docs configuration file",
      fileMatch = {
        "readthedocs.yml",
        "readthedocs.yaml",
        ".readthedocs.yml",
        ".readthedocs.yaml",
      },
      url = "https://raw.githubusercontent.com/readthedocs/readthedocs.org/master/readthedocs/rtd_tests/fixtures/spec/v2/schema.json",
    },
    {
      description = "Prometheus configuration file",
      fileMatch = {
        "prometheus.yml",
      },
      url = "https://json.schemastore.org/prometheus.json",
    },
    {
      description = "Prometheus rules file",
      fileMatch = {
        "*.rules",
      },
      url = "https://json.schemastore.org/prometheus.rules.json",
    },
    {
      description = "pre-commit configuration file",
      fileMatch = {
        ".pre-commit-config.yml",
        ".pre-commit-config.yaml",
      },
      url = "https://json.schemastore.org/pre-commit-config.json",
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
      description = "Travis CI configuration file",
      fileMatch = {
        ".travis.yml",
      },
      url = "https://json.schemastore.org/travis.json",
    },
    {
      description = "Traefik v2 YAML configuration file",
      fileMatch = {
        "traefik.yml",
        "traefik.yaml",
      },
      url = "https://json.schemastore.org/traefik-v2.json",
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
    {
      description = "The Compose specification establishes a standard for the definition of multi-container platform-agnostic applications. ",
      fileMatch = {
        "**/docker-compose.yml",
        "**/docker-compose.yaml",
        "**/docker-compose.*.yml",
        "**/docker-compose.*.yaml",
        "**/compose.yml",
        "**/compose.yaml",
        "**/compose.*.yml",
        "**/compose.*.yaml",
      },
      url = "https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json",
    },
    {
      description = "Gradle Enterprise configuration schema",
      fileMatch = {
        "*gradle-enterprise.yml",
        "*gradle-enterprise.yaml",
      },
      url = "https://docs.gradle.com/enterprise/admin/schema/gradle-enterprise-config-schema-2.json",
      versions = {
        ["1.0"] = "https://docs.gradle.com/enterprise/admin/schema/gradle-enterprise-config-schema-1.json",
        ["2.0"] = "https://docs.gradle.com/enterprise/admin/schema/gradle-enterprise-config-schema-2.json",
      },
    },
    {
      description = "Gradle Build Cache Node configuration schema",
      fileMatch = {
        "*build-cache-node-config-schema.yml",
        "*build-cache-node-config-schema.yaml",
      },
      url = "https://docs.gradle.com/build-cache-node/schema/build-cache-node-config-schema-2.json",
      versions = {
        ["1.0"] = "https://docs.gradle.com/build-cache-node/schema/build-cache-node-config-schema-1.json",
        ["2.0"] = "https://docs.gradle.com/build-cache-node/schema/build-cache-node-config-schema-2.json",
      },
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
  lvim.lang.yaml.lsp.setup.settings = {
    yaml = {
      hover = true,
      completion = true,
      validate = true,
      schemaStore = {
        enable = true,
        url = "https://www.schemastore.org/api/json/catalog.json",
      },
      schemas = {
        Kubernetes = {
          "daemon.yaml",
          "manager.yaml",
          "restapi.yaml",
          "role.yaml",
          "role_binding.yaml",
          "*onfigma*.yml",
          "*ngres*.yml",
          "*ecre*.yml",
          "*eployment*.yml",
          "*ervic*.yml",
        },
      },
    },
  }
end

return M
