local M = {}

M.setup = function()
  local status_ok, ibl = pcall(require, "ibl")
  if not status_ok then
    return
  end
  ibl.setup {
    indent = {
      char = { "", "┊", "┆", "¦", "|", "¦", "┆", "┊", "" },
    },
    exclude = {
      buftype = { "terminal", "nofile" },
      filetype = {
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
        "lazy",
        "neogitstatus",
        "Outline",
        "Trouble",
        "lspinfo",
        "", -- for all buffers without a file type
      },
    },
    scope = {
      enabled = true,
    },
  }
end

M.config = function()
  lvim.builtin.indentlines.options = {
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
      "lazy",
      "neogitstatus",
      "Outline",
      "Trouble",
      "lspinfo",
      "", -- for all buffers without a file type
    },
    -- char = "▏",
    char_list = { "", "┊", "┆", "¦", "|", "¦", "┆", "┊", "" },
    char_highlight_list = {
      "IndentBlanklineIndent1",
      "IndentBlanklineIndent1",
      "IndentBlanklineIndent1",
      "IndentBlanklineIndent1",
      "IndentBlanklineIndent1",
      "IndentBlanklineIndent1",
    },
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
end

M.enable = function()
  if lvim.builtin.indentlines.mine then
    require("ibl").setup_buffer(0, { enabled = true })
  elseif lvim.builtin.indentlines.active then
    vim.cmd [[IndentBlanklineEnable!]]
  end
end

M.disable = function()
  if lvim.builtin.indentlines.mine then
    require("ibl").setup_buffer(0, { enabled = false })
  elseif lvim.builtin.indentlines.active then
    vim.cmd [[IndentBlanklineDisable!]]
  end
end

return M
