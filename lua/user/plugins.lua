local M = {}

M.config = function()
  local neoclip_req = { "tami5/sqlite.lua", module = "sqlite" }
  if lvim.builtin.neoclip.enable_persistant_history == false then
    neoclip_req = {}
  end
  lvim.plugins = {
    {
      "abzcoding/zephyr-nvim",
      config = function()
        vim.cmd [[
       colorscheme zephyr
       ]]
      end,
      cond = function()
        local _time = os.date "*t"
        return (_time.hour >= 5 and _time.hour < 8)
      end,
    },
    {
      "rose-pine/neovim",
      as = "rose-pine",
      config = function()
        require("user.theme").rose_pine()
      end,
      cond = function()
        local _time = os.date "*t"
        return (_time.hour >= 8 and _time.hour < 11)
      end,
    },
    {
      "folke/tokyonight.nvim",
      config = function()
        require("user.theme").tokyonight()
        vim.cmd [[
      colorscheme tokyonight
      ]]
      end,
      cond = function()
        local _time = os.date "*t"
        return (_time.hour >= 0 and _time.hour < 5) or (_time.hour >= 11 and _time.hour < 17)
      end,
    },
    {
      "abzcoding/doom-one.nvim",
      branch = "feat/nvim-cmp-floating",
      config = function()
        require("user.theme").doom()
        vim.cmd [[
      colorscheme doom-one
      ]]
      end,
      cond = function()
        local _time = os.date "*t"
        return (_time.hour >= 17 and _time.hour < 21)
      end,
    },
    {
      "ray-x/lsp_signature.nvim",
      config = function()
        require("user/lsp_signature").config()
      end,
      event = "BufRead",
    },
    {
      "ethanholz/nvim-lastplace",
      config = function()
        require("nvim-lastplace").setup {}
      end,
      event = "BufWinEnter",
      disable = not lvim.builtin.lastplace.active,
    },
    {
      "folke/todo-comments.nvim",
      requires = "nvim-lua/plenary.nvim",
      config = function()
        require("user.todo_comments").config()
      end,
      event = "BufRead",
    },
    {
      "folke/trouble.nvim",
      config = function()
        require("trouble").setup {
          auto_open = true,
          auto_close = true,
          padding = false,
          height = 10,
          use_lsp_diagnostic_signs = true,
        }
      end,
      cmd = "Trouble",
    },
    {
      "ggandor/lightspeed.nvim",
      config = function()
        require("user.lightspeed").config()
      end,
      disable = lvim.builtin.motion_provider ~= "lightspeed",
    },
    {
      "phaazon/hop.nvim",
      event = "BufRead",
      config = function()
        require("user.hop").config()
      end,
      disable = lvim.builtin.motion_provider ~= "hop",
    },
    {
      "simrat39/symbols-outline.nvim",
      setup = function()
        require("user.symbols_outline").config()
      end,
      event = "BufReadPost",
      -- cmd = "SymbolsOutline",
    },
    {
      "lukas-reineke/indent-blankline.nvim",
      setup = function()
        vim.g.indent_blankline_char = "▏"
      end,
      config = function()
        require("user.indent_blankline").config()
      end,
      event = "BufRead",
    },
    {
      "tzachar/cmp-tabnine",
      run = "./install.sh",
      requires = "hrsh7th/nvim-cmp",
      config = function()
        local tabnine = require "cmp_tabnine.config"
        tabnine:setup {
          max_lines = 1000,
          max_num_results = 10,
          sort = true,
        }
      end,
      opt = true,
      event = "InsertEnter",
      disable = not lvim.builtin.tabnine.active,
    },
    {
      "folke/twilight.nvim",
      config = function()
        require("user.twilight").config()
      end,
      event = "BufRead",
    },
    {
      "kevinhwang91/nvim-bqf",
      config = function()
        require("user.bqf").config()
      end,
      event = "BufRead",
    },
    {
      "rcarriga/nvim-dap-ui",
      config = function()
        require("dapui").setup()
      end,
      ft = { "python", "rust", "go" },
      requires = { "mfussenegger/nvim-dap" },
      disable = not lvim.builtin.dap.active,
    },
    {
      "andymass/vim-matchup",
      event = "CursorMoved",
      config = function()
        vim.g.matchup_enabled = 1
        vim.g.matchup_surround_enabled = 1
        vim.g.matchup_matchparen_deferred = 1
        vim.g.matchup_matchparen_offscreen = { method = "popup" }
      end,
    },
    {
      "iamcco/markdown-preview.nvim",
      run = "cd app && npm install",
      ft = "markdown",
    },
    {
      "simrat39/rust-tools.nvim",
      config = function()
        require("user.rust_tools").config()
      end,
      ft = { "rust", "rs" },
    },
    {
      "folke/zen-mode.nvim",
      config = function()
        require("user.zen").config()
      end,
      event = "BufRead",
    },
    {
      "windwp/nvim-spectre",
      event = "BufRead",
      config = function()
        require("user.spectre").config()
      end,
    },
    {
      "norcalli/nvim-colorizer.lua",
      config = function()
        require("user.colorizer").config()
      end,
      event = "BufRead",
    },
    {
      "folke/persistence.nvim",
      event = "BufReadPre",
      module = "persistence",
      config = function()
        require("persistence").setup {
          dir = vim.fn.expand(get_cache_dir() .. "/sessions/"), -- directory where session files are saved
          options = { "buffers", "curdir", "tabpages", "winsize" }, -- sessionoptions used for saving
        }
      end,
      disable = not lvim.builtin.persistence.active,
    },
    {
      "andweeb/presence.nvim",
      config = function()
        require("user.presence").config()
      end,
      disable = not lvim.builtin.presence.active,
    },
    { "mfussenegger/nvim-jdtls", ft = "java" },
    {
      "kristijanhusak/orgmode.nvim",
      keys = { "go", "gC" },
      ft = { "org" },
      config = function()
        require("user.orgmode").setup()
      end,
      disable = not lvim.builtin.orgmode.active,
    },
    {
      "danymat/neogen",
      config = function()
        require("neogen").setup {
          enabled = true,
        }
      end,
      ft = { "lua", "python", "javascript", "typescriptreact", "c", "cpp", "go", "java" },
      event = "InsertEnter",
      requires = "nvim-treesitter/nvim-treesitter",
    },
    {
      "vim-test/vim-test",
      cmd = { "TestNearest", "TestFile", "TestSuite", "TestLast", "TestVisit" },
      keys = { "<localleader>tf", "<localleader>tn", "<localleader>ts" },
      config = function()
        require("user.vim_test").config()
      end,
      disable = not lvim.builtin.test_runner.active,
    },
    {
      "folke/lua-dev.nvim",
      ft = "lua",
      before = "williamboman/nvim-lsp-installer",
      disable = not lvim.builtin.lua_dev.active,
    },
    {
      "jose-elias-alvarez/nvim-lsp-ts-utils",
      ft = {
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.tsx",
      },
      opt = true,
      before = "williamboman/nvim-lsp-installer",
    },
    {
      "lervag/vimtex",
      ft = "tex",
    },
    {
      "akinsho/bufferline.nvim",
      config = function()
        require("user.bufferline").config()
      end,
      requires = "nvim-web-devicons",
      disable = not lvim.builtin.fancy_bufferline.active,
    },
    {
      "rcarriga/vim-ultest",
      cmd = { "Ultest", "UltestSummary", "UltestNearest" },
      wants = "vim-test",
      requires = { "vim-test/vim-test" },
      run = ":UpdateRemotePlugins",
      opt = true,
      event = { "BufEnter *_test.*,*_spec.*" },
      disable = not lvim.builtin.test_runner.active,
    },
    {
      "akinsho/flutter-tools.nvim",
      requires = "nvim-lua/plenary.nvim",
      config = function()
        require("user.flutter_tools").config()
      end,
      ft = "dart",
    },
    {
      "RishabhRD/nvim-cheat.sh",
      requires = "RishabhRD/popfix",
      config = function()
        vim.g.cheat_default_window_layout = "vertical_split"
      end,
      opt = true,
      cmd = { "Cheat", "CheatWithoutComments", "CheatList", "CheatListWithoutComments" },
      keys = "<leader>?",
      disable = not lvim.builtin.cheat.active,
    },
    {
      "AckslD/nvim-neoclip.lua",
      config = function()
        require("user.neoclip").config()
      end,
      opt = true,
      keys = "<leader>y",
      requires = neoclip_req,
      disable = not lvim.builtin.neoclip.active,
    },
    {
      "goolord/alpha-nvim",
      config = function()
        require("user.dashboard").config()
      end,
      disable = not lvim.builtin.fancy_dashboard.active,
    },
    {
      "gelguy/wilder.nvim",
      -- event = { "CursorHold", "CmdlineEnter" },
      rocks = { "luarocks-fetch-gitrec", "pcre2" },
      requires = { "romgrk/fzy-lua-native" },
      config = function()
        vim.cmd(string.format("source %s", "~/.config/lvim/vimscript/wilder.vim"))
      end,
      run = ":UpdateRemotePlugins",
      disable = not lvim.builtin.fancy_wild_menu.active,
    },
    {
      "kristijanhusak/vim-dadbod-completion",
      disable = not lvim.builtin.sql_integration.active,
    },
    {
      "kristijanhusak/vim-dadbod-ui",
      cmd = {
        "DBUIToggle",
        "DBUIAddConnection",
        "DBUI",
        "DBUIFindBuffer",
        "DBUIRenameBuffer",
      },
      requires = {
        {
          "tpope/vim-dadbod",
          opt = true,
        },
      },
      opt = true,
      disable = not lvim.builtin.sql_integration.active,
    },
    {
      "karb94/neoscroll.nvim",
      config = function()
        require("neoscroll").setup {
          easing_function = "quadratic",
        }
      end,
      event = "BufRead",
      disable = not lvim.builtin.neoscroll.active,
    },
    {
      "b0o/schemastore.nvim",
    },
    {
      "github/copilot.vim",
      config = function()
        vim.g.copilot_no_tab_map = true
        vim.g.copilot_assume_mapped = true
        vim.g.copilot_tab_fallback = ""
        vim.g.copilot_filetypes = {
          ["*"] = false,
          python = true,
          lua = true,
          go = true,
          rust = true,
          html = true,
          c = true,
          cpp = true,
          javascript = true,
          typescript = true,
          javascriptreact = true,
          typescriptreact = true,
        }
      end,
      disable = not lvim.builtin.sell_your_soul_to_devil,
    },
    {
      "akinsho/dependency-assist.nvim",
      branch = "refactor",
      --- requires libyaml-dev on ubuntu or libyaml on macOS
      rocks = { { "lyaml", server = "http://rocks.moonscript.org" } },
      config = function()
        require("dependency_assist").setup()
      end,
    },
    {
      "ThePrimeagen/harpoon",
      requires = {
        { "nvim-lua/plenary.nvim" },
        { "nvim-lua/popup.nvim" },
      },
      disable = not lvim.builtin.harpoon.active,
    },
    {
      "sindrets/diffview.nvim",
      opt = true,
      cmd = { "DiffviewOpen", "DiffviewFileHistory" },
      module = "diffview",
      keys = "<leader>gd",
      setup = function()
        require("which-key").register { ["<leader>gd"] = "diffview: diff HEAD" }
      end,
      config = function()
        require("diffview").setup {
          enhanced_diff_hl = true,
          key_bindings = {
            file_panel = { q = "<Cmd>DiffviewClose<CR>" },
            view = { q = "<Cmd>DiffviewClose<CR>" },
          },
        }
      end,
      disable = not lvim.builtin.fancy_diff.active,
    },
    {
      "chipsenkbeil/distant.nvim",
      opt = true,
      run = { "DistantInstall" },
      cmd = { "DistantLaunch", "DistantRun" },
      config = function()
        require("distant").setup {
          ["*"] = vim.tbl_extend(
            "force",
            require("distant.settings").chip_default(),
            { mode = "ssh" } -- use SSH mode by default
          ),
        }
      end,
      disable = not lvim.builtin.remote_dev.active,
    },
    {
      "nathom/filetype.nvim",
      config = function()
        require("filetype").setup {
          overrides = {
            literal = {
              ["kitty.conf"] = "kitty",
              [".gitignore"] = "conf",
            },
          },
        }
      end,
    },
    {
      "Nguyen-Hoang-Nam/nvim-mini-file-icons",
      config = function()
        require("nvim-web-devicons").set_icon {
          rs = {
            icon = "",
            color = "#d28445",
            name = "Rust",
          },
        }
      end,
      disable = lvim.builtin.nvim_web_devicons == nil,
    },
    {
      "nvim-telescope/telescope-live-grep-raw.nvim",
    },
    {
      "filipdutescu/renamer.nvim",
      config = function()
        require("renamer").setup {
          title = "Rename",
        }
      end,
      disable = not lvim.builtin.fancy_rename.active,
    },
    {
      "windwp/floatline.nvim",
      config = function()
        require("floatline").setup()
      end,
      disable = not lvim.builtin.global_status_line.active,
    },
    {
      "luukvbaal/stabilize.nvim",
      config = function()
        require("stabilize").setup { forcemark = "f", nested = "QuickFixCmdPost,User LspDiagnosticsChanged" }
      end,
      disable = not lvim.builtin.global_status_line.active,
    },
    { "mtdl9/vim-log-highlighting", ft = { "text", "log" } },
    {
      "yamatsum/nvim-cursorline",
      opt = true,
      event = "BufWinEnter",
      disable = not lvim.builtin.cursorline.active,
    },
    {
      "abecodes/tabout.nvim",
      wants = { "nvim-treesitter" },
      after = { "nvim-cmp" },
      config = function()
        require("user.tabout").config()
      end,
      disable = not lvim.builtin.sell_your_soul_to_devil,
    },
    {
      "kevinhwang91/nvim-hlslens",
      config = function()
        require("user.hlslens").config()
      end,
      event = "BufReadPost",
      disable = not lvim.builtin.hlslens.active,
    },
    {
      "kosayoda/nvim-lightbulb",
      config = function()
        vim.fn.sign_define(
          "LightBulbSign",
          { text = require("user.lsp_kind").icons.code_action, texthl = "DiagnosticInfo" }
        )
      end,
      event = "BufRead",
      ft = { "rust", "go" },
    },
    {
      "chrisbra/csv.vim",
      ft = { "csv" },
      disable = not lvim.builtin.csv_support,
    },
    {
      "nvim-treesitter/nvim-treesitter-textobjects",
      after = "nvim-treesitter",
    },
    {
      "sidebar-nvim/sidebar.nvim",
      config = function()
        require("user.sidebar").config()
      end,
      -- event = "BufRead",
      disable = not lvim.builtin.sidebar.active,
    },
    {
      "skywind3000/asynctasks.vim",
      requires = {
        { "skywind3000/asyncrun.vim" },
      },
      setup = function()
        vim.cmd [[
          let g:asyncrun_open = 8
          let g:asynctask_template = '~/.config/lvim/task_template.ini'
          let g:asynctasks_extra_config = ['~/.config/lvim/tasks.ini']
        ]]
      end,
      event = "BufRead",
      disable = not lvim.builtin.async_tasks.active,
    },
  }
end

return M
