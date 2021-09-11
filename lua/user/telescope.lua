local M = {}
-- local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
local themes = require "telescope.themes"
local builtin = require "telescope.builtin"

function M.layout_config()
  return {
    width = 0.90,
    height = 0.85,
    preview_cutoff = 120,
    prompt_position = "bottom",
    horizontal = {
      preview_width = function(_, cols, _)
        if cols > 200 then
          return math.floor(cols * 0.5)
        else
          return math.floor(cols * 0.6)
        end
      end,
    },
    vertical = {
      width = 0.9,
      height = 0.95,
      preview_height = 0.5,
    },

    flex = {
      horizontal = {
        preview_width = 0.9,
      },
    },
  }
end

function M.find_string()
  local opts = {
    border = true,
    previewer = false,
    shorten_path = false,
    layout_strategy = "flex",
    layout_config = {
      width = 0.9,
      height = 0.8,
      horizontal = { width = { padding = 0.15 } },
      vertical = { preview_height = 0.75 },
    },
    file_ignore_patterns = { "vendor/*" },
  }
  builtin.live_grep(opts)
end

function M.file_browser()
  local opts

  opts = {
    sorting_strategy = "ascending",
    scroll_strategy = "cycle",
    layout_config = {
      prompt_position = "top",
    },
    file_ignore_patterns = { "vendor/*" },

    attach_mappings = function(prompt_bufnr, map)
      local current_picker = action_state.get_current_picker(prompt_bufnr)

      local modify_cwd = function(new_cwd)
        current_picker.cwd = new_cwd
        current_picker:refresh(opts.new_finder(new_cwd), { reset_prompt = true })
      end

      map("i", "-", function()
        modify_cwd(current_picker.cwd .. "/..")
      end)

      map("i", "~", function()
        modify_cwd(vim.fn.expand "~")
      end)

      local modify_depth = function(mod)
        return function()
          opts.depth = opts.depth + mod

          local this_picker = action_state.get_current_picker(prompt_bufnr)
          this_picker:refresh(opts.new_finder(current_picker.cwd), { reset_prompt = true })
        end
      end

      map("i", "<M-=>", modify_depth(1))
      map("i", "<M-+>", modify_depth(-1))

      map("n", "yy", function()
        local entry = action_state.get_selected_entry()
        vim.fn.setreg("+", entry.value)
      end)

      return true
    end,
  }

  builtin.file_browser(opts)
end

function M.code_actions()
  local opts = {
    winblend = 10,
    border = true,
    previewer = false,
    shorten_path = false,
  }
  builtin.lsp_code_actions(themes.get_dropdown(opts))
end

function M.lsp_references()
  local opts = {
    layout_strategy = "vertical",
    layout_config = {
      prompt_position = "top",
    },
    sorting_strategy = "ascending",
    ignore_filename = false,
  }
  builtin.lsp_references(opts)
end

function M.lsp_implementations()
  local opts = {
    layout_strategy = "vertical",
    layout_config = {
      prompt_position = "top",
    },
    sorting_strategy = "ascending",
    ignore_filename = false,
  }
  builtin.lsp_implementations(opts)
end

return M
