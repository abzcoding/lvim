local user_tex = require("user.tex").config()

local opts = {
  setup = user_tex,
  on_attach = require("lvim.lsp").common_on_attach,
  on_init = require("lvim.lsp").common_on_init,
  capabilities = require("lvim.lsp").common_capabilities(),
}

local servers = require "nvim-lsp-installer.servers"
local server_available, requested_server = servers.get_server "texlab"
if server_available then
  opts.cmd_env = requested_server:get_default_options().cmd_env
end

require("lvim.lsp.manager").setup("texlab", opts)
