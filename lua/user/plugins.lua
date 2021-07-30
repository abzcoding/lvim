M = {}

M.config = function()
  lvim.plugins = {
    {
      "folke/tokyonight.nvim",
      config = function()
        vim.g.tokyonight_hide_inactive_statusline = true
        local _time = os.date "*t"
        if _time.hour < 9 then
          vim.g.tokyonight_style = "night"
        end
        vim.cmd [[
      colorscheme tokyonight
      ]]
      end,
      cond = function()
        local _time = os.date "*t"
        return (_time.hour >= 0 and _time.hour < 16)
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
        return (_time.hour >= 16 and _time.hour < 20)
      end,
    },
    {
      "glepnir/zephyr-nvim",
      config = function()
        vim.cmd [[
      colorscheme zephyr
      ]]
      end,
      cond = function()
        local _time = os.date "*t"
        return (_time.hour >= 20 and _time.hour <= 24)
      end,
    },
    {
      "ray-x/lsp_signature.nvim",
      config = function()
        require("lsp_signature").on_attach()
      end,
      event = "InsertEnter",
    },
    {
      "ethanholz/nvim-lastplace",
      config = function()
        require("user.lastplace").config()
      end,
      event = "BufWinEnter",
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
      "sindrets/diffview.nvim",
      cmd = "DiffviewOpen",
    },
    {
      "nvim-telescope/telescope-project.nvim",
      event = "BufWinEnter",
      setup = function()
        vim.cmd [[packadd telescope.nvim]]
      end,
    },
    {
      "lukas-reineke/indent-blankline.nvim",
      setup = function()
        require("user.indent_blankline").setup()
      end,
    },
    { "tzachar/compe-tabnine", run = "./install.sh", requires = "hrsh7th/nvim-compe", event = "InsertEnter" },
    {
      "folke/twilight.nvim",
      config = function()
        require("user.twilight").config()
      end,
      cmd = "ZenMode",
    },
    { "kevinhwang91/nvim-bqf", event = "BufRead" },
    {
      "rcarriga/nvim-dap-ui",
      config = function()
        require("dapui").setup()
      end,
      requires = { "mfussenegger/nvim-dap" },
      ft = "python",
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
    -- {
    --   "andweeb/presence.nvim",
    --   config = function()
    --     require("user.presence").config()
    --   end,
    -- },
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
    },
    {
      "windwp/nvim-spectre",
      event = "BufRead",
      config = function()
        require("user.spectre").config()
      end,
    },
    -- {
    -- 	"folke/persistence.nvim",
    -- 	event = "VimEnter",
    -- 	module = "persistence",
    -- 	config = function()
    -- 		require("persistence").setup({
    -- 			dir = vim.fn.expand(vim.fn.stdpath("config") .. "/session/"),
    -- 			options = { "buffers", "curdir", "tabpages", "winsize" },
    -- 		})
    -- 	end,
    -- },
  }
end

return M
