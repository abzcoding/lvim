local M = {}

M.setup = function()
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
          "*onfigma*.yaml",
          "*ngres*.yaml",
          "*ecre*.yaml",
          "*eployment*.yaml",
          "*ervic*.yaml",
          "kubectl-edit*.yaml",
        },
        ["https://json.schemastore.org/ansible-role-2.9.json"] = {
          "tasks/*.yml",
          "tasks/*.yaml",
        },
        ["https://json.schemastore.org/ansible-inventory.json"] = {
          "inventories/*.yml",
          "*nventori*/*.yml",
          "staging.yml",
          "production.yml",
        },
        ["https://json.schemastore.org/ansible-playbook.json"] = {
          "playbook.yml",
          "playbook.yaml",
          "main.yml",
        },
      },
    },
  }
end

return M
