-- credit: https://github.com/LinArcX
local themes = require "telescope.themes"
local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local actions = require "telescope.actions"
local conf = require("telescope.config").values
local action_state = require "telescope.actions.state"
local entry_display = require "telescope.pickers.entry_display"

local categories
lvim.builtin.cpmenu = lvim.builtin.cpmenu or {}

function themes.vscode(opts)
  opts = opts or {}
  local theme_opts = {
    theme = "dropdown",
    results_title = false,
    sorting_strategy = "ascending",
    layout_strategy = "vertical",
    layout_config = {
      anchor = "N",
      prompt_position = "top",
      width = function(_, max_columns, _)
        return math.min(max_columns, 120)
      end,
      height = function(_, _, max_lines)
        return math.min(max_lines, 15)
      end,
    },
  }
  if opts.layout_config and opts.layout_config.prompt_position == "bottom" then
    theme_opts.borderchars = {
      prompt = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
      results = { "─", "│", "─", "│", "╭", "╮", "┤", "├" },
      preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    }
  end
  return vim.tbl_deep_extend("force", theme_opts, opts)
end

local function tableLength(T)
  local count = 0
  for _ in pairs(T) do
    count = count + 1
  end
  return count
end

local function listOfCategories()
  Results = {}
  for i = tableLength(lvim.builtin.cpmenu), 1, -1 do
    Results[i] = lvim.builtin.cpmenu[i][1]
  end
  return Results
end

local function listOfCommands(index)
  local results = {}
  local j = 1
  for i = tableLength(lvim.builtin.cpmenu[index]), 2, -1 do
    results[j] = lvim.builtin.cpmenu[index][i]
    j = j + 1
  end
  return results
end

-- picker: commands
local function commands(opts, table)
  opts = opts or {}
  pickers.new(opts, {
    prompt_title = opts.commands_title,
    finder = finders.new_table {
      results = table,
      entry_maker = function(entry)
        local cols = vim.o.columns
        local width = conf.width or conf.layout_config.width or conf.layout_config[conf.layout_strategy].width or cols
        local tel_win_width
        -- width = 80 -> column width, width = 0.7 -> ratio
        if width > 1 then
          tel_win_width = width
        else
          tel_win_width = math.floor(cols * width)
        end
        local desc_width = math.floor(cols * 0.05)
        local command_width = 28

        -- NOTE: the width calculating logic is not exact, but approx enough
        local displayer = entry_display.create {
          separator = " ▏",
          items = {
            { width = command_width },
            { width = tel_win_width - desc_width - command_width },
            { remaining = true },
          },
        }

        local function make_display(_)
          return displayer {
            { entry[1] },
            { entry[2] },
          }
        end

        return {
          value = entry,
          display = make_display,
          ordinal = string.format("%s %s", entry[1], entry[2]),
        }
      end,
    },
    sorter = conf.generic_sorter(opts),
    attach_mappings = function(prompt_bufnr, map)
      map("i", "<C-b>", function(_)
        categories(require("telescope.themes").vscode {})
      end)
      map("n", "<C-b>", function(_)
        categories(require("telescope.themes").vscode {})
      end)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        -- temporarily workaround for issue: 1599.
        local selection = action_state.get_selected_entry()
        if selection.value[3] == 1 then
          vim.schedule(function()
            vim.cmd "startinsert! "
          end)
        end
        vim.api.nvim_exec(selection.value[2], true)
      end)
      return true
    end,
  }):find()
end

categories = function(opts)
  opts = opts or {}
  pickers.new(opts, {
    prompt_title = "categories",
    finder = finders.new_table {
      results = listOfCategories(),
    },
    sorter = conf.generic_sorter(opts),
    attach_mappings = function(prompt_bufnr, _)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        -- temporarily workaround for issue: 1599.
        vim.schedule(function()
          vim.cmd "startinsert! "
        end)
        local selection = action_state.get_selected_entry()
        opts.commands_title = selection[1]
        commands(opts, listOfCommands(selection.index))
      end)
      return true
    end,
  }):find()
end

local function run()
  categories(require("telescope.themes").vscode {})
end

return require("telescope").register_extension {
  exports = {
    -- Default when to argument is given, i.e. :Telescope command_palette
    command_palette = run,
  },
}
