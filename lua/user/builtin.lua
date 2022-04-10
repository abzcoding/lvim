local M = {}

M.config = function()
  local kind = require "user.lsp_kind"
  -- Snippets
  -- =========================================
  require("luasnip/loaders/from_vscode").load { paths = { "~/.config/lvim/snippets" } }

  -- Autopairs
  -- =========================================
  -- lvim.builtin.autopairs.on_config_done = function(autopairs)
  --   local Rule = require "nvim-autopairs.rule"
  --   autopairs.add_rule(Rule("$$", "$$", "tex"))
  -- end

  -- Command Palette
  -- =========================================
  lvim.builtin.cpmenu = M.cpmenu()

  -- Bufferline
  -- =========================================
  local List = require "plenary.collections.py_list"
  local g_ok, bufferline_groups = pcall(require, "bufferline.groups")
  if not g_ok then
    bufferline_groups = { builtin = { ungroupued = { name = "ungrouped" } } }
  end
  lvim.builtin.bufferline.options.diagnostics = false -- do not show diagnostics in bufferline
  lvim.builtin.bufferline.options.diagnostics_indicator = function(_, _, diagnostics)
    local result = {}
    local symbols = { error = kind.icons.error, warning = kind.icons.warn, info = kind.icons.info }
    for name, count in pairs(diagnostics) do
      if symbols[name] and count > 0 then
        table.insert(result, symbols[name] .. count)
      end
    end
    result = table.concat(result, " ")
    return #result > 0 and result or ""
  end
  lvim.builtin.bufferline.options.mode = "buffers"
  lvim.builtin.bufferline.options.sort_by = "insert_after_current"
  lvim.builtin.bufferline.options.groups = {
    options = {
      toggle_hidden_on_enter = true,
    },
    items = {
      bufferline_groups.builtin.ungrouped,
      {
        highlight = { guisp = "#51AFEF" },
        name = "tests",
        icon = kind.icons.test,
        matcher = function(buf)
          return buf.filename:match "_spec" or buf.filename:match "test"
        end,
      },
      {
        name = "view models",
        highlight = { guisp = "#03589C" },
        matcher = function(buf)
          return buf.filename:match "view_model%.dart"
        end,
      },
      {
        name = "screens",
        icon = kind.icons.screen,
        matcher = function(buf)
          return buf.path:match "screen"
        end,
      },
      {
        highlight = { guisp = "#C678DD" },
        name = "docs",
        matcher = function(buf)
          local list = List { "md", "org", "norg", "wiki" }
          return list:contains(vim.fn.fnamemodify(buf.path, ":e"))
        end,
      },
      {
        highlight = { guisp = "#F6A878" },
        name = "config",
        matcher = function(buf)
          return buf.filename:match "go.mod"
            or buf.filename:match "go.sum"
            or buf.filename:match "Cargo.toml"
            or buf.filename:match "manage.py"
            or buf.filename:match "Makefile"
        end,
      },
    },
  }
  lvim.builtin.bufferline.options.separator_style = os.getenv "KITTY_WINDOW_ID" and "slant" or "thin"

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
  local border = {
    { "╭", "CmpBorder" },
    { "─", "CmpBorder" },
    { "╮", "CmpBorder" },
    { "│", "CmpBorder" },
    { "╯", "CmpBorder" },
    { "─", "CmpBorder" },
    { "╰", "CmpBorder" },
    { "│", "CmpBorder" },
  }
  lvim.builtin.cmp.documentation.border = border
  lvim.builtin.cmp.documentation.scrollbar = "║"
  lvim.builtin.cmp.window = { border = border, scrollbar = "║" }
  lvim.builtin.cmp.experimental = {
    ghost_text = false,
    native_menu = false,
    custom_menu = true,
  }
  lvim.builtin.cmp.formatting.kind_icons = kind.cmp_kind
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
    lvim.keys.insert_mode["<c-h>"] = { [[copilot#Accept("\<CR>")]], { expr = true, script = true } }
    lvim.keys.insert_mode["<M-]>"] = { "<Plug>(copilot-next)", { silent = true } }
    lvim.keys.insert_mode["<M-[>"] = { "<Plug>(copilot-previous)", { silent = true } }
    lvim.keys.insert_mode["<M-\\>"] = { "<Cmd>vertical Copilot panel<CR>", { silent = true } }
    local cmp = require "cmp"
    lvim.builtin.cmp.mapping["<Tab>"] = cmp.mapping(M.tab, { "i", "c" })
    lvim.builtin.cmp.mapping["<S-Tab>"] = cmp.mapping(M.shift_tab, { "i", "c" })
  end

  -- Comment
  -- =========================================
  -- integrate with nvim-ts-context-commentstring
  lvim.builtin.comment.pre_hook = function(ctx)
    if not vim.tbl_contains({ "typescript", "typescriptreact" }, vim.bo.ft) then
      return
    end

    local comment_utils = require "Comment.utils"
    local type = ctx.ctype == comment_utils.ctype.line and "__default" or "__multiline"

    local location
    if ctx.ctype == comment_utils.ctype.block then
      location = require("ts_context_commentstring.utils").get_cursor_location()
    elseif ctx.cmotion == comment_utils.cmotion.v or ctx.cmotion == comment_utils.cmotion.V then
      location = require("ts_context_commentstring.utils").get_visual_start_location()
    end

    return require("ts_context_commentstring.internal").calculate_commentstring {
      key = type,
      location = location,
    }
  end

  -- Dashboard
  -- =========================================
  lvim.builtin.alpha.mode = "custom"
  local alpha_opts = require("user.dashboard").config()
  lvim.builtin.alpha["custom"] = { config = alpha_opts }

  -- LSP
  -- =========================================
  lvim.lsp.buffer_mappings.normal_mode["ga"] = {
    "<cmd>lua require('user.telescope').code_actions()<CR>",
    "Code Action",
  }
  lvim.lsp.buffer_mappings.normal_mode["gI"] = {
    "<cmd>lua require('user.telescope').lsp_implementations()<CR>",
    "Goto Implementation",
  }
  lvim.lsp.buffer_mappings.normal_mode["gA"] = { "<cmd>lua vim.lsp.codelens.run()<CR>", "CodeLens Action" }
  lvim.lsp.buffer_mappings.normal_mode["gt"] = { "<cmd>lua vim.lsp.buf.type_definition()<CR>", "Goto Type Definition" }
  lvim.lsp.buffer_mappings.normal_mode["K"] = {
    "<cmd>lua require('user.builtin').show_documentation()<CR>",
    "Show Documentation",
  }
  lvim.lsp.float.border = {
    { "╔", "FloatBorder" },
    { "═", "FloatBorder" },
    { "╗", "FloatBorder" },
    { "║", "FloatBorder" },
    { "╝", "FloatBorder" },
    { "═", "FloatBorder" },
    { "╚", "FloatBorder" },
    { "║", "FloatBorder" },
  }
  lvim.lsp.diagnostics.float.border = {
    { " ", "FloatBorder" },
    { " ", "FloatBorder" },
    { " ", "FloatBorder" },
    { " ", "FloatBorder" },
    { " ", "FloatBorder" },
    { " ", "FloatBorder" },
    { " ", "FloatBorder" },
    { " ", "FloatBorder" },
  }
  if os.getenv "KITTY_WINDOW_ID" then
    lvim.lsp.float.border = {
      { "🭽", "FloatBorder" },
      { "▔", "FloatBorder" },
      { "🭾", "FloatBorder" },
      { "▕", "FloatBorder" },
      { "🭿", "FloatBorder" },
      { "▁", "FloatBorder" },
      { "🭼", "FloatBorder" },
      { "▏", "FloatBorder" },
    }
    lvim.lsp.diagnostics.float.border = lvim.lsp.float.border
  end
  lvim.lsp.diagnostics.float.focusable = false
  lvim.lsp.float.focusable = true
  lvim.lsp.diagnostics.signs.values = {
    { name = "DiagnosticSignError", text = kind.icons.error },
    { name = "DiagnosticSignWarn", text = kind.icons.warn },
    { name = "DiagnosticSignInfo", text = kind.icons.info },
    { name = "DiagnosticSignHint", text = kind.icons.hint },
  }
  lvim.lsp.diagnostics.float.source = "if_many"
  lvim.lsp.diagnostics.float.format = function(d)
    local t = vim.deepcopy(d)
    local code = d.code or (d.user_data and d.user_data.lsp.code)
    for _, table in pairs(M.codes) do
      if vim.tbl_contains(table, code) then
        return table.message
      end
    end
    return t.message
  end

  -- Lualine
  -- =========================================
  lvim.builtin.lualine.active = true
  lvim.builtin.lualine.sections.lualine_b = { "branch" }

  -- NvimTree
  -- =========================================
  lvim.builtin.nvimtree.setup.diagnostics = {
    enable = true,
    icons = {
      hint = kind.icons.hint,
      info = kind.icons.info,
      warning = kind.icons.warn,
      error = kind.icons.error,
    },
  }
  lvim.builtin.nvimtree.icons = kind.nvim_tree_icons
  lvim.builtin.nvimtree.on_config_done = function(_)
    lvim.builtin.which_key.mappings["e"] = { "<cmd>NvimTreeToggle<CR>", " Explorer" }
  end
  -- lvim.builtin.nvimtree.hide_dotfiles = 0

  -- Project
  -- =========================================
  lvim.builtin.project.active = true
  lvim.builtin.project.detection_methods = { "lsp", "pattern" }

  -- Treesitter
  -- =========================================
  lvim.builtin.treesitter.context_commentstring.enable = true
  lvim.builtin.treesitter.ensure_installed = "maintained"
  lvim.builtin.treesitter.highlight.disable = { "org" }
  lvim.builtin.treesitter.highlight.aditional_vim_regex_highlighting = { "org" }
  lvim.builtin.treesitter.ignore_install = { "haskell", "norg" }
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
  lvim.builtin.treesitter.textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["al"] = "@loop.outer",
        ["il"] = "@loop.inner",
        ["aa"] = "@parameter.outer",
        ["ia"] = "@parameter.inner",
        ["av"] = "@variable.outer",
        ["iv"] = "@variable.inner",
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ["<leader><M-a>"] = "@parameter.inner",
        ["<leader><M-f>"] = "@function.outer",
        ["<leader><M-e>"] = "@element",
      },
      swap_previous = {
        ["<leader><M-A>"] = "@parameter.inner",
        ["<leader><M-F>"] = "@function.outer",
        ["<leader><M-E>"] = "@element",
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]p"] = "@parameter.inner",
        ["]f"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_next_end = {
        ["]F"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[p"] = "@parameter.inner",
        ["[f"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[F"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
    },
  }

  -- Telescope
  -- =========================================
  -- lvim.builtin.telescope.defaults.path_display = { "smart", "absolute", "truncate" }
  lvim.builtin.telescope.defaults.path_display = { shorten = 10 }
  lvim.builtin.telescope.defaults.prompt_prefix = "  "
  lvim.builtin.telescope.defaults.borderchars = {
    prompt = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    results = { "─", "▐", "─", "│", "╭", "▐", "▐", "╰" },
    -- results = {' ', '▐', '▄', '▌', '▌', '▐', '▟', '▙' };
    preview = { " ", "│", " ", "▌", "▌", "╮", "╯", "▌" },
  }
  lvim.builtin.telescope.defaults.selection_caret = "  "
  lvim.builtin.telescope.defaults.cache_picker = { num_pickers = 3 }
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
    "%.pdb",
    "%.dll",
    "%.class",
    "%.exe",
    "%.cache",
    "%.ico",
    "%.pdf",
    "%.dylib",
    "%.jar",
    "%.docx",
    "%.met",
    "smalljre_*/*",
    ".vale/",
    "%.burp",
    "%.mp4",
    "%.mkv",
    "%.rar",
    "%.zip",
    "%.7z",
    "%.tar",
    "%.bz2",
    "%.epub",
    "%.flac",
    "%.tar.gz",
  }
  local user_telescope = require "user.telescope"
  lvim.builtin.telescope.defaults.layout_config = user_telescope.layout_config()
  local actions = require "telescope.actions"
  lvim.builtin.telescope.defaults.mappings = {
    i = {
      ["<c-c>"] = require("telescope.actions").close,
      ["<c-y>"] = require("telescope.actions").which_key,
      ["<tab>"] = actions.toggle_selection + actions.move_selection_next,
      ["<s-tab>"] = actions.toggle_selection + actions.move_selection_previous,
      ["<cr>"] = user_telescope.multi_selection_open,
      ["<c-v>"] = user_telescope.multi_selection_open_vsplit,
      ["<c-s>"] = user_telescope.multi_selection_open_split,
      ["<c-t>"] = user_telescope.multi_selection_open_tab,
      ["<c-j>"] = actions.move_selection_next,
      ["<c-k>"] = actions.move_selection_previous,
    },
    n = {
      ["<esc>"] = actions.close,
      ["<tab>"] = actions.toggle_selection + actions.move_selection_next,
      ["<s-tab>"] = actions.toggle_selection + actions.move_selection_previous,
      ["<cr>"] = user_telescope.multi_selection_open,
      ["<c-v>"] = user_telescope.multi_selection_open_vsplit,
      ["<c-s>"] = user_telescope.multi_selection_open_split,
      ["<c-t>"] = user_telescope.multi_selection_open_tab,
      ["<c-j>"] = actions.move_selection_next,
      ["<c-k>"] = actions.move_selection_previous,
      ["<c-n>"] = actions.cycle_history_next,
      ["<c-p>"] = actions.cycle_history_prev,
      ["<c-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
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
  lvim.builtin.telescope.on_config_done = function(telescope)
    telescope.load_extension "file_create"
    telescope.load_extension "command_palette"
    if lvim.builtin.file_browser.active then
      telescope.load_extension "file_browser"
    end
  end

  -- Terminal
  -- =========================================
  lvim.builtin.terminal.active = true
  lvim.builtin.terminal.open_mapping = [[<c-\>]]

  -- WhichKey
  -- =========================================
  lvim.builtin.which_key.setup.window.winblend = 10
  lvim.builtin.which_key.setup.window.border = "none"
  lvim.builtin.which_key.setup.icons = {
    breadcrumb = "/", -- symbol used in the command line area that shows your active key combo
    separator = "·", -- symbol used between a key and it's label
    group = "", -- symbol prepended to a group
  }
  lvim.builtin.which_key.setup.ignore_missing = true

  -- ETC
  -- =========================================
  local default_exe_handler = vim.lsp.handlers["workspace/executeCommand"]
  vim.lsp.handlers["workspace/executeCommand"] = function(err, result, ctx, config)
    -- supress NULL_LS error msg
    if err and vim.startswith(err.message, "NULL_LS") then
      return
    end
    return default_exe_handler(err, result, ctx, config)
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

function M.tab(fallback)
  local methods = require("lvim.core.cmp").methods
  local cmp = require "cmp"
  local luasnip = require "luasnip"
  local copilot_keys = vim.fn["copilot#Accept"]()
  if cmp.visible() then
    cmp.select_next_item()
  elseif vim.api.nvim_get_mode().mode == "c" then
    fallback()
  elseif copilot_keys ~= "" then -- prioritise copilot over snippets
    -- Copilot keys do not need to be wrapped in termcodes
    vim.api.nvim_feedkeys(copilot_keys, "i", true)
  elseif luasnip.expandable() then
    luasnip.expand()
  elseif methods.jumpable() then
    luasnip.jump(1)
  elseif methods.check_backspace() then
    fallback()
  else
    methods.feedkeys("<Plug>(Tabout)", "")
  end
end

function M.shift_tab(fallback)
  local methods = require("lvim.core.cmp").methods
  local luasnip = require "luasnip"
  local cmp = require "cmp"
  if cmp.visible() then
    cmp.select_prev_item()
  elseif vim.api.nvim_get_mode().mode == "c" then
    fallback()
  elseif methods.jumpable(-1) then
    luasnip.jump(-1)
  else
    local copilot_keys = vim.fn["copilot#Accept"]()
    if copilot_keys ~= "" then
      methods.feedkeys(copilot_keys, "i")
    else
      methods.feedkeys("<Plug>(Tabout)", "")
    end
  end
end

function M.cpmenu()
  return {
    {
      "File",
      { "entire selection", ':call feedkeys("GVgg")' },
      { "file browser", ":Telescope file_browser", 1 },
      { "files", ":lua require('telescope.builtin').find_files()", 1 },
      { "git files", ":lua require('user.telescope').git_files()", 1 },
      { "last search", ":lua require('telescope.builtin').resume({cache_index=3})" },
      { "quit", ":qa" },
      { "save all files", ":wa" },
      { "save current file", ":w" },
      { "search word", ":lua require('user.telescope').find_string()", 1 },
    },
    {
      "Lsp",
      { "formatting", ":lua vim.lsp.buf.formatting_seq_sync()" },
      { "workspace diagnostics", ":Telescope diagnostics" },
      { "workspace symbols", ":Telescope lsp_workspace_symbols" },
    },
    {
      "Project",
      { "list", ":Telescope projects" },
      { "build", ":AsyncTask project-build" },
      { "run", ":AsyncTask project-run" },
      { "tasks", ":AsyncTaskList" },
    },
    {
      "Vim",
      { "buffers", ":Telescope buffers" },
      { "check health", ":checkhealth" },
      { "colorshceme", ":lua require('telescope.builtin').colorscheme()", 1 },
      { "command history", ":lua require('telescope.builtin').command_history()" },
      { "commands", ":lua require('telescope.builtin').commands()" },
      { "cursor column", ":set cursorcolumn!" },
      { "cursor line", ":set cursorline!" },
      { "jumps", ":lua require('telescope.builtin').jumplist()" },
      { "keymaps", ":lua require('telescope.builtin').keymaps()" },
      { "paste mode", ":set paste!" },
      { "registers (A-e)", ":lua require('telescope.builtin').registers()" },
      { "relative number", ":set relativenumber!" },
      { "reload vimrc", ":source $MYVIMRC" },
      { "search highlighting", ":set hlsearch!" },
      { "search history", ":lua require('telescope.builtin').search_history()" },
      { "spell checker", ":set spell!" },
      { "vim options", ":lua require('telescope.builtin').vim_options()" },
    },
    {
      "Help",
      { "cheatsheet", ":help index" },
      { "quick reference", ":help quickref" },
      { "search help", ":lua require('telescope.builtin').help_tags()", 1 },
      { "summary", ":help summary" },
      { "tips", ":help tips" },
      { "tutorial", ":help tutor" },
    },
    {
      "Dap",
      { "brakpoints", ":lua require'telescope'.extensions.dap.list_breakpoints{}" },
      { "clear breakpoints", ":lua require('dap.breakpoints').clear()" },
      { "close", ":lua require'dap'.close(); require'dap'.repl.close()" },
      { "commands", ":lua require'telescope'.extensions.dap.commands{}" },
      { "configurations", ":lua require'telescope'.extensions.dap.configurations{}" },
      { "continue", ":lua require'dap'.continue()" },
      { "current scopes floating window", ":lua ViewCurrentScopesFloatingWindow()" },
      { "current scopes", ':lua ViewCurrentScopes(); vim.cmd("wincmd w|vertical resize 40")' },
      { "current value floating window", ":lua ViewCurrentValueFloatingWindow()" },
      { "frames", ":lua require'telescope'.extensions.dap.frames{}" },
      { "pause", ":lua require'dap'.pause()" },
      { "repl", ":lua require'dap'.repl.open(); vim.cmd(\"wincmd w|resize 12\")" },
      { "run to cursor", ":lua require'dap'.run_to_cursor()" },
      { "step back", ":lua require'dap'.step_back()" },
      { "step into", ":lua require'dap'.step_into()" },
      { "step out", ":lua require'dap'.step_out()" },
      { "step over", ":lua require'dap'.step_over()" },
      { "toggle breakpoint", ":lua require'dap'.toggle_breakpoint()" },
    },
  }
end

-- credit: https://github.com/max397574/NeovimConfig/blob/master/lua/configs/lsp/init.lua
M.codes = {
  no_matching_function = {
    message = " Can't find a matching function",
    "redundant-parameter",
    "ovl_no_viable_function_in_call",
  },
  different_requires = {
    message = " Buddy you've imported this before, with the same name",
    "different-requires",
  },
  empty_block = {
    message = " That shouldn't be empty here",
    "empty-block",
  },
  missing_symbol = {
    message = " Here should be a symbol",
    "miss-symbol",
  },
  expected_semi_colon = {
    message = " Remember the `;` or `,`",
    "expected_semi_declaration",
    "miss-sep-in-table",
    "invalid_token_after_toplevel_declarator",
  },
  redefinition = {
    message = " That variable was defined before",
    "redefinition",
    "redefined-local",
  },
  no_matching_variable = {
    message = " Can't find that variable",
    "undefined-global",
    "reportUndefinedVariable",
  },
  trailing_whitespace = {
    message = " Remove trailing whitespace",
    "trailing-whitespace",
    "trailing-space",
  },
  unused_variable = {
    message = " Don't define variables you don't use",
    "unused-local",
  },
  unused_function = {
    message = " Don't define functions you don't use",
    "unused-function",
  },
  useless_symbols = {
    message = " Remove that useless symbols",
    "unknown-symbol",
  },
  wrong_type = {
    message = " Try to use the correct types",
    "init_conversion_failed",
  },
  undeclared_variable = {
    message = " Have you delcared that variable somewhere?",
    "undeclared_var_use",
  },
  lowercase_global = {
    message = " Should that be a global? (if so make it uppercase)",
    "lowercase-global",
  },
}

M.show_documentation = function()
  local filetype = vim.bo.filetype
  if vim.tbl_contains({ "vim", "help" }, filetype) then
    vim.cmd("h " .. vim.fn.expand "<cword>")
  elseif vim.fn.expand "%:t" == "Cargo.toml" then
    require("crates").show_popup()
  elseif vim.tbl_contains({ "man" }, filetype) then
    vim.cmd("Man " .. vim.fn.expand "<cword>")
  else
    vim.lsp.buf.hover()
  end
end

return M
