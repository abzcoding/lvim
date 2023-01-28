local M = {}

local create_aucmd = vim.api.nvim_create_autocmd

M.config = function()
  vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "*",
    callback = function()
      require("user.theme").telescope_theme {}
      if lvim.builtin.dap.active then
        require("user.dev_icons").define_dap_signs()
      end
      if lvim.use_icons == false and lvim.builtin.custom_web_devicons then
        require("user.dev_icons").set_icon()
      end
    end,
  })
  vim.api.nvim_clear_autocmds { pattern = "lir", group = "_filetype_settings" }
  vim.api.nvim_clear_autocmds { pattern = "*", group = "_lvim_colorscheme" }
  vim.api.nvim_create_augroup("_lvim_user", {})
  -- Autocommands
  if lvim.builtin.nonumber_unfocus then
    create_aucmd("WinEnter", { group = "_lvim_user", pattern = "*", command = "set relativenumber number cursorline" })
    create_aucmd(
      "WinLeave",
      { group = "_lvim_user", pattern = "*", command = "set norelativenumber nonumber nocursorline" }
    )
  end

  if lvim.builtin.inlay_hints.active then
    vim.api.nvim_create_augroup("LspAttach_inlayhints", {})
    vim.api.nvim_create_autocmd("LspAttach", {
      group = "LspAttach_inlayhints",
      callback = function(args)
        if not (args.data and args.data.client_id) then
          return
        end

        local bufnr = args.buf
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        require("lsp-inlayhints").on_attach(client, bufnr)
      end,
    })
  end

  -- NOTE: using bigfile.nvim instead of this autocmd

  --   vim.cmd [[
  -- " disable syntax highlighting in big files
  -- function! DisableSyntaxTreesitter()
  --     echo("Big file, disabling syntax, treesitter and folding")
  --     if exists(':TSBufDisable')
  --         exec 'TSBufDisable autotag'
  --         exec 'TSBufDisable highlight'
  --     endif

  --     set foldmethod=manual
  --     syntax clear
  --     syntax off
  --     filetype off
  --     set noundofile
  --     set noswapfile
  --     set noloadplugins
  --     set lazyredraw
  -- endfunction

  -- augroup BigFileDisable
  --     autocmd!
  --     autocmd BufReadPre,FileReadPre * if getfsize(expand("%")) > 1024 * 1024 | exec DisableSyntaxTreesitter() | endif
  -- augroup END
  --   ]]
  create_aucmd("BufWinEnter", {
    group = "_lvim_user",
    pattern = "*.md",
    desc = "beautify markdown",
    callback = function()
      vim.cmd [[set syntax=markdown]]
      require("user.markdown_syn").set_syntax()
    end,
  })

  if lvim.builtin.sql_integration.active then
    -- Add vim-dadbod-completion in sql files
    create_aucmd("FileType", {
      group = "_lvim_user",
      pattern = { "sql", "mysql", "plsql" },
      command = "lua require('cmp').setup.buffer { sources = { { name = 'vim-dadbod-completion' } } }",
    })
  end
  create_aucmd("TextYankPost", {
    group = "_general_settings",
    pattern = "*",
    desc = "Highlight text on yank",
    callback = function()
      require("vim.highlight").on_yank { higroup = "Search", timeout = 40 }
    end,
  })
  create_aucmd("BufWritePre", {
    group = "_lvim_user",
    pattern = { "/tmp/*", "COMMIT_EDITMSG", "MERGE_MSG", "*.tmp", "*.bak" },
    callback = function()
      vim.opt_local.undofile = false
    end,
  })

  create_aucmd("TermOpen", {
    group = "_lvim_user",
    pattern = "term://*",
    command = "lua require('user.keybindings').set_terminal_keymaps()",
  })
  if lvim.builtin.metals.active then
    create_aucmd("Filetype", {
      group = "_lvim_user",
      pattern = { "scala", "sbt" },
      callback = require("user.metals").start,
    })
  end
  create_aucmd("FileType", {
    group = "_lvim_user",
    pattern = "toml",
    command = "lua require('cmp').setup.buffer { sources = { { name = 'crates' } } }",
  })

  local codelens_viewer = "lua require('user.codelens').show_line_sign()"
  local user = vim.env.USER
  if user and user == "abz" then
    create_aucmd("CursorHold", {
      group = "_lvim_user",
      pattern = { "*.rs", "*.go", "*.ts", "*.tsx" },
      command = codelens_viewer,
    })
  end
end

M.make_run = function()
  create_aucmd("FileType", {
    group = "_lvim_user",
    pattern = { "c", "cpp" },
    callback = function()
      vim.keymap.set(
        "n",
        "<leader>m",
        "<cmd>lua require('lvim.core.terminal')._exec_toggle({cmd='make ;read',count=2,direction='float'})<CR>"
      )
      vim.keymap.set(
        "n",
        "<leader>r",
        "<cmd>lua require('lvim.core.terminal')._exec_toggle({cmd='make run;read',count=3,direction='float'})<CR>"
      )
    end,
  })
  create_aucmd("FileType", {
    group = "_lvim_user",
    pattern = "go",
    callback = function()
      vim.keymap.set(
        "n",
        "<leader>m",
        "<cmd>lua require('lvim.core.terminal')._exec_toggle({cmd='go build -v .;read',count=2,direction='float'})<CR>"
      )
      vim.keymap.set(
        "n",
        "<leader>r",
        "<cmd>lua require('lvim.core.terminal')._exec_toggle({cmd='go run .;read',count=3,direction='float'})<CR>"
      )
    end,
  })
  create_aucmd("FileType", {
    group = "_lvim_user",
    pattern = "python",
    callback = function()
      vim.keymap.set(
        "n",
        "<leader>r",
        "<cmd>lua require('lvim.core.terminal')._exec_toggle({cmd='python "
          .. vim.fn.expand "%"
          .. ";read',count=2,direction='float'})<CR>"
      )
      vim.keymap.set(
        "n",
        "<leader>m",
        "<cmd>lua require('lvim.core.terminal')._exec_toggle({cmd='echo \"compile :pepelaugh:\";read',count=2,direction='float'})<cr>"
      )
    end,
  })
  create_aucmd("FileType", {
    group = "_lvim_user",
    pattern = "rust",
    callback = function()
      vim.keymap.set(
        "n",
        "<leader>m",
        "<cmd>lua require('lvim.core.terminal')._exec_toggle({cmd='cargo build;read',count=2,direction='float'})<CR>"
      )
      vim.keymap.set("n", "<leader>r", "<cmd>lua require('rust-tools.runnables').runnables()<CR>")
    end,
  })
end

return M
