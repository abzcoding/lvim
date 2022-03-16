local opts = {
  root_dir = function(fname)
    return require("lspconfig").util.root_pattern ".git"(fname) or require("lspconfig").util.path.dirname(fname)
  end,
}

local servers = require "nvim-lsp-installer.servers"
local server_available, requested_server = servers.get_server "dockerls"
if server_available then
  opts.cmd_env = requested_server:get_default_options().cmd_env
end

require("lvim.lsp.manager").setup("dockerls", opts)
