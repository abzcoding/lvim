if lvim.builtin.dap.active then
  local dap_install = require "dap-install"
  dap_install.config("ccppr_vsc_dbg", {})
end
