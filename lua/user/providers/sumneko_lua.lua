local luadev = require("lua-dev").setup {
  library = {
    vimruntime = true, -- runtime path
    types = true, -- full signature, docs and completion of vim.api, vim.treesitter, vim.lsp and others
    plugins = false, -- installed opt or start plugins in packpath
    -- you can also specify the list of plugins to make available as a workspace library
    -- plugins = { "nvim-treesitter", "plenary.nvim", "telescope.nvim" },
  },
  lspconfig = {
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim", "lvim" },
        },
        workspace = {
          library = {
            [require("utils").join_paths(get_runtime_dir(), "lvim", "lua")] = true,
            [vim.fn.expand "$VIMRUNTIME/lua"] = true,
            [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
          },
          maxPreload = 100000,
          preloadFileSize = 10000,
        },
      },
    },
  },
}

local opts = {
  setup = luadev,
}

return opts
