local M = {}

M.config = function()
  local tree_icons = require("user.lsp_kind").nvim_tree_icons
  require("neo-tree").setup {
    popup_border_style = "rounded",
    enable_diagnostics = false,
    source_selector = {
      winbar = true,
      separator_active = " ",
      statusline = false,
    },
    enable_git_status = true,
    git_status_async = true,
    nesting_rules = {
      ["dart"] = { "freezed.dart", "g.dart" },
    },
    default_component_configs = {
      indent = {
        padding = 0,
        with_expanders = false,
      },
      icon = {
        folder_closed = tree_icons.folder.default,
        folder_open = tree_icons.folder.open,
        folder_empty = tree_icons.folder.empty_open,
      },
      modified = {
        symbol = " ",
      },
      git_status = {
        symbols = tree_icons.git,
      },
    },
    window = {
      position = "left",
      width = 30,
    },
    filesystem = {
      group_empty_dirs = true,
      filtered_items = {
        visible = false,
        hide_dotfiles = true,
        hide_gitignored = false,
        hide_by_name = {
          ".DS_Store",
          "thumbs.db",
          "node_modules",
          "__pycache__",
        },
        never_show = {
          ".DS_Store",
        },
      },
      window = {
        mappings = {
          ["h"] = "navigate_up",
          ["l"] = "open",
        },
      },
      follow_current_file = true,
      hijack_netrw_behavior = "open_current",
      use_libuv_file_watcher = true,
    },
    git_status = {
      window = {
        position = "float",
      },
    },
    event_handlers = {
      {
        event = "vim_buffer_enter",
        handler = function(_)
          if vim.bo.filetype == "neo-tree" then
            vim.wo.signcolumn = "auto"
          end
        end,
      },
    },
  }
end

return M
