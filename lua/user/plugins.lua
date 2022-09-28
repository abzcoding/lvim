local M = {}

M.config = function()
  local neoclip_req = { "tami5/sqlite.lua", module = "sqlite" }
  if lvim.builtin.neoclip.enable_persistent_history == false then
    neoclip_req = {}
  end
  lvim.plugins = {
    {
      "rose-pine/neovim",
      as = "rose-pine",
      config = function()
        require("user.theme").rose_pine()
        vim.cmd [[colorscheme rose-pine]]
      end,
      cond = function()
        local _time = os.date "*t"
        return (_time.hour >= 1 and _time.hour < 9) and lvim.builtin.time_based_themes
      end,
    },
    {
      "catppuccin/nvim",
      as = "catppuccin",
      setup = function()
        vim.g.catppuccin_flavour = "mocha"
      end,
      config = function()
        require("user.theme").catppuccin()
        vim.cmd [[colorscheme catppuccin]]
      end,
      cond = function()
        local _time = os.date "*t"
        return (_time.hour >= 17 and _time.hour < 21) and lvim.builtin.time_based_themes
      end,
    },
    {
      "rebelot/kanagawa.nvim",
      config = function()
        require("user.theme").kanagawa()
        vim.cmd [[colorscheme kanagawa]]
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
          use_diagnostic_signs = true,
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
      config = function()
        require("user.symbols_outline").config()
      end,
      event = "BufReadPost",
      disable = lvim.builtin.tag_provider ~= "symbols-outline",
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
        require("user.dapui").config()
      end,
      ft = { "python", "rust", "go" },
      event = "BufReadPost",
      requires = { "mfussenegger/nvim-dap" },
      disable = not lvim.builtin.dap.active,
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
      "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
      config = function()
        require("lsp_lines").setup()
      end,
      event = "BufRead",
      disable = not lvim.builtin.lsp_lines,
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
      event = "InsertEnter",
      requires = "nvim-treesitter/nvim-treesitter",
    },
    {
      "vim-test/vim-test",
      cmd = { "TestNearest", "TestFile", "TestSuite", "TestLast", "TestVisit" },
      config = function()
        require("user.vim_test").config()
      end,
      disable = not (lvim.builtin.test_runner.active and lvim.builtin.test_runner.runner == "ultest"),
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
      opt = true,
      event = { "BufReadPre", "BufNew" },
      config = function()
        require("user.tss").config()
      end,
    },
    {
      "lervag/vimtex",
      ft = "tex",
    },
    {
      "nvim-neotest/neotest",
      config = function()
        require("user.ntest").config()
      end,
      requires = {
        { "nvim-neotest/neotest-go" },
        { "nvim-neotest/neotest-python" },
        { "nvim-neotest/neotest-plenary" },
        { "rouge8/neotest-rust" },
      },
      -- opt = true,
      -- event = { "BufEnter *_test.*,*_spec.*,test_*.*" },
      disable = not (lvim.builtin.test_runner.active and lvim.builtin.test_runner.runner == "neotest"),
    },
    {
      "rcarriga/vim-ultest",
      cmd = { "Ultest", "UltestSummary", "UltestNearest" },
      wants = "vim-test",
      requires = { "vim-test/vim-test" },
      run = ":UpdateRemotePlugins",
      opt = true,
      event = { "BufEnter *_test.*,*_spec.*,*est_*.*" },
      disable = not (lvim.builtin.test_runner.active and lvim.builtin.test_runner.runner == "ultest"),
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
      setup = function()
        vim.g.db_ui_use_nerd_fonts = 1
        vim.g.db_ui_show_database_icon = 1
      end,
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
          hide_cursor = true,
        }
      end,
      event = "BufRead",
      disable = lvim.builtin.smooth_scroll ~= "neoscroll",
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
      disable = lvim.builtin.smooth_scroll ~= "cinnamon",
    },
    {
      "github/copilot.vim",
      config = function()
        require("user.copilot").config()
      end,
      disable = not lvim.builtin.sell_your_soul_to_devil.active or lvim.builtin.sell_your_soul_to_devil.prada,
    },
    {
      "zbirenbaum/copilot.lua",
      after = "nvim-cmp",
      requires = { "zbirenbaum/copilot-cmp" },
      config = function()
        local cmp_source = { name = "copilot", group_index = 2 }
        table.insert(lvim.builtin.cmp.sources, cmp_source)
        vim.defer_fn(function()
          require("copilot").setup()
        end, 100)
      end,
      disable = not lvim.builtin.sell_your_soul_to_devil.prada,
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
        require("user.filetype").config()
      end,
    },
    {
      "abzcoding/nvim-mini-file-icons",
      config = function()
        require("user.dev_icons").set_icon()
      end,
      disable = lvim.use_icons or not lvim.builtin.custom_web_devicons,
    },
    {
      "nvim-telescope/telescope-live-grep-args.nvim",
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
      disable = lvim.builtin.task_runner ~= "async_tasks",
    },
    {
      "scalameta/nvim-metals",
      requires = { "nvim-lua/plenary.nvim" },
      disable = not lvim.builtin.metals.active,
    },
    {
      "jbyuki/instant.nvim",
      event = "BufRead",
      disable = not lvim.builtin.collaborative_editing.active,
    },
    {
      "nvim-telescope/telescope-file-browser.nvim",
      disable = not lvim.builtin.file_browser.active,
    },
    {
      "j-hui/fidget.nvim",
      config = function()
        require("user.fidget_spinner").config()
      end,
    },
    {
      "michaelb/sniprun",
      run = "bash ./install.sh",
      disable = not lvim.builtin.sniprun.active,
    },
    {
      "liuchengxu/vista.vim",
      setup = function()
        require("user.vista").config()
      end,
      event = "BufReadPost",
      disable = lvim.builtin.tag_provider ~= "vista",
    },
    {
      "p00f/clangd_extensions.nvim",
      config = function()
        require("user.cle").config()
      end,
      ft = { "c", "cpp", "objc", "objcpp" },
    },
    {
      "editorconfig/editorconfig-vim",
      event = "BufRead",
      disable = not lvim.builtin.editorconfig.active,
    },
    {
      "saecki/crates.nvim",
      event = { "BufRead Cargo.toml" },
      requires = { { "nvim-lua/plenary.nvim" } },
      config = function()
        require("user.crates").config()
      end,
    },
    {
      "hrsh7th/cmp-cmdline",
      disable = not lvim.builtin.fancy_wild_menu.active,
    },
    {
      "mrjones2014/legendary.nvim",
      config = function()
        require("user.legendary").config()
      end,
      disable = not lvim.builtin.legendary.active,
    },
    {
      "stevearc/dressing.nvim",
      config = function()
        require("user.dress").config()
      end,
      disable = not lvim.builtin.dressing.active,
      event = "BufWinEnter",
    },
    {
      "kdheepak/cmp-latex-symbols",
      requires = "hrsh7th/nvim-cmp",
      ft = "tex",
    },
    {
      "ThePrimeagen/refactoring.nvim",
      ft = { "typescript", "javascript", "lua", "c", "cpp", "go", "python", "java", "php" },
      event = "BufRead",
      config = function()
        require("refactoring").setup {}
      end,
      disable = not lvim.builtin.refactoring.active,
    },
    {
      "b0o/incline.nvim",
      config = function()
        require("user.incline").config()
      end,
      disable = lvim.builtin.winbar_provider ~= "filename",
    },
    {
      "fgheng/winbar.nvim",
      config = function()
        require("user.winb").config()
      end,
      event = { "InsertEnter", "CursorMoved" },
      disable = lvim.builtin.winbar_provider ~= "treesitter",
    },
    {
      "SmiteshP/nvim-gps",
      module_pattern = { "gps", "nvim-gps" },
      config = function()
        require("user.gps").config()
      end,
      requires = "nvim-treesitter/nvim-treesitter",
      event = { "InsertEnter", "CursorMoved" },
      disable = lvim.builtin.winbar_provider ~= "treesitter",
    },
    {
      "vimpostor/vim-tpipeline",
      disable = not lvim.builtin.tmux_lualine,
    },
    {
      "stevearc/overseer.nvim",
      config = function()
        require("user.ovs").config()
      end,
      disable = lvim.builtin.task_runner ~= "overseer",
    },
    {
      "nvim-neo-tree/neo-tree.nvim",
      branch = "v2.x",
      requires = {
        "MunifTanjim/nui.nvim",
      },
      config = function()
        require("user.neotree").config()
      end,
      disable = lvim.builtin.tree_provider ~= "neo-tree",
    },
    -- TODO: set this up when https://github.com/neovim/neovim/pull/20130 is merged
    -- {
    --   "lvimuser/lsp-inlayhints.nvim",
    --   branch = "anticonceal",
    --   config = function()
    --     require("lsp-inlayhints").setup()
    --   end,
    -- },
  }
end

return M
