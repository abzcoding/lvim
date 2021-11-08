local M = {}

M.config = function()
  -- Snippets
  -- =========================================
  require("luasnip/loaders/from_vscode").load { paths = { "~/.config/lvim/snippets" } }

  -- Barbar
  -- =========================================
  if lvim.builtin.fancy_bufferline.active then
    lvim.builtin.bufferline.active = false
  end

  -- CMP
  -- =========================================
  lvim.builtin.cmp.sources = {
    { name = "nvim_lsp" },
    { name = "cmp_tabnine", max_item_count = 3 },
    { name = "buffer", max_item_count = 5, keyword_length = 5 },
    { name = "path", max_item_count = 5 },
    { name = "luasnip", max_item_count = 3 },
    { name = "nvim_lua" },
    { name = "calc" },
    { name = "emoji" },
    { name = "treesitter" },
    { name = "crates" },
    { name = "orgmode" },
  }
  lvim.builtin.cmp.documentation.border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }
  lvim.builtin.cmp.experimental = {
    ghost_text = false,
    native_menu = false,
    custom_menu = true,
  }
  lvim.builtin.cmp.formatting.kind_icons = require("user.lsp_kind").symbols()
  lvim.builtin.cmp.formatting.source_names = {
    buffer = "(Buffer)",
    nvim_lsp = "(LSP)",
    luasnip = "(Snip)",
    treesitter = "",
    nvim_lua = "(NvLua)",
    spell = "暈",
    emoji = "",
    path = "",
    calc = "",
    cmp_tabnine = "ﮧ",
    ["vim-dadbod-completion"] = "𝓐",
  }
  if lvim.builtin.sell_your_soul_to_devil then
    vim.g.copilot_no_tab_map = true
    vim.g.copilot_assume_mapped = true
    vim.g.copilot_tab_fallback = ""
    local cmp = require "cmp"
    lvim.builtin.cmp.mapping["<C-e>"] = function(fallback)
      cmp.mapping.abort()
      local copilot_keys = vim.fn["copilot#Accept"]()
      if copilot_keys ~= "" then
        vim.api.nvim_feedkeys(copilot_keys, "i", true)
      else
        fallback()
      end
    end
  end

  -- Dashboard
  -- =========================================
  lvim.builtin.dashboard.active = not lvim.builtin.fancy_dashboard.active
  if not lvim.builtin.fancy_dashboard.active then
    lvim.builtin.dashboard.custom_section["m"] = {
      description = { "  Marks              " },
      command = "Telescope marks",
    }
  end

  -- LSP
  -- =========================================
  lvim.lsp.diagnostics.signs.values = {
    { name = "LspDiagnosticsSignError", text = " " },
    { name = "LspDiagnosticsSignWarning", text = "" },
    { name = "LspDiagnosticsSignHint", text = "" },
    { name = "LspDiagnosticsSignInformation", text = "" },
  }

  -- Lualine
  -- =========================================
  lvim.builtin.lualine.active = true
  lvim.builtin.lualine.sections.lualine_b = { "branch" }

  -- NvimTree
  -- =========================================
  lvim.builtin.nvimtree.setup.auto_open = 0
  lvim.builtin.nvimtree.setup.diagnostics = {
    enable = true,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  }
  -- lvim.builtin.nvimtree.hide_dotfiles = 0

  -- Project
  -- =========================================
  lvim.builtin.project.active = true

  -- Treesitter
  -- =========================================
  lvim.builtin.treesitter.context_commentstring.enable = true
  lvim.builtin.treesitter.ensure_installed = "maintained"
  lvim.builtin.treesitter.highlight.disable = { "org" }
  lvim.builtin.treesitter.highlight.aditional_vim_regex_highlighting = { "org" }
  lvim.builtin.treesitter.ignore_install = { "haskell" }
  lvim.builtin.treesitter.incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<C-n>",
      node_incremental = "<C-n>",
      scope_incremental = "<C-s>",
      node_decremental = "<C-r>",
    },
  }
  lvim.builtin.treesitter.indent = { enable = true, disable = { "yaml", "python" } } -- treesitter is buggy :(
  lvim.builtin.treesitter.matchup.enable = true
  -- lvim.treesitter.textsubjects.enable = true
  -- lvim.treesitter.playground.enable = true
  lvim.builtin.treesitter.query_linter = {
    enable = true,
    use_virtual_text = true,
    lint_events = { "BufWrite", "CursorHold" },
  }
  lvim.builtin.treesitter.on_config_done = function()
    local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
    parser_config.solidity = {
      install_info = {
        url = "https://github.com/JoranHonig/tree-sitter-solidity",
        files = { "src/parser.c" },
        requires_generate_from_grammar = true,
      },
      filetype = "solidity",
    }
    parser_config.jsonc.used_by = "json"
    parser_config.markdown = {
      install_info = {
        url = "https://github.com/ikatyang/tree-sitter-markdown",
        files = { "src/parser.c", "src/scanner.cc" },
      },
    }
    if lvim.builtin.orgmode.active then
      parser_config.org = {
        install_info = {
          url = "https://github.com/milisims/tree-sitter-org",
          revision = "main",
          files = { "src/parser.c", "src/scanner.cc" },
        },
        filetype = "org",
      }
    end
  end

  -- Telescope
  -- =========================================
  -- lvim.builtin.telescope.defaults.path_display = { "smart", "absolute", "truncate" }
  lvim.builtin.telescope.defaults.path_display = { shorten = 10 }
  lvim.builtin.telescope.defaults.winblend = 6
  lvim.builtin.telescope.defaults.layout_strategy = "horizontal"
  lvim.builtin.telescope.defaults.file_ignore_patterns = {
    "vendor/*",
    "%.lock",
    "__pycache__/*",
    "%.sqlite3",
    "%.ipynb",
    "node_modules/*",
    "%.jpg",
    "%.jpeg",
    "%.png",
    "%.svg",
    "%.otf",
    "%.ttf",
    ".git/",
    "%.webp",
    ".dart_tool/",
    ".github/",
    ".gradle/",
    ".idea/",
    ".settings/",
    ".vscode/",
    "__pycache__/",
    "build/",
    "env/",
    "gradle/",
    "node_modules/",
    "target/",
  }
  lvim.builtin.telescope.defaults.layout_config = require("user.telescope").layout_config()
  lvim.builtin.telescope.defaults.mappings = {
    i = {
      ["<C-c>"] = require("telescope.actions").close,
      ["<C-y>"] = require("telescope.actions").which_key,
    },
  }
  local telescope_actions = require "telescope.actions.set"
  lvim.builtin.telescope.defaults.pickers.find_files = {
    attach_mappings = function(_)
      telescope_actions.select:enhance {
        post = function()
          vim.cmd ":normal! zx"
        end,
      }
      return true
    end,
    find_command = { "fd", "--type=file", "--hidden", "--smart-case" },
  }

  -- Terminal
  -- =========================================
  lvim.builtin.terminal.active = true
  lvim.builtin.terminal.execs = {
    { "lazygit", "gg", "LazyGit" },
  }

  -- WhichKey
  -- =========================================
  lvim.builtin.which_key.setup.window.winblend = 10
  lvim.builtin.which_key.setup.window.border = "none"
  lvim.builtin.which_key.setup.ignore_missing = true
  lvim.builtin.which_key.on_config_done = function(wk)
    local keys = {
      ["ga"] = { "<cmd>lua require('user.telescope').code_actions()<CR>", "Code Action" },
      ["gR"] = { "<cmd>Trouble lsp_references<CR>", "Goto References" },
      ["gI"] = { "<cmd>lua require('user.telescope').lsp_implementations()<CR>", "Goto Implementation" },
    }

    -- better keybindings for ts and tsx files
    local langs = { "typescript", "typescriptreact" }
    local ftype = vim.bo.filetype
    if vim.tbl_contains(langs, ftype) then
      local ts_keys = {
        ["gA"] = { "<cmd>TSLspImportAll<CR>", "Import All" },
        ["gr"] = { "<cmd>TSLspRenameFile<CR>", "Rename File" },
        ["gS"] = { "<cmd>TSLspOrganize<CR>", "Organize Imports" },
      }
      wk.register(ts_keys, { mode = "n" })
    end
    wk.register(keys, { mode = "n" })
  end

  -- ETC
  -- =========================================
  -- override lsp rename handler
  if lvim.builtin.fancy_rename then
    vim.lsp.handlers["textDocument/rename"] = function(err, result)
      if err then
        vim.notify(("Error running lsp query 'rename': " .. err), vim.log.levels.ERROR)
      end
      if result and result.changes then
        local msg = ""
        for f, c in pairs(result.changes) do
          local new = c[1].newText
          msg = msg .. string.format("%d changes -> %s", #c, f:gsub("file://", ""):gsub(vim.fn.getcwd(), ".")) .. "\n"
          msg = msg:sub(1, #msg - 1)
          vim.notify(
            msg,
            vim.log.levels.INFO,
            { title = string.format("Rename: %s -> %s", vim.fn.expand "<cword>", new) }
          )
        end
      end
      vim.lsp.util.apply_workspace_edit(result)
    end
  end

  --   if lvim.builtin.lastplace.active == false then
  --     -- go to last loc when opening a buffer
  --     vim.cmd [[
  --   autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif
  -- ]]
  --   end
end

function M.rename(curr, win)
  local name = vim.trim(vim.fn.getline ".")
  vim.api.nvim_win_close(win, true)
  if #name > 0 and name ~= curr then
    local params = vim.lsp.util.make_position_params()
    params.newName = name
    vim.lsp.buf_request(0, "textDocument/rename", params)
  end
end

function M.lsp_rename()
  local name = vim.fn.expand "<cword>"
  local ok, ts = pcall(require, "nvim-treesitter-playground.hl-info")
  local tshl = ""
  if ok and ts then
    if #ts <= 0 then
      return
    end
    tshl = ts.get_treesitter_hl()
    local ind = tshl[#tshl]:match "^.*()%*%*.*%*%*"
    tshl = tshl[#tshl]:sub(ind + 2, -3)
  end

  local win = require("plenary.popup").create(name, {
    title = "New Name",
    style = "minimal",
    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    relative = "cursor",
    borderhighlight = "FloatBorder",
    titlehighlight = "Title",
    highlight = tshl,
    focusable = true,
    width = 25,
    height = 1,
    line = "cursor+2",
    col = "cursor-1",
  })
  -- Move cursor to the end of the prefix
  vim.cmd "stopinsert"
  vim.cmd "startinsert!"
  vim.cmd [[lua require('cmp').setup.buffer { enabled = false }]]

  local opts = { noremap = false, silent = true }
  vim.api.nvim_buf_set_keymap(0, "i", "<Esc>", "<cmd>stopinsert | q!<CR>", opts)
  vim.api.nvim_buf_set_keymap(0, "n", "<Esc>", "<cmd>stopinsert | q!<CR>", opts)
  vim.api.nvim_buf_set_keymap(
    0,
    "i",
    "<CR>",
    "<cmd>stopinsert | lua require('user.builtin').rename(" .. name .. "," .. win .. ")<CR>",
    opts
  )
  vim.api.nvim_buf_set_keymap(
    0,
    "n",
    "<CR>",
    "<cmd>stopinsert | lua require('user.builtin').rename(" .. name .. "," .. win .. ")<CR>",
    opts
  )
end

return M
