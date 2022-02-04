local status_ok, jdtls = pcall(require, "jdtls")
if not status_ok then
  return
end

local workspace_path = os.getenv "HOME" .. "/workspace/"
local JAVA_LS_EXECUTABLE = os.getenv "HOME" .. "/.local/share/lunarvim/lvim/utils/bin/jdtls"

jdtls.start_or_attach {
  on_attach = function()
    require("jdtls.setup").add_commands()
    require("lvim.lsp").common_on_attach()
  end,
  flags = {
    allow_incremental_sync = true,
    server_side_fuzzy_completion = true,
  },
  settings = {
    ["java.format.settings.url"] = vim.fn.expand "~/" .. ".config/lvim/.java-google-formatter.xml",
    ["java.format.settings.profile"] = "GoogleStyle",
  },
  cmd = { JAVA_LS_EXECUTABLE, workspace_path .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t") },
}
