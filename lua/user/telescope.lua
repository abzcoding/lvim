local M = {}
-- local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
local themes = require "telescope.themes"
local builtin = require "telescope.builtin"
local actions = require "telescope.actions"

function M._multiopen(prompt_bufnr, open_cmd)
  local picker = action_state.get_current_picker(prompt_bufnr)
  local num_selections = table.getn(picker:get_multi_selection())
  local border_contents = picker.prompt_border.contents[1]
  if not (string.find(border_contents, "Find Files") or string.find(border_contents, "Git Files")) then
    actions.select_default(prompt_bufnr)
    return
  end
  if num_selections > 1 then
    vim.cmd "bw!"
    for _, entry in ipairs(picker:get_multi_selection()) do
      vim.cmd(string.format("%s %s", open_cmd, entry.value))
    end
    vim.cmd "stopinsert"
  else
    if open_cmd == "vsplit" then
      actions.file_vsplit(prompt_bufnr)
    elseif open_cmd == "split" then
      actions.file_split(prompt_bufnr)
    elseif open_cmd == "tabe" then
      actions.file_tab(prompt_bufnr)
    else
      actions.file_edit(prompt_bufnr)
    end
  end
end
function M.multi_selection_open_vsplit(prompt_bufnr)
  M._multiopen(prompt_bufnr, "vsplit")
end
function M.multi_selection_open_split(prompt_bufnr)
  M._multiopen(prompt_bufnr, "split")
end
function M.multi_selection_open_tab(prompt_bufnr)
  M._multiopen(prompt_bufnr, "tabe")
end
function M.multi_selection_open(prompt_bufnr)
  M._multiopen(prompt_bufnr, "edit")
end

-- beautiful default layout for telescope prompt
function M.layout_config()
  return {
    width = 0.90,
    height = 0.85,
    preview_cutoff = 120,
    prompt_position = "bottom",
    horizontal = {
      preview_width = function(_, cols, _)
        return math.floor(cols * 0.6)
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

-- another file string search
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
    file_ignore_patterns = {
      "vendor/*",
      "node_modules",
      "%.jpg",
      "%.jpeg",
      "%.png",
      "%.svg",
      "%.otf",
      "%.ttf",
    },
  }
  builtin.live_grep(opts)
end

-- show refrences to this using language server
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

-- show implementations of the current thingy using language server
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

-- find files in the upper directory
function M.find_updir()
  local up_dir = vim.fn.getcwd():gsub("(.*)/.*$", "%1")
  local opts = {
    cwd = up_dir,
  }

  builtin.find_files(opts)
end

function M.installed_plugins()
  builtin.find_files {
    cwd = join_paths(os.getenv "LUNARVIM_RUNTIME_DIR", "site", "pack", "packer"),
  }
end

function M.project_search()
  builtin.find_files {
    previewer = false,
    layout_strategy = "vertical",
    cwd = require("lspconfig/util").root_pattern ".git"(vim.fn.expand "%:p"),
  }
end

function M.curbuf()
  local opts = themes.get_dropdown {
    winblend = 10,
    previewer = false,
    shorten_path = false,
    borderchars = {
      prompt = { "─", "│", " ", "│", "╭", "╮", "│", "│" },
      results = { "─", "│", "─", "│", "├", "┤", "╯", "╰" },
      preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    },
    border = {},
    layout_config = {
      width = 0.45,
      prompt_position = "top",
    },
  }
  builtin.current_buffer_fuzzy_find(opts)
end

function M.git_status()
  local opts = themes.get_dropdown {
    winblend = 10,
    previewer = false,
    shorten_path = false,
    borderchars = {
      prompt = { "─", "│", " ", "│", "╭", "╮", "│", "│" },
      results = { "─", "│", "─", "│", "├", "┤", "╯", "╰" },
      preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    },
    border = {},
    layout_config = {
      width = 0.45,
      prompt_position = "top",
    },
  }

  -- Can change the git icons using this.
  -- opts.git_icons = {
  --   changed = "M"
  -- }

  builtin.git_status(opts)
end

function M.search_only_certain_files()
  builtin.find_files {
    find_command = {
      "rg",
      "--files",
      "--type",
      vim.fn.input "Type: ",
    },
  }
end

function M.builtin()
  builtin.builtin()
end

function M.git_files()
  local path = vim.fn.expand "%:h"
  if path == "" then
    path = nil
  end

  local width = 0.45
  if path and string.find(path, "sourcegraph.*sourcegraph", 1, false) then
    width = 0.6
  end

  local opts = themes.get_dropdown {
    winblend = 5,
    previewer = false,
    shorten_path = false,
    borderchars = {
      prompt = { "─", "│", " ", "│", "╭", "╮", "│", "│" },
      results = { "─", "│", "─", "│", "├", "┤", "╯", "╰" },
      preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    },
    border = {},
    cwd = path,
    layout_config = {
      width = width,
      prompt_position = "top",
    },
  }

  opts.file_ignore_patterns = {
    "^[.]vale/",
  }
  builtin.git_files(opts)
end

function M.grep_string_visual()
  local visual_selection = function()
    local save_previous = vim.fn.getreg "a"
    vim.api.nvim_command 'silent! normal! "ay'
    local selection = vim.fn.trim(vim.fn.getreg "a")
    vim.fn.setreg("a", save_previous)
    return vim.fn.substitute(selection, [[\n]], [[\\n]], "g")
  end
  require("telescope.builtin").live_grep {
    default_text = visual_selection(),
  }
end

return M
