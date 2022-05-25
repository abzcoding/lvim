local M = {}

M.config = function()
  local status_ok, command_center = pcall(require, "command_center")
  if not status_ok then
    return
  end
  -- local noremap = { noremap = true }
  -- local silent_noremap = { noremap = true, silent = true }
  command_center.add({
    { description = "Search within the project (Live grep)", cmd = "<CMD>Telescope live_grep<CR>" },
    { description = "Select entire text", cmd = "<CMD>call feedkeys('GVgg')<CR>" },
    { description = "Show file browser", cmd = "<CMD>Telescope file_browser<CR>" },
    { description = "Find files", cmd = "<CMD>lua require('telescope.builtin').find_files()<CR>" },
    { description = "Find hidden files", cmd = "<CMD>Telescope find_files hidden=true<CR>" },
    { description = "Find Git files", cmd = "<CMD>lua require('user.telescope').git_files()<CR>" },
    { description = "Show recent files", cmd = "<CMD>Telescope oldfiles<CR>" },
    { description = "Rerun last search", cmd = "<CMD>lua require('telescope.builtin').resume({cache_index=3})<CR>" },
    { description = "Search inside current buffer", cmd = "<CMD>Telescope current_buffer_fuzzy_find<CR>" },
    { description = "Quit", cmd = "<CMD>qa<CR>" },
    { description = "Save all files", cmd = "<CMD>wa<CR>" },
    { description = "Save current file", cmd = "<CMD>w<CR>" },
    { description = "Search word", cmd = "<CMD>lua require('user.telescope').find_string()<CR>" },
    { description = "Format document", cmd = "<CMD>lua vim.lsp.buf.format()<CR>" },
    { description = "Workspace diagnostics", cmd = "<CMD>Telescope diagnostics<CR>" },
    { description = "Workspace symbols", cmd = "<CMD>Telescope lsp_workspace_symbols<CR>" },
    { description = "List projects", cmd = "<CMD>Telescope projects<CR>" },
    { description = "Build project", cmd = "<CMD>AsyncTask project-build<CR>" },
    { description = "Run project", cmd = "<CMD>AsyncTask project-run<CR>" },
    { description = "Show tasks", cmd = "<CMD>AsyncTaskList<CR>" },
    { description = "Show opened buffers", cmd = "<CMD>Telescope buffers<CR>" },
    { description = "Find man pages", cmd = "<CMD>Telescope man_pages<CR>" },
    { description = "Check health", cmd = "<CMD>checkhealth<CR>" },
    { description = "Switch colorschemes", cmd = "<CMD>Telescope colorscheme<CR>" },
    { description = "Command history", cmd = "<CMD>lua require('telescope.builtin').command_history()<CR>" },
    { description = "Show all available commands", cmd = "<CMD>Telescope commands<CR>" },
    { description = "Toggle cursor column", cmd = "<CMD>set cursorcolumn!<CR>" },
    { description = "Toggle cursor line", cmd = "<CMD>set cursorline!<CR>" },
    { description = "Show jumplist", cmd = "<CMD>Telescope jumplist<CR>" },
    { description = "Show workspace git commits", cmd = "<CMD>Telescope git_commits<CR>" },
    { description = "Show all key maps", cmd = "<CMD>Telescope keymaps<CR>" },
    { description = "Toggle paste mode", cmd = "<CMD>set paste!<CR>" },
    { description = "Show registers", cmd = "<CMD>lua require('telescope.builtin').registers()<CR>" },
    { description = "Toggle relative number", cmd = "<CMD>set relativenumber!<CR>" },
    { description = "Reload vimrc", cmd = "<CMD>source $MYVIMRC<CR>" },
    { description = "Toggle search highlighting", cmd = "<CMD>set hlsearch!<CR>" },
    { description = "Show search history", cmd = "<CMD>lua require('telescope.builtin').search_history()<CR>" },
    { description = "Toggle spell checker", cmd = "<CMD>set spell!<CR>" },
    { description = "Edit vim options", cmd = "<CMD>Telescope vim_options<CR>" },
    { description = "Show Cheatsheet", cmd = "<CMD>help index<CR>" },
    { description = "Quick reference", cmd = "<CMD>help quickref<CR>" },
    { description = "Find help documentations", cmd = "<CMD>lua require('telescope.builtin').help_tags()<CR>" },
    { description = "Help summary", cmd = "<CMD>help summary<CR>" },
    { description = "Help tips", cmd = "<CMD>help tips<CR>" },
    { description = "Help tutorial", cmd = "<CMD>help tutor<CR>" },
    { description = "List brakpoints", cmd = "<CMD>lua require'telescope'.extensions.dap.list_breakpoints{}<CR>" },
    { description = "Clear breakpoints", cmd = "<CMD>lua require('dap.breakpoints').clear()<CR>" },
    { description = "Close DAP repl", cmd = "<CMD>lua require'dap'.close(); require'dap'.repl.close()<CR>" },
    { description = "Show DAP commands", cmd = "<CMD>lua require'telescope'.extensions.dap.commands{}<CR>" },
    {
      description = "Show DAP configurations",
      cmd = "<CMD>lua require'telescope'.extensions.dap.configurations{}<CR>",
    },
    { description = "DAP continue", cmd = "<CMD>lua require'dap'.continue()<CR>" },
    { description = "Show DAP frames", cmd = "<CMD>lua require'telescope'.extensions.dap.frames{}<CR>" },
    { description = "DAP pause", cmd = "<CMD>lua require'dap'.pause()<CR>" },
    { description = "DAP repl", cmd = "<CMD>lua require'dap'.repl.open(); vim.cmd(\"wincmd w|resize 12\")<CR>" },
    { description = "DAP run to cursor", cmd = "<CMD>lua require'dap'.run_to_cursor()<CR>" },
    { description = "DAP step back", cmd = "<CMD>lua require'dap'.step_back()<CR>" },
    { description = "DAP step into", cmd = "<CMD>lua require'dap'.step_into()<CR>" },
    { description = "DAP step out", cmd = "<CMD>lua require'dap'.step_out()<CR>" },
    { description = "DAP step over", cmd = "<CMD>lua require'dap'.step_over()<CR>" },
    { description = "DAP toggle breakpoint", cmd = "<CMD>lua require'dap'.toggle_breakpoint()<CR>" },
  }, command_center.mode.ADD_ONLY)
end

return M
