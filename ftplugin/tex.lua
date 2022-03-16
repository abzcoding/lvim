local user_tex = require("user.tex").config()

local opts = {
  setup = user_tex,
}

local servers = require "nvim-lsp-installer.servers"
local server_available, requested_server = servers.get_server "texlab"
if server_available then
  opts.cmd_env = requested_server:get_default_options().cmd_env
end

require("lvim.lsp.manager").setup("texlab", opts)
