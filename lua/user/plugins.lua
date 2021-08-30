local M = {}

M.config = function()
  lvim.plugins = {
    {
      "Pocco81/Catppuccino.nvim",
      config = function()
        require("user/theme").catppuccino()
      end,
      cond = function()
        local _time = os.date "*t"
        return (_time.hour >= 7 and _time.hour < 11)
      end,
    },
    {
      "folke/tokyonight.nvim",
      config = function()
        require("user/theme").tokyonight()
        vim.cmd [[
      colorscheme tokyonight
      ]]
      end,
      cond = function()
        local _time = os.date "*t"
        return (_time.hour >= 0 and _time.hour < 7) or (_time.hour >= 11 and _time.hour < 17)
      end,
    },
    {
      "NTBBloodbath/doom-one.nvim",
      config = function()
        vim.g.doom_one_italic_comments = true
        vim.cmd [[
      colorscheme doom-one
      ]]
        -- vim.g.doom_one_terminal_colors = true
      end,
      cond = function()
        local _time = os.date "*t"
        return (_time.hour >= 17 and _time.hour < 21)
      end,
    },
    {
      "abzcoding/zephyr-nvim",
      config = function()
        vim.cmd [[
      colorscheme zephyr
      ]]
      end,
      cond = function()
        local _time = os.date "*t"
        return (_time.hour >= 21 and _time.hour <= 24)
      end,
    },
    {
      "ray-x/lsp_signature.nvim",
      config = function()
        require("user/lsp_signature").config()
      end,
      event = "InsertEnter",
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
        require("todo-comments").setup()
      end,
      event = "BufRead",
    },
    {
      "folke/trouble.nvim",
      requires = "kyazdani42/nvim-web-devicons",
      config = function()
        require("trouble").setup()
      end,
      cmd = "Trouble",
    },
    {
      "phaazon/hop.nvim",
      event = "BufRead",
      config = function()
        require("user.hop").config()
      end,
    },
    {
      "simrat39/symbols-outline.nvim",
      cmd = "SymbolsOutline",
    },
    {
      "lukas-reineke/indent-blankline.nvim",
      setup = function()
        require("user.indent_blankline").setup()
      end,
      event = "BufRead",
    },
    {
      "tzachar/compe-tabnine",
      run = "./install.sh",
      requires = "hrsh7th/nvim-compe",
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
    { "kevinhwang91/nvim-bqf", event = "BufRead" },
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
        require("persistence").setup()
      end,
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
      ft = { "org" },
      config = function()
        require("user.orgmode").setup {}
      end,
      disable = not lvim.builtin.orgmode.active,
    },
    {
      "tamago324/lir.nvim",
      config = function()
        require "user.lir"
      end,
      disable = not lvim.builtin.lir.active,
    },
    {
      "SmiteshP/nvim-gps",
      config = function()
        require("nvim-gps").setup {
          icons = {
            ["class-name"] = " ",
            ["function-name"] = " ",
            ["method-name"] = " ",
          },
          languages = { -- You can disable any language individually here
            ["c"] = true,
            ["cpp"] = true,
            ["go"] = true,
            ["java"] = true,
            ["javascript"] = true,
            ["lua"] = true,
            ["python"] = true,
            ["rust"] = true,
            ["yaml"] = false,
          },
          separator = " > ",
        }
      end,
      disable = not lvim.builtin.fancy_statusline.active,
    },
  }
end

return M
