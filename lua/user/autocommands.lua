local M = {}

M.config = function()
  -- Autocommands
  lvim.autocommands.custom_groups = {
    -- c, cpp
    { "Filetype", "c,cpp", "nnoremap <leader>m <cmd>lua require('core.terminal')._exec_toggle('make ;read')<CR>" },
    -- { "Filetype", "c,cpp", "nnoremap <leader>m <cmd>lua require('toggleterm.terminal').Terminal:new {cmd='make;read', hidden =false, on_stdout = on_stdout, on_stderr = on_stdout, on_exit = function() on_exit(on_build_done) end}:toggle()<CR>"},
    { "Filetype", "c,cpp", "nnoremap <leader>r <cmd>lua require('core.terminal')._exec_toggle('make run;read')<CR>" },
    {
      "Filetype",
      "c,cpp",
      "nnoremap <leader>t <cmd>lua require('toggleterm.terminal').Terminal:new {cmd='make test;read', hidden =false}:toggle()<CR>",
    },
    { "Filetype", "cpp", "nnoremap <leader>H <Cmd>ClangdSwitchSourceHeader<CR>" },

    -- rust
    { "Filetype", "rust", "nnoremap <leader>m <cmd>lua require('core.terminal')._exec_toggle('cargo build;read')<CR>" },
    { "Filetype", "rust", "nnoremap <leader>r <cmd>lua require('core.terminal')._exec_toggle('cargo run;read')<CR>" },
    {
      "Filetype",
      "rust",
      "nnoremap <leader>t <cmd>lua require('toggleterm.terminal').Terminal:new {cmd='cargo test -- --ignored;read', hidden =false}:toggle()<CR>",
    },
    { "Filetype", "rust", "nnoremap <leader>H <cmd>lua require('core.terminal')._exec_toggle('cargo clippy;read')<CR>" },
    { "Filetype", "rust", "nnoremap <leader>lm <Cmd>RustExpandMacro<CR>" },
    { "Filetype", "rust", "nnoremap <leader>lH <Cmd>RustToggleInlayHints<CR>" },
    { "Filetype", "rust", "nnoremap <leader>le <Cmd>RustRunnables<CR>" },
    { "Filetype", "rust", "nnoremap <leader>lh <Cmd>RustHoverActions<CR>" },

    -- python
    {
      "Filetype",
      "python",
      "nnoremap <leader>r <cmd>lua require('core.terminal')._exec_toggle('python " .. vim.fn.expand "%" .. ";read')<CR>",
    },
    {
      "Filetype",
      "python",
      "nnoremap <leader>t <cmd>lua require('toggleterm.terminal').Terminal:new {cmd='python -m test -j0;read', hidden =false}:toggle()<CR>",
    },
    {
      "Filetype",
      "python",
      "nnoremap <leader>m <cmd>lua require('core.terminal')._exec_toggle('echo \"compile :pepelaugh:\";read')<CR>",
    },
  }
  -- vim.g.compiler_gcc_ignore_unmatched_lines = true
  -- vim.g.compiler_clang_ignore_unmatched_lines = true
  -- quickfix_entries = {}
  -- function on_stdout(_, data, _)
  -- 	for _, s in ipairs(data) do
  -- 		local vals = {}
  -- 		for str in string.gmatch(s, "([^:]+)") do
  -- 			table.insert(vals, str)
  -- 		end
  -- 		table.insert(quickfix_entries, s)
  -- 	end
  -- end
  --
  -- -- local efm
  -- function on_exit(on_build_done)
  -- 	local efm = '%f:%l:%c: %t%s: %m,%-G%.%#,'-- .. vim.api.nvim_get_option("errorformat") .. ""
  -- 	vim.fn.setqflist({}, " ", {
  -- 		lines = quickfix_entries,
  -- 		efm = efm,
  -- 	})
  -- 	local qfs = vim.fn.getqflist()
  -- 	if #qfs > 0 then
  -- 		vim.cmd("copen")
  -- 		-- vim.cmd("cnext")
  -- 	end
  --
  -- 	if on_build_done then
  -- 		local found_error = false
  -- 		for _, s in ipairs(qfs) do
  -- 			if s.type == "e" then
  -- 				found_error = true
  -- 				break
  -- 			end
  -- 		end
  -- 		on_build_done(found_error)
  -- 	end
  -- end
  --
  -- on_build_done = function(failure)
  -- 	-- vim.cmd[[cclose]]
  -- end
end

return M
