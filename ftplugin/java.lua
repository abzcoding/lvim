if require("utils").check_lsp_client_active "jdt.ls" then
  return
end

-- find_root looks for parent directories relative to the current buffer containing one of the given arguments.
if vim.fn.has "mac" == 1 then
  WORKSPACE_PATH = "/Users/" .. USER .. "/workspace/"
elseif vim.fn.has "unix" == 1 then
  WORKSPACE_PATH = "/home/" .. USER .. "/workspace/"
else
  print "Unsupported system"
end

JAVA_LS_EXECUTABLE = os.getenv "HOME" .. "/.local/share/lunarvim/lvim/utils/bin/jdtls"

require("jdtls").start_or_attach {
  on_attach = require("lsp").common_on_attach,
  cmd = { JAVA_LS_EXECUTABLE, WORKSPACE_PATH .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t") },
}

vim.api.nvim_set_keymap("n", "<leader>la", ":lua require('jdtls').code_action()<CR>", { noremap = true, silent = true })

vim.cmd "command! -buffer JdtCompile lua require('jdtls').compile()"
vim.cmd "command! -buffer JdtUpdateConfig lua require('jdtls').update_project_config()"
-- vim.cmd "command! -buffer JdtJol lua require('jdtls').jol()"
vim.cmd "command! -buffer JdtBytecode lua require('jdtls').javap()"
-- vim.cmd "command! -buffer JdtJshell lua require('jdtls').jshell()"
