local M = {}

M.config = function()
  local neoclip_req = { "kkharji/sqlite.lua" }
  if lvim.builtin.neoclip.enable_persistent_history == false then
    neoclip_req = {}
  end
  lvim.plugins = {
    -- {
    --   "folke/tokyonight.nvim",
    --   config = function()
    --     require("user.theme").tokyonight()
    --     vim.cmd [[colorscheme tokyonight]]
    --   end,
    --   cond = function()
    --     local _time = os.date "*t"
    --     return (_time.hour >= 9 and _time.hour < 17) and lvim.builtin.time_based_themes
    --   end,
    -- },
    {
      "rose-pine/neovim",
      name = "rose-pine",
      config = function()
        require("user.theme").rose_pine()
        lvim.colorscheme = "rose-pine"
      end,
      cond = function()
        local _time = os.date "*t"
        return (_time.hour >= 1 and _time.hour < 9) and lvim.builtin.time_based_themes
      end,
    },
    {
      "catppuccin/nvim",
      name = "catppuccin",
      config = function()
        require("user.theme").catppuccin()
        local _time = os.date "*t"
        if (_time.hour >= 17 and _time.hour < 21) and lvim.builtin.time_based_themes then
          lvim.colorscheme = "catppuccin-mocha"
        end
      end,
    },
    {
      "rebelot/kanagawa.nvim",
      config = function()
        require("user.theme").kanagawa()
        lvim.colorscheme = "kanagawa"
      end,
      cond = function()
        local _time = os.date "*t"
        return ((_time.hour >= 21 and _time.hour < 24) or (_time.hour >= 0 and _time.hour < 1))
          and lvim.builtin.time_based_themes
      end,
    },
    {
      "ray-x/lsp_signature.nvim",
      config = function()
        require("user/lsp_signature").config()
      end,
      event = { "BufRead", "BufNew" },
    },
    {
      "vladdoster/remember.nvim",
      config = function()
        require("remember").setup {}
      end,
      enabled = lvim.builtin.lastplace.active,
    },
    {
      "folke/todo-comments.nvim",
      dependencies = "nvim-lua/plenary.nvim",
      config = function()
        require("user.todo_comments").config()
      end,
      event = "BufRead",
    },
    {
      "folke/trouble.nvim",
      config = function()
        require("trouble").setup {
          auto_open = false,
          auto_close = true,
          padding = false,
          height = 10,
          use_diagnostic_signs = true,
        }
      end,
      event = "VeryLazy",
      cmd = "Trouble",
    },
    {
      "ggandor/leap.nvim",
      config = function()
        require("user.leap").config()
      end,
      enabled = lvim.builtin.motion_provider == "leap",
    },
    {
      "phaazon/hop.nvim",
      event = "VeryLazy",
      cmd = { "HopChar1CurrentLineAC", "HopChar1CurrentLineBC", "HopChar2MW", "HopWordMW" },
      config = function()
        require("user.hop").config()
      end,
      enabled = lvim.builtin.motion_provider == "hop",
    },
    {
      "simrat39/symbols-outline.nvim",
      config = function()
        require("user.symbols_outline").config()
      end,
      event = "BufReadPost",
      enabled = lvim.builtin.tag_provider == "symbols-outline",
    },
    {
      "tzachar/cmp-tabnine",
      build = "./install.sh",
      dependencies = "hrsh7th/nvim-cmp",
      config = function()
        local tabnine = require "cmp_tabnine.config"
        tabnine:setup {
          max_lines = 1000,
          max_num_results = 10,
          sort = true,
        }
      end,
      lazy = true,
      event = "InsertEnter",
      enabled = lvim.builtin.tabnine.active,
    },
    {
      "folke/twilight.nvim",
      lazy = true,
      config = function()
        require("user.twilight").config()
      end,
    },
    {
      "kevinhwang91/nvim-bqf",
      event = "WinEnter",
      config = function()
        require("user.bqf").config()
      end,
    },
    {
      "andymass/vim-matchup",
      event = "BufReadPost",
      config = function()
        vim.g.matchup_enabled = 1
        vim.g.matchup_surround_enabled = 1
        vim.g.matchup_matchparen_deferred = 1
        vim.g.matchup_matchparen_offscreen = { method = "popup" }
      end,
    },
    {
      "iamcco/markdown-preview.nvim",
      build = "cd app && npm install",
      ft = "markdown",
    },
    {
      "simrat39/rust-tools.nvim",
      lazy = true,
      config = function()
        require("user.rust_tools").config()
      end,
      ft = { "rust", "rs" },
      enabled = lvim.builtin.rust_programming.active,
    },
    {
      url = "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
      lazy = true,
      config = function()
        require("lsp_lines").setup()
      end,
      enabled = lvim.builtin.lsp_lines,
    },
    {
      "folke/zen-mode.nvim",
      lazy = true,
      cmd = "ZenMode",
      config = function()
        require("user.zen").config()
      end,
    },
    {
      "windwp/nvim-spectre",
      lazy = true,
      config = function()
        require("user.spectre").config()
      end,
    },
    {
      "norcalli/nvim-colorizer.lua",
      config = function()
        require("user.colorizer").config()
      end,
      event = "BufReadPre",
    },
    {
      "folke/persistence.nvim",
      event = "BufReadPre",
      lazy = true,
      config = function()
        require("persistence").setup {
          dir = vim.fn.expand(get_cache_dir() .. "/sessions/"), -- directory where session files are saved
          options = { "buffers", "curdir", "tabpages", "winsize" }, -- sessionoptions used for saving
        }
      end,
      enabled = lvim.builtin.persistence.active,
    },
    {
      "andweeb/presence.nvim",
      config = function()
        require("user.presence").config()
      end,
      enabled = lvim.builtin.presence.active,
    },
    { "mfussenegger/nvim-jdtls", ft = "java" },
    {
      "kristijanhusak/orgmode.nvim",
      keys = { "go", "gC" },
      ft = { "org" },
      config = function()
        require("user.orgmode").setup()
      end,
      enabled = lvim.builtin.orgmode.active,
    },
    {
      "danymat/neogen",
      lazy = true,
      config = function()
        require("neogen").setup {
          enabled = true,
        }
      end,
      dependencies = "nvim-treesitter/nvim-treesitter",
    },
    {
      "vim-test/vim-test",
      cmd = { "TestNearest", "TestFile", "TestSuite", "TestLast", "TestVisit" },
      config = function()
        require("user.vim_test").config()
      end,
      enabled = (lvim.builtin.test_runner.active and lvim.builtin.test_runner.runner == "ultest"),
    },
    {
      "jose-elias-alvarez/typescript.nvim",
      ft = {
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.tsx",
      },
      lazy = true,
      config = function()
        require("user.tss").config()
      end,
      enabled = lvim.builtin.web_programming.active,
    },
    {
      "vuki656/package-info.nvim",
      config = function()
        require("package-info").setup()
      end,
      lazy = true,
      event = { "BufReadPre", "BufNew" },
      enabled = lvim.builtin.web_programming.active,
    },
    {
      "lervag/vimtex",
      init = function()
        require("user.tex").init()
      end,
      config = function()
        vim.cmd "call vimtex#init()"
      end,
      ft = "tex",
      event = "VeryLazy",
      enabled = lvim.builtin.latex.active,
    },
    {
      "nvim-neotest/neotest",
      config = function()
        require("user.ntest").config()
      end,
      dependencies = {
        { "nvim-neotest/neotest-plenary" },
      },
      event = { "BufReadPost", "BufNew" },
      enabled = (lvim.builtin.test_runner.active and lvim.builtin.test_runner.runner == "neotest"),
    },
    { "nvim-neotest/neotest-go", event = { "BufEnter *.go" } },
    { "nvim-neotest/neotest-python", event = { "BufEnter *.py" } },
    { "rouge8/neotest-rust", event = { "BufEnter *.rs" } },
    {
      "rcarriga/vim-ultest",
      cmd = { "Ultest", "UltestSummary", "UltestNearest" },
      dependencies = { "vim-test/vim-test" },
      build = ":UpdateRemotePlugins",
      lazy = true,
      event = { "BufEnter *_test.*,*_spec.*,*est_*.*" },
      enabled = (lvim.builtin.test_runner.active and lvim.builtin.test_runner.runner == "ultest"),
    },
    {
      "akinsho/flutter-tools.nvim",
      dependencies = "nvim-lua/plenary.nvim",
      config = function()
        require("user.flutter_tools").config()
      end,
      ft = "dart",
    },
    {
      "RishabhRD/nvim-cheat.sh",
      dependencies = "RishabhRD/popfix",
      config = function()
        vim.g.cheat_default_window_layout = "vertical_split"
      end,
      lazy = true,
      cmd = { "Cheat", "CheatWithoutComments", "CheatList", "CheatListWithoutComments" },
      keys = "<leader>?",
      enabled = lvim.builtin.cheat.active,
    },
    {
      "AckslD/nvim-neoclip.lua",
      config = function()
        require("user.neoclip").config()
      end,
      lazy = true,
      keys = "<leader>y",
      dependencies = neoclip_req,
      enabled = lvim.builtin.neoclip.active,
    },
    {
      "kristijanhusak/vim-dadbod-completion",
      enabled = lvim.builtin.sql_integration.active,
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
      init = function()
        vim.g.db_ui_use_nerd_fonts = 1
        vim.g.db_ui_show_database_icon = 1
      end,
      dependencies = {
        {
          "tpope/vim-dadbod",
          lazy = true,
        },
      },
      lazy = true,
      enabled = lvim.builtin.sql_integration.active,
    },
    {
      "karb94/neoscroll.nvim",
      config = function()
        require("neoscroll").setup {
          easing_function = "quadratic",
          hide_cursor = true,
        }
      end,
      event = "BufRead",
      enabled = lvim.builtin.smooth_scroll == "neoscroll",
    },
    {
      "declancm/cinnamon.nvim",
      config = function()
        require("cinnamon").setup {
          default_keymaps = true,
          default_delay = 4,
          extra_keymaps = true,
          extended_keymaps = false,
          centered = true,
          scroll_limit = 100,
        }
      end,
      event = "BufRead",
      enabled = lvim.builtin.smooth_scroll == "cinnamon",
    },
    {
      "github/copilot.vim",
      config = function()
        require("user.copilot").config()
      end,
      enabled = lvim.builtin.sell_your_soul_to_devil.active or lvim.builtin.sell_your_soul_to_devil.prada,
    },
    {
      "zbirenbaum/copilot.lua",
      dependencies = { "zbirenbaum/copilot-cmp", "nvim-cmp" },
      config = function()
        local cmp_source = { name = "copilot", group_index = 2 }
        table.insert(lvim.builtin.cmp.sources, cmp_source)
        vim.defer_fn(function()
          require("copilot").setup()
        end, 100)
      end,
      enabled = lvim.builtin.sell_your_soul_to_devil.prada,
    },
    {
      "ThePrimeagen/harpoon",
      dependencies = {
        { "nvim-lua/plenary.nvim" },
        { "nvim-lua/popup.nvim" },
      },
      enabled = lvim.builtin.harpoon.active,
    },
    {
      "sindrets/diffview.nvim",
      lazy = true,
      cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
      keys = { "<leader>gd", "<leader>gh" },
      config = function()
        require("user.diffview").config()
      end,
      enabled = lvim.builtin.fancy_diff.active,
    },
    {
      "chipsenkbeil/distant.nvim",
      lazy = true,
      build = { "DistantInstall" },
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
      enabled = lvim.builtin.remote_dev.active,
    },
    {
      "abzcoding/nvim-mini-file-icons",
      config = function()
        require("nvim-web-devicons").setup()
      end,
      enabled = lvim.builtin.custom_web_devicons or not lvim.use_icons,
    },
    {
      "nvim-telescope/telescope-live-grep-args.nvim",
    },
    { "mtdl9/vim-log-highlighting", ft = { "text", "log" } },
    {
      "yamatsum/nvim-cursorline",
      lazy = true,
      event = "BufWinEnter",
      enabled = lvim.builtin.cursorline.active,
    },
    {
      "abecodes/tabout.nvim",
      config = function()
        require("user.tabout").config()
      end,
    },
    {
      "kevinhwang91/nvim-hlslens",
      config = function()
        require("user.hlslens").config()
      end,
      event = "BufReadPost",
      enabled = lvim.builtin.hlslens.active,
    },
    {
      "chrisbra/csv.vim",
      ft = { "csv" },
      enabled = lvim.builtin.csv_support,
    },
    {
      "nvim-treesitter/nvim-treesitter-textobjects",
      lazy = true,
      event = "BufReadPre",
      dependencies = "nvim-treesitter",
    },
    {
      "sidebar-nvim/sidebar.nvim",
      config = function()
        require("user.sidebar").config()
      end,
      -- event = "BufRead",
      enabled = lvim.builtin.sidebar.active,
    },
    {
      "skywind3000/asynctasks.vim",
      dependencies = {
        { "skywind3000/asyncrun.vim" },
      },
      init = function()
        vim.cmd [[
          let g:asyncrun_open = 8
          let g:asynctask_template = '~/.config/lvim/task_template.ini'
          let g:asynctasks_extra_config = ['~/.config/lvim/tasks.ini']
        ]]
      end,
      event = { "BufRead", "BufNew" },
      enabled = lvim.builtin.task_runner == "async_tasks",
    },
    {
      "scalameta/nvim-metals",
      dependencies = { "nvim-lua/plenary.nvim" },
      enabled = lvim.builtin.metals.active,
    },
    {
      "jbyuki/instant.nvim",
      event = "BufRead",
      enabled = lvim.builtin.collaborative_editing.active,
    },
    {
      "nvim-telescope/telescope-file-browser.nvim",
      enabled = lvim.builtin.file_browser.active,
    },
    {
      "j-hui/fidget.nvim",
      config = function()
        require("user.fidget_spinner").config()
      end,
      -- disable = lvim.builtin.noice.active,
    },
    {
      "michaelb/sniprun",
      build = "bash ./install.sh",
      enabled = lvim.builtin.sniprun.active,
    },
    {
      "liuchengxu/vista.vim",
      init = function()
        require("user.vista").config()
      end,
      event = "BufReadPost",
      enabled = lvim.builtin.tag_provider == "vista",
    },
    {
      "p00f/clangd_extensions.nvim",
      config = function()
        require("user.cle").config()
      end,
      ft = { "c", "cpp", "objc", "objcpp", "h", "hpp" },
      enabled = lvim.builtin.cpp_programming.active,
    },
    {
      "editorconfig/editorconfig-vim",
      event = "BufRead",
      enabled = lvim.builtin.editorconfig.active,
    },
    {
      "saecki/crates.nvim",
      event = { "BufRead Cargo.toml" },
      dependencies = { { "nvim-lua/plenary.nvim" } },
      config = function()
        require("user.crates").config()
      end,
      enabled = lvim.builtin.rust_programming.active,
    },
    {
      "hrsh7th/cmp-cmdline",
      enabled = lvim.builtin.fancy_wild_menu.active,
    },
    {
      "mrjones2014/legendary.nvim",
      config = function()
        require("user.legendary").config()
      end,
      enabled = lvim.builtin.legendary.active,
    },
    {
      "stevearc/dressing.nvim",
      lazy = true,
      config = function()
        require("user.dress").config()
      end,
      enabled = lvim.builtin.dressing.active,
      event = "BufWinEnter",
    },
    {
      "kdheepak/cmp-latex-symbols",
      dependencies = "hrsh7th/nvim-cmp",
      ft = "tex",
    },
    {
      "ThePrimeagen/refactoring.nvim",
      lazy = true,
      ft = { "typescript", "javascript", "lua", "c", "cpp", "go", "python", "java", "php" },
      event = "BufReadPost",
      config = function()
        require("refactoring").setup {}
      end,
      enabled = lvim.builtin.refactoring.active,
    },
    {
      "b0o/incline.nvim",
      config = function()
        require("user.incline").config()
      end,
      enabled = lvim.builtin.winbar_provider == "filename",
    },
    {
      "fgheng/winbar.nvim",
      config = function()
        require("user.winb").config()
      end,
      event = { "InsertEnter", "CursorHoldI" },
      enabled = lvim.builtin.winbar_provider == "treesitter",
    },
    {
      "SmiteshP/nvim-gps",
      module_pattern = { "gps", "nvim-gps" },
      config = function()
        require("user.gps").config()
      end,
      dependencies = "nvim-treesitter/nvim-treesitter",
      event = { "InsertEnter", "CursorHoldI" },
      enabled = lvim.builtin.winbar_provider == "treesitter",
    },
    {
      "vimpostor/vim-tpipeline",
      enabled = lvim.builtin.tmux_lualine,
    },
    {
      "stevearc/overseer.nvim",
      config = function()
        require("user.ovs").config()
      end,
      enabled = lvim.builtin.task_runner == "overseer",
    },
    {
      "nvim-neo-tree/neo-tree.nvim",
      branch = "v2.x",
      cmd = "Neotree",
      dependencies = {
        "MunifTanjim/nui.nvim",
      },
      config = function()
        require("user.neotree").config()
      end,
      enabled = lvim.builtin.tree_provider == "neo-tree",
    },
    { "MunifTanjim/nui.nvim" },
    {
      "folke/noice.nvim",
      event = "VeryLazy",
      config = function()
        require("user.noice").config()
      end,
      dependencies = {
        "rcarriga/nvim-notify",
      },
      enabled = lvim.builtin.noice.active,
    },
    {
      "olexsmir/gopher.nvim",
      config = function()
        require("gopher").setup {
          commands = {
            go = "go",
            gomodifytags = "gomodifytags",
            gotests = "gotests",
            impl = "impl",
            iferr = "iferr",
          },
        }
      end,
      ft = { "go", "gomod" },
      event = { "BufRead", "BufNew" },
      enabled = lvim.builtin.go_programming.active,
    },
    {
      "leoluz/nvim-dap-go",
      config = function()
        require("dap-go").setup()
      end,
      ft = { "go", "gomod" },
      event = { "BufRead", "BufNew" },
      enabled = lvim.builtin.go_programming.active,
    },
    {
      "AckslD/swenv.nvim",
      enabled = lvim.builtin.python_programming.active,
      ft = "python",
      event = { "BufRead", "BufNew" },
    },
    {
      "mfussenegger/nvim-dap-python",
      config = function()
        local mason_path = vim.fn.glob(vim.fn.stdpath "data" .. "/mason/")
        require("dap-python").setup(mason_path .. "packages/debugpy/venv/bin/python")
        require("dap-python").test_runner = "pytest"
      end,
      ft = "python",
      event = { "BufRead", "BufNew" },
      enabled = lvim.builtin.python_programming.active,
    },
    {
      "mxsdev/nvim-dap-vscode-js",
      ft = {
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.tsx",
      },
      lazy = true,
      event = { "BufReadPre", "BufNew" },
      config = function()
        require("dap-vscode-js").setup {
          debugger_path = vim.fn.stdpath "data" .. "/mason/packages/js-debug-adapter",
          debugger_cmd = { "js-debug-adapter" },
          adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
        }
      end,
      enabled = lvim.builtin.web_programming.active,
    },
    {
      "smjonas/inc-rename.nvim",
      lazy = true,
      cmd = "IncRename",
      config = function()
        require("inc_rename").setup()
      end,
      enabled = lvim.builtin.noice.active,
    },
    {
      "m-demare/hlargs.nvim",
      lazy = true,
      event = "VeryLazy",
      config = function()
        require("hlargs").setup()
      end,
      dependencies = { "nvim-treesitter/nvim-treesitter" },
      enabled = lvim.builtin.colored_args,
    },
    {
      "cshuaimin/ssr.nvim",
      lazy = true,
      config = function()
        require("ssr").setup {
          min_width = 50,
          min_height = 5,
          keymaps = {
            close = "q",
            next_match = "n",
            prev_match = "N",
            replace_all = "<leader><cr>",
          },
        }
      end,
      event = { "BufReadPost", "BufNew" },
    },
    {
      "Civitasv/cmake-tools.nvim",
      config = function()
        require("user.cle").cmake_config()
      end,
      ft = { "c", "cpp", "objc", "objcpp", "h", "hpp" },
      enabled = lvim.builtin.cpp_programming.active,
    },
    {
      "lvimuser/lsp-inlayhints.nvim",
      config = function()
        require("lsp-inlayhints").setup()
      end,
      enabled = lvim.builtin.inlay_hints.active,
    },
    {
      "raimon49/requirements.txt.vim",
      event = "VeryLazy",
      enabled = lvim.builtin.python_programming.active,
    },
    {
      "phaazon/mind.nvim",
      branch = "v2.2",
      dependencies = { "nvim-lua/plenary.nvim" },
      config = function()
        require("user.mind").config()
      end,
      event = "VeryLazy",
      enabled = lvim.builtin.mind.active,
    },
  }
end

return M
