local M = {}

M.config = function()
  local status_ok, command_center = pcall(require, "command_center")
  if not status_ok then
    return
  end
  -- local noremap = { noremap = true }
  -- local silent_noremap = { noremap = true, silent = true }
  command_center.add({
    { description = "Search within the project (Live grep)", command = "Telescope live_grep" },
    { description = "Select entire text", command = ':call feedkeys("GVgg")' },
    { description = "Show file browser", command = "Telescope file_browser" },
    { description = "Find files", command = "lua require('telescope.builtin').find_files()" },
    { description = "Find hidden files", command = "Telescope find_files hidden=true" },
    { description = "Find Git files", command = "lua require('user.telescope').git_files()" },
    { description = "Show recent files", command = "Telescope oldfiles" },
    { description = "Rerun last search", command = "lua require('telescope.builtin').resume({cache_index=3})" },
    { description = "Search inside current buffer", command = "Telescope current_buffer_fuzzy_find" },
    { description = "Quit", command = "qa" },
    { description = "Save all files", command = "wa" },
    { description = "Save current file", command = "w" },
    { description = "Search word", command = "lua require('user.telescope').find_string()" },
    { description = "Format document", command = "lua vim.lsp.buf.formatting_seq_sync()" },
    { description = "Workspace diagnostics", command = "Telescope diagnostics" },
    { description = "Workspace symbols", command = "Telescope lsp_workspace_symbols" },
    { description = "List projects", command = "Telescope projects" },
    { description = "Build project", command = "AsyncTask project-build" },
    { description = "Run project", command = "AsyncTask project-run" },
    { description = "Show tasks", command = "AsyncTaskList" },
    { description = "Show opened buffers", command = "Telescope buffers" },
    { description = "Find man pages", command = "Telescope man_pages" },
    { description = "Check health", command = "checkhealth" },
    { description = "Switch colorschemes", command = "Telescope colorscheme" },
    { description = "Command history", command = "lua require('telescope.builtin').command_history()" },
    { description = "Show all available commands", command = "Telescope commands" },
    { description = "Toggle cursor column", command = "set cursorcolumn!" },
    { description = "Toggle cursor line", command = "set cursorline!" },
    { description = "Show jumplist", command = "Telescope jumplist" },
    { description = "Show workspace git commits", command = "Telescope git_commits" },
    { description = "Show all key maps", command = "Telescope keymaps" },
    { description = "Toggle paste mode", command = "set paste!" },
    { description = "Show registers", command = "lua require('telescope.builtin').registers()" },
    { description = "Toggle relative number", command = "set relativenumber!" },
    { description = "Reload vimrc", command = "source $MYVIMRC" },
    { description = "Toggle search highlighting", command = "set hlsearch!" },
    { description = "Show search history", command = "lua require('telescope.builtin').search_history()" },
    { description = "Toggle spell checker", command = "set spell!" },
    { description = "Edit vim options", command = "Telescope vim_options" },
    { description = "Show Cheatsheet", command = "help index" },
    { description = "Quick reference", command = "help quickref" },
    { description = "Find help documentations", command = "lua require('telescope.builtin').help_tags()" },
    { description = "Help summary", command = "help summary" },
    { description = "Help tips", command = "help tips" },
    { description = "Help tutorial", command = "help tutor" },
    { description = "List brakpoints", command = "lua require'telescope'.extensions.dap.list_breakpoints{}" },
    { description = "Clear breakpoints", command = "lua require('dap.breakpoints').clear()" },
    { description = "Close DAP repl", command = "lua require'dap'.close(); require'dap'.repl.close()" },
    { description = "Show DAP commands", command = "lua require'telescope'.extensions.dap.commands{}" },
    { description = "Show DAP configurations", command = "lua require'telescope'.extensions.dap.configurations{}" },
    { description = "DAP continue", command = "lua require'dap'.continue()" },
    { description = "Show DAP frames", command = "lua require'telescope'.extensions.dap.frames{}" },
    { description = "DAP pause", command = "lua require'dap'.pause()" },
    { description = "DAP repl", command = "lua require'dap'.repl.open(); vim.cmd(\"wincmd w|resize 12\")" },
    { description = "DAP run to cursor", command = "lua require'dap'.run_to_cursor()" },
    { description = "DAP step back", command = "lua require'dap'.step_back()" },
    { description = "DAP step into", command = "lua require'dap'.step_into()" },
    { description = "DAP step out", command = "lua require'dap'.step_out()" },
    { description = "DAP step over", command = "lua require'dap'.step_over()" },
    { description = "DAP toggle breakpoint", command = "lua require'dap'.toggle_breakpoint()" },
  }, command_center.mode.ADD_ONLY)
end

return M
