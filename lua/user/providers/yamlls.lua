local opts = {
  settings = {
    yaml = {
      hover = true,
      completion = true,
      validate = true,
      schemaStore = {
        enable = true,
        url = "https://www.schemastore.org/api/json/catalog.json",
      },
      schemas = {
        kubernetes = {
          "daemon.{yml,yaml}",
          "manager.{yml,yaml}",
          "restapi.{yml,yaml}",
          "role.{yml,yaml}",
          "role_binding.{yml,yaml}",
          "*onfigma*.{yml,yaml}",
          "*ngres*.{yml,yaml}",
          "*ecre*.{yml,yaml}",
          "*eployment*.{yml,yaml}",
          "*ervic*.{yml,yaml}",
          "kubectl-edit*.yaml",
        },
        ["https://json.schemastore.org/ansible-role-2.9.json"] = "tasks/*.{yml,yaml}",
        ["https://json.schemastore.org/ansible-inventory.json"] = {
          "*nventori*/*.yml",
          "staging.yml",
          "production.yml",
        },
        ["https://json.schemastore.org/ansible-playbook.json"] = {
          "playbook.{yml,yaml}",
          "main.yml",
        },
      },
    },
  },
}

return opts
