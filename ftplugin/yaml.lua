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
          "kubectl-edit*.yaml",
        },
        ["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/master/configmap.json"] = "*onfigma*.{yml,yaml}",
        ["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/master/deployment.json"] = "*eployment*.{yml,yaml}",
        ["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/master/service.json"] = "*ervic*.{yml,yaml}",
        ["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/master/ingress.json"] = "*ngres*.{yml,yaml}",
        ["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/master/secret.json"] = "*ecre*.{yml,yaml}",
      },
    },
  },
}

local servers = require "nvim-lsp-installer.servers"
local server_available, requested_server = servers.get_server "yamlls"
if server_available then
  opts.cmd_env = requested_server:get_default_options().cmd_env
end

require("lvim.lsp.manager").setup("yamlls", opts)
