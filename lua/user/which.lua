local M = {}

M.config = function()
  local status_ok, wk = pcall(require, "which-key")
  if not status_ok then
    return
  end

  wk.setup(lvim.builtin.which_key.setup)

  local opts = lvim.builtin.which_key.opts
  local vopts = lvim.builtin.which_key.vopts

  local mappings = lvim.builtin.which_key.mappings
  local vmappings = lvim.builtin.which_key.vmappings

  wk.register(mappings, opts)
  wk.register(vmappings, vopts)
end

return M
