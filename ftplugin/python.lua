lvim.lang.python.formatters = {
  {
    exe = "black",
    args = {},
  },
  {
    exe = "isort",
    args = {},
  },
}

lvim.lang.python.linters = {
  {
    -- can be pylint or flake8
    exe = "",
    args = {},
  },
}

if lvim.builtin.dap.active then
  local dap_install = require "dap-install"
  dap_install.config("python_dbg", {})
end
