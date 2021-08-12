lvim.lang.python.formatters = {
  {
    exe = "black",
    -- args = {},
  },
  {
    exe = "isort",
    -- args = {},
  },
}

if lvim.builtin.dap.active then
  local dap_install = require "dap-install"
  dap_install.config("python_dbg", {})
end
