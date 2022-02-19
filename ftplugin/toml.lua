local opts = {}

local servers = require "nvim-lsp-installer.servers"
local server_available, requested_server = servers.get_server "taplo"
if server_available then
  opts.cmd_env = requested_server:get_default_options().cmd_env
end

require("lvim.lsp.manager").setup("taplo", opts)

local whk_status, whk = pcall(require, "which-key")
if not whk_status then
  return
end
whk.register {
  ["<leader>c"] = {
    name = "+crates",
    t = { "<cmd>lua require('crates').toggle()<cr>", "Toggle" },
    r = { "<cmd>lua require('crates').reload()<cr>", "Reload" },
    v = { "<cmd>lua require('crates').show_versions_popup()<cr>", "Show versions" },
    f = { "<cmd>lua require('crates').show_features_popup()<cr>", "Show features" },
    u = { "<cmd>lua require('crates').update_crate()<cr>", "Update crate" },
    a = { "<cmd>lua require('crates').update_all_crates()<cr>", "Update all crates" },
    U = { "<cmd>lua require('crates').upgrade_crate()<cr>", "Upgrade crate" },
    A = { "<cmd>lua require('crates').upgrade_all_crates()<cr>", "Upgrade all crates" },
  },
}
