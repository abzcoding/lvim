local status_ok, jdtls = pcall(require, "jdtls")
if not status_ok then
  return
end

local workspace_path = os.getenv "HOME" .. "/workspace/"
local JAVA_LS_EXECUTABLE = os.getenv "HOME" .. "/.local/share/lunarvim/lvim/utils/bin/jdtls"

jdtls.start_or_attach {
  on_attach = require("lsp").common_on_attach,
  cmd = { JAVA_LS_EXECUTABLE, workspace_path .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t") },
}

vim.api.nvim_set_keymap("n", "<leader>la", ":lua require('jdtls').code_action()<CR>", { noremap = true, silent = true })

vim.cmd "command! -buffer JdtCompile lua require('jdtls').compile()"
vim.cmd "command! -buffer JdtUpdateConfig lua require('jdtls').update_project_config()"
-- vim.cmd "command! -buffer JdtJol lua require('jdtls').jol()"
vim.cmd "command! -buffer JdtBytecode lua require('jdtls').javap()"
-- vim.cmd "command! -buffer JdtJshell lua require('jdtls').jshell()"
