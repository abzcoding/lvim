if lvim.builtin.dap.active then
  require("user.dev_icons").define_dap_signs()
end
if lvim.use_icons == false and lvim.builtin.custom_web_devicons then
  require("user.dev_icons").set_icon()
end
