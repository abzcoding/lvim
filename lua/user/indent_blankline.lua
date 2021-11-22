local M = {}

M.config = function()
  local status_ok, bl = pcall(require, "indent_blankline")
  if not status_ok then
    return
  end

  bl.setup {
    enabled = true,
    bufname_exclude = { "README.md" },
    buftype_exclude = { "terminal", "nofile" },
    filetype_exclude = {
      "alpha",
      "log",
      "gitcommit",
      "dapui_scopes",
      "dapui_stacks",
      "dapui_watches",
      "dapui_breakpoints",
      "dapui_hover",
      "LuaTree",
      "dbui",
      "UltestSummary",
      "UltestOutput",
      "vimwiki",
      "markdown",
      "json",
      "txt",
      "vista",
      "NvimTree",
      "git",
      "TelescopePrompt",
      "undotree",
      "flutterToolsOutline",
      "org",
      "orgagenda",
      "help",
      "startify",
      "dashboard",
      "packer",
      "neogitstatus",
      "NvimTree",
      "Outline",
      "Trouble",
      "lspinfo",
      "", -- for all buffers without a file type
    },
    -- char = "▏",
    char_list = { "", "┊", "┆", "¦", "|", "¦", "┆", "┊", "" },
    show_trailing_blankline_indent = false,
    show_first_indent_level = false,
    space_char_blankline = " ",
    use_treesitter = true,
    show_foldtext = false,
    show_current_context = true,
    show_current_context_start = false,
    context_patterns = {
      "class",
      "return",
      "function",
      "method",
      "^if",
      "^do",
      "^switch",
      "^while",
      "jsx_element",
      "^for",
      "^object",
      "^table",
      "block",
      "arguments",
      "if_statement",
      "else_clause",
      "jsx_element",
      "jsx_self_closing_element",
      "try_statement",
      "catch_clause",
      "import_statement",
      "operation_type",
    },
  }
  -- HACK: work-around for https://github.com/lukas-reineke/indent-blankline.nvim/issues/59
  vim.wo.colorcolumn = "99999"
end

return M
