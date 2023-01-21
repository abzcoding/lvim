local M = {}

M.config = function()
  local status_ok, mnd = pcall(require, "mind")
  if not status_ok then
    return
  end

  local function sep_os_replacer(str)
    local result = str
    local path_sep = package.config:sub(1, 1)
    result = result:gsub("/", path_sep)
    return result
  end
  local join_path = require("lvim.utils").join_paths

  mnd.setup {
    persistence = {
      state_path = sep_os_replacer(join_path(vim.fn.expand(lvim.builtin.mind.root_path), "/mind.json")),
      data_dir = sep_os_replacer(join_path(vim.fn.expand(lvim.builtin.mind.root_path), "/data")),
    },

    ui = {
      width = 40,

      highlight = {
        node_root = "Number",
      },
    },

    keymaps = {
      normal = {
        T = function(args)
          require("mind.ui").with_cursor(function(line)
            local tree = args.get_tree()
            local node = require("mind.node").get_node_by_line(tree, line)

            if node.icon == nil or node.icon == " " then
              node.icon = " "
            elseif node.icon == " " then
              node.icon = " "
            end

            args.save_tree()
            require("mind.ui").rerender(tree, args.opts)
          end)
        end,
      },
    },
  }
end

-- icon_preset = {
--       { ' ', 'Sub-project' },
--       { ' ', 'Journal, newspaper, weekly and daily news' },
--       { ' ', 'For when you have an idea' },
--       { ' ', 'Note taking?' },
--       { '陼', 'Task management' },
--       { ' ', 'Uncheck, empty square or backlog' },
--       { ' ', 'Full square or on-going' },
--       { ' ', 'Check or done' },
--       { ' ', 'Trash bin, deleted, cancelled, etc.' },
--       { ' ', 'GitHub' },
--       { ' ', 'Monitoring' },
--       { ' ', 'Internet, Earth, everyone!' },
--       { ' ', 'Frozen, on-hold' },
--     }

return M
