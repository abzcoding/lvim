local M = {}

M.config = function()
  local status_ok, metals = pcall(require, "metals")
  if not status_ok then
    return
  end

  local metals_config = metals.bare_config()

  metals_config.settings = {
    showImplicitArguments = true,
    showInferredType = true,
    excludedPackages = {
      "akka.actor.typed.javadsl",
      "com.github.swagger.akka.javadsl",
      "akka.stream.javadsl",
    },
    fallbackScalaVersion = lvim.builtin.metals.fallbackScalaVersion,
    serverVersion = lvim.builtin.metals.serverVersion,
    serverProperties = {
      "-Xms750m",
      "-Xmx5G",
    },
  }

  metals_config.init_options.statusBarProvider = "on"
  metals_config.capabilities = require("lvim.lsp").common_capabilities()
  metals_config.on_attach = require("lvim.lsp").common_on_attach()
  metals.initialize_or_attach(metals_config)
end

return M
