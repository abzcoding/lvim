lvim.lang.go.formatters = {
  {
    -- golangci_lint
    exe = "goimports",
    -- args = {},
  },
}

if lvim.builtin.dap.active then
  local dap_install = require "dap-install"
  dap_install.config("go_delve_dbg", {})
end
