lvim.lang.python.formatters = {
  {
    exe = "black",
    args = { "--fast" },
  },
  {
    exe = "isort",
    args = {
      "--profile",
      "black",
    },
  },
}

if lvim.builtin.dap.active then
  local dap_install = require "dap-install"
  dap_install.config("python", {})
end
