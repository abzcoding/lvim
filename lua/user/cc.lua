local M = {}

M.config = function()
  local status_ok, command_center = pcall(require, "command_center")
  if not status_ok then
    return
  end
  -- local noremap = { noremap = true }
  -- local silent_noremap = { noremap = true, silent = true }
  command_center.add({
    { description = "Search within the project (Live grep)", cmd = "Telescope live_grep" },
    { description = "Select entire text", cmd = ':call feedkeys("GVgg")' },
    { description = "Show file browser", cmd = "Telescope file_browser" },
    { description = "Find files", cmd = "lua require('telescope.builtin').find_files()" },
    { description = "Find hidden files", cmd = "Telescope find_files hidden=true" },
    { description = "Find Git files", cmd = "lua require('user.telescope').git_files()" },
    { description = "Show recent files", cmd = "Telescope oldfiles" },
    { description = "Rerun last search", cmd = "lua require('telescope.builtin').resume({cache_index=3})" },
    { description = "Search inside current buffer", cmd = "Telescope current_buffer_fuzzy_find" },
    { description = "Quit", cmd = "qa" },
    { description = "Save all files", cmd = "wa" },
    { description = "Save current file", cmd = "w" },
    { description = "Search word", cmd = "lua require('user.telescope').find_string()" },
    { description = "Format document", cmd = "lua vim.lsp.buf.format()" },
    { description = "Workspace diagnostics", cmd = "Telescope diagnostics" },
    { description = "Workspace symbols", cmd = "Telescope lsp_workspace_symbols" },
    { description = "List projects", cmd = "Telescope projects" },
    { description = "Build project", cmd = "AsyncTask project-build" },
    { description = "Run project", cmd = "AsyncTask project-run" },
    { description = "Show tasks", cmd = "AsyncTaskList" },
    { description = "Show opened buffers", cmd = "Telescope buffers" },
    { description = "Find man pages", cmd = "Telescope man_pages" },
    { description = "Check health", cmd = "checkhealth" },
    { description = "Switch colorschemes", cmd = "Telescope colorscheme" },
    { description = "Command history", cmd = "lua require('telescope.builtin').command_history()" },
    { description = "Show all available commands", cmd = "Telescope commands" },
    { description = "Toggle cursor column", cmd = "set cursorcolumn!" },
    { description = "Toggle cursor line", cmd = "set cursorline!" },
    { description = "Show jumplist", cmd = "Telescope jumplist" },
    { description = "Show workspace git commits", cmd = "Telescope git_commits" },
    { description = "Show all key maps", cmd = "Telescope keymaps" },
    { description = "Toggle paste mode", cmd = "set paste!" },
    { description = "Show registers", cmd = "lua require('telescope.builtin').registers()" },
    { description = "Toggle relative number", cmd = "set relativenumber!" },
    { description = "Reload vimrc", cmd = "source $MYVIMRC" },
    { description = "Toggle search highlighting", cmd = "set hlsearch!" },
    { description = "Show search history", cmd = "lua require('telescope.builtin').search_history()" },
    { description = "Toggle spell checker", cmd = "set spell!" },
    { description = "Edit vim options", cmd = "Telescope vim_options" },
    { description = "Show Cheatsheet", cmd = "help index" },
    { description = "Quick reference", cmd = "help quickref" },
    { description = "Find help documentations", cmd = "lua require('telescope.builtin').help_tags()" },
    { description = "Help summary", cmd = "help summary" },
    { description = "Help tips", cmd = "help tips" },
    { description = "Help tutorial", cmd = "help tutor" },
    { description = "List brakpoints", cmd = "lua require'telescope'.extensions.dap.list_breakpoints{}" },
    { description = "Clear breakpoints", cmd = "lua require('dap.breakpoints').clear()" },
    { description = "Close DAP repl", cmd = "lua require'dap'.close(); require'dap'.repl.close()" },
    { description = "Show DAP commands", cmd = "lua require'telescope'.extensions.dap.commands{}" },
    { description = "Show DAP configurations", cmd = "lua require'telescope'.extensions.dap.configurations{}" },
    { description = "DAP continue", cmd = "lua require'dap'.continue()" },
    { description = "Show DAP frames", cmd = "lua require'telescope'.extensions.dap.frames{}" },
    { description = "DAP pause", cmd = "lua require'dap'.pause()" },
    { description = "DAP repl", cmd = "lua require'dap'.repl.open(); vim.cmd(\"wincmd w|resize 12\")" },
    { description = "DAP run to cursor", cmd = "lua require'dap'.run_to_cursor()" },
    { description = "DAP step back", cmd = "lua require'dap'.step_back()" },
    { description = "DAP step into", cmd = "lua require'dap'.step_into()" },
    { description = "DAP step out", cmd = "lua require'dap'.step_out()" },
    { description = "DAP step over", cmd = "lua require'dap'.step_over()" },
    { description = "DAP toggle breakpoint", cmd = "lua require'dap'.toggle_breakpoint()" },
  }, command_center.mode.ADD_ONLY)
end

return M
