local M = {}

M.install = function()
  -- NOTE: if you want to disable the lang server builtin formatter.
  -- here's an example to disable formatting in "tsserver" and "jsonls"
  lvim.lsp.on_attach_callback = function(client, _)
    if client.name == "tsserver" or client.name == "jsonls" then
      client.resolved_capabilities.document_formatting = false
      client.resolved_capabilities.document_range_formatting = false
    end
  end
  -- https://www.lunarvim.org/languages/#multi-languages-per-formatter
  for _, server_name in pairs(lvim.lsp.override) do
    local lsp_installer_servers = require "nvim-lsp-installer.servers"
    local server_available, requested_server = lsp_installer_servers.get_server(server_name)
    if server_available then
      if not requested_server:is_installed() then
        if lvim.lsp.automatic_servers_installation then
          requested_server:install()
        else
          return
        end
      end
    end

    local default_config = {
      on_attach = require("lvim.lsp").common_on_attach,
      on_init = require("lvim.lsp").common_on_init,
      capabilities = require("lvim.lsp").common_capabilities(),
    }

    local status_ok, custom_config = pcall(require, "user/providers/" .. requested_server.name)
    if status_ok then
      local new_config = vim.tbl_deep_extend("force", default_config, custom_config)
      M.generate_filetype(requested_server.name)
      requested_server:setup(new_config)
    else
      requested_server:setup(default_config)
    end
  end
end

M.generate_filetype = function(server_name)
  local filetypes = require("lvim.lsp.utils").get_supported_filetypes(server_name) or {}
  if not filetypes then
    return
  end


  local utils = require "lvim.utils"

  for _, filetype in ipairs(filetypes) do
    local filename = _G.join_paths(lvim.lsp.templates_dir, filetype .. ".lua")
    local setup_cmd = string.format([[require("lvim.lsp.manager").setup(%q)]], server_name)
    if not utils.is_file(filename) then
      utils.write_file(filename, setup_cmd .. "\n", "a")
    end
  end
end

return M
