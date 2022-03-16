-- NOTE: install using `R -e 'install.packages("languageserver",repos = "http://cran.us.r-project.org")'`
local lspconfig = require "lspconfig"
local configs = require "lspconfig/configs"
local servers = require "nvim-lsp-installer.servers"
local server = require "nvim-lsp-installer.server"
local shell = require "nvim-lsp-installer.installers.shell"

local server_name = "r_language_server"

configs[server_name] = {
  default_config = {
    root_dir = function(fname)
      return lspconfig.util.root_pattern ".git"(fname) or lspconfig.util.path.dirname(fname)
    end,
    filetypes = { "r", "rmd" },
    log_level = 2,
  },
}

local root_dir = server.get_server_root_path(server_name)

local my_installer = function(_, callback, _)
  local is_success = shell.cmd 'R -e \'install.packages("languageserver",repos ="http://cran.us.r-project.org")\''
  if is_success then
    callback(true)
  else
    callback(false)
  end
end

local my_server = server.Server:new {
  name = server_name,
  root_dir = root_dir,
  installer = my_installer,
  default_options = {
    cmd = { "R", "--slave", "-e", '"languageserver::run()"' },
  },
}
servers.register(my_server)
require("lvim.lsp.manager").setup(server_name, {})
