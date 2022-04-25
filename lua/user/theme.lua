local M = {}

M.tokyonight = function()
  vim.g.tokyonight_dev = true
  vim.g.tokyonight_style = "storm"
  vim.g.tokyonight_sidebars = {
    "qf",
    "vista_kind",
    "terminal",
    "packer",
    "spectre_panel",
    "NeogitStatus",
    "help",
  }
  vim.g.tokyonight_cterm_colors = false
  vim.g.tokyonight_terminal_colors = true
  vim.g.tokyonight_italic_comments = false
  vim.g.tokyonight_italic_keywords = true
  vim.g.tokyonight_italic_functions = false
  vim.g.tokyonight_italic_variables = false
  vim.g.tokyonight_transparent = lvim.transparent_window
  vim.g.tokyonight_hide_inactive_statusline = true
  vim.g.tokyonight_dark_sidebar = true
  vim.g.tokyonight_dim_inactive = true
  vim.g.tokyonight_global_status = true
  vim.g.tokyonight_dark_float = true
  vim.g.tokyonight_colors = { git = { change = "#6183bb", add = "#449dab", delete = "#f7768e", conflict = "#bb7a61" } }
  local _time = os.date "*t"
  if _time.hour < 8 then
    vim.g.tokyonight_style = "night"
  end
end

M.rose_pine = function()
  require("rose-pine").setup {
    ---@usage 'main'|'moon'
    dark_variant = "main",
    bold_vert_split = false,
    dim_nc_background = lvim.builtin.global_statusline,
    disable_background = lvim.transparent_window,
    disable_float_background = true,
    disable_italics = true,
    ---@usage string hex value or named color from rosepinetheme.com/palette
    groups = {
      border = "highlight_med",
      comment = "muted",
      link = "iris",
      punctuation = "subtle",

      error = "love",
      hint = "iris",
      info = "foam",
      warn = "gold",

      headings = {
        h1 = "iris",
        h2 = "foam",
        h3 = "rose",
        h4 = "gold",
        h5 = "pine",
        h6 = "foam",
      },
    },
    highlight_groups = {
      Boolean = { fg = "love" },
    },
  }
end

M.catppuccin = function()
  local catppuccin = require "catppuccin"
  catppuccin.setup {
    transparent_background = lvim.transparent_window,
    term_colors = false,
    styles = {
      comments = "NONE",
      functions = "NONE",
      keywords = "italic",
      strings = "NONE",
      variables = "NONE",
    },
    integrations = {
      treesitter = true,
      native_lsp = {
        enabled = true,
        virtual_text = {
          errors = "italic",
          hints = "italic",
          warnings = "italic",
          information = "italic",
        },
        underlines = {
          errors = "underline",
          hints = "underline",
          warnings = "underline",
          information = "underline",
        },
      },
      lsp_trouble = true,
      cmp = true,
      lsp_saga = false,
      gitgutter = false,
      gitsigns = true,
      telescope = true,
      nvimtree = {
        enabled = true,
        show_root = false,
        transparent_panel = lvim.transparent_window,
      },
      which_key = true,
      indent_blankline = {
        enabled = true,
        colored_indent_levels = false,
      },
      dashboard = true,
      neogit = false,
      vim_sneak = false,
      fern = false,
      barbar = false,
      bufferline = true,
      markdown = true,
      lightspeed = lvim.builtin.motion_provider == "lightspeed",
      ts_rainbow = false,
      hop = lvim.builtin.motion_provider == "hop",
      notify = true,
      telekasten = true,
      symbols_outline = true,
    },
  }
end

M.kanagawa = function()
  local kanagawa = require "kanagawa"
  kanagawa.setup {
    undercurl = true, -- enable undercurls
    commentStyle = "NONE",
    functionStyle = "NONE",
    keywordStyle = "italic",
    statementStyle = "italic",
    typeStyle = "NONE",
    variablebuiltinStyle = "italic",
    specialReturn = true, -- special highlight for the return keyword
    specialException = true, -- special highlight for exception handling keywords
    dimInactive = lvim.builtin.global_statusline, -- dim inactive window `:h hl-NormalNC`
    globalStatus = lvim.builtin.global_statusline, -- adjust window separators highlight for laststatus=3
    transparent = lvim.transparent_window,
    colors = { sumiInk1b = "#1b1b23" },
    overrides = {
      diffRemoved = { fg = "#E46876" },
    },
  }
end

M.colors = {
  tokyonight_colors = {
    none = "NONE",
    bg_dark = "#1f2335",
    bg_alt = "#1f2335",
    bg = "#1a1b26",
    bg_br = "#292e42",
    terminal_black = "#414868",
    fg = "#c0caf5",
    fg_dark = "#a9b1d6",
    fg_gutter = "#3b4261",
    dark3 = "#545c7e",
    comment = "#565f89",
    dark5 = "#737aa2",
    blue0 = "#3d59a1",
    blue = "#7aa2f7",
    cyan = "#7dcfff",
    blue1 = "#2ac3de",
    blue2 = "#0db9d7",
    blue5 = "#89ddff",
    blue6 = "#B4F9F8",
    blue7 = "#394b70",
    violet = "#bb9af7",
    magenta = "#bb9af7",
    magenta2 = "#ff007c",
    purple = "#9d7cd8",
    orange = "#ff9e64",
    yellow = "#e0af68",
    green = "#9ece6a",
    green1 = "#73daca",
    green2 = "#41a6b5",
    teal = "#1abc9c",
    red = "#f7768e",
    red1 = "#db4b4b",
    -- git = { change = "#6183bb", add = "#449dab", delete = "#914c54", conflict = "#bb7a61" },
    git = { change = "#6183bb", add = "#449dab", delete = "#f7768e", conflict = "#bb7a61" },
    gitSigns = { add = "#164846", change = "#394b70", delete = "#823c41" },
  },

  rose_pine_colors = {
    none = "NONE",
    bg = "#2a273f",
    fg = "#e0def4",
    fg_gutter = "#3b4261",
    black = "#393b44",
    gray = "#2a2e36",
    red = "#eb6f92",
    green = "#97c374",
    yellow = "#f6c177",
    blue = "#9ccfd8",
    magenta = "#c4a7e7",
    cyan = "#9ccfd8",
    white = "#dfdfe0",
    orange = "#ea9a97",
    pink = "#D67AD2",
    black_br = "#7f8c98",
    red_br = "#e06c75",
    green_br = "#58cd8b",
    yellow_br = "#FFE37E",
    bg_br = "#393552",
    blue_br = "#84CEE4",
    violet = "#B8A1E3",
    cyan_br = "#59F0FF",
    white_br = "#FDEBC3",
    orange_br = "#F6A878",
    pink_br = "#DF97DB",
    comment = "#526175",
    bg_alt = "#191724",
    git = {
      add = "#84Cee4",
      change = "#c4a7e7",
      delete = "#eb6f92",
      conflict = "#f6c177",
    },
  },

  catppuccin_colors = {
    rosewater = "#F5E0DC",
    flamingo = "#F2CDCD",
    violet = "#DDB6F2",
    pink = "#F5C2E7",
    red = "#F28FAD",
    maroon = "#E8A2AF",
    orange = "#F8BD96",
    yellow = "#FAE3B0",
    green = "#ABE9B3",
    blue = "#96CDFB",
    cyan = "#89DCEB",
    teal = "#B5E8E0",
    lavender = "#C9CBFF",
    white = "#D9E0EE",
    gray2 = "#C3BAC6",
    gray1 = "#988BA2",
    gray0 = "#6E6C7E",
    black4 = "#575268",
    bg_br = "#302D41",
    bg = "#1A1826",
    bg_alt = "#1E1E2E",
    fg = "#D9E0EE",
    black = "#1A1826",
    git = {
      add = "#ABE9B3",
      change = "#96CDFB",
      delete = "#F28FAD",
      conflict = "#FAE3B0",
    },
  },

  kanagawa_colors = {
    bg = "#16161D",
    bg_alt = "#1F1F28",
    bg_br = "#363646",
    fg = "#DCD7BA",
    red = "#E46876",
    orange = "#FFA066",
    yellow = "#DCA561",
    blue = "#7FB4CA",
    cyan = "#658594",
    violet = "#957FB8",
    magenta = "#938AA9",
    green = "#76946A",
    git = {
      add = "#76946A",
      conflict = "#252535",
      delete = "#C34043",
      change = "#DCA561",
    },
  },
}

M.current_colors = function()
  local colors = M.colors.tokyonight_colors
  local _time = os.date "*t"
  if _time.hour >= 1 and _time.hour < 9 then
    colors = M.colors.rose_pine_colors
  elseif _time.hour >= 9 and _time.hour < 17 then
    colors = M.colors.tokyonight_colors
  elseif _time.hour >= 17 and _time.hour < 21 then
    colors = M.colors.catppuccin_colors
  elseif (_time.hour >= 21 and _time.hour < 24) or (_time.hour >= 0 and _time.hour < 1) then
    colors = M.colors.kanagawa_colors
  end
  return colors
end

M.hi_colors = function()
  local colors = {
    bg = "#16161D",
    bg_alt = "#1F1F28",
    fg = "#DCD7BA",
    green = "#76946A",
    red = "#E46876",
  }
  local color_binds = {
    bg = { group = "NormalFloat", property = "background" },
    bg_alt = { group = "Cursor", property = "foreground" },
    fg = { group = "Cursor", property = "background" },
    green = { group = "diffAdded", property = "foreground" },
    red = { group = "diffRemoved", property = "foreground" },
  }
  local function get_hl_by_name(name)
    local ret = vim.api.nvim_get_hl_by_name(name.group, true)
    return string.format("#%06x", ret[name.property])
  end
  for k, v in pairs(color_binds) do
    local found, color = pcall(get_hl_by_name, v)
    if found then
      colors[k] = color
    end
  end
  return colors
end

M.telescope_theme = function()
  local function set_bg(group, bg)
    vim.cmd("hi " .. group .. " guibg=" .. bg)
  end

  local function set_fg_bg(group, fg, bg)
    vim.cmd("hi " .. group .. " guifg=" .. fg .. " guibg=" .. bg)
  end

  local colors = M.hi_colors()
  -- set_fg_bg("WinSeparator", colors.bg, "None")
  set_fg_bg("NormalFloat", colors.fg, colors.bg)
  set_fg_bg("FloatBorder", colors.fg, colors.bg)
  set_fg_bg("TelescopeBorder", colors.bg_alt, colors.bg)
  set_fg_bg("TelescopePromptBorder", colors.bg, colors.bg)
  set_fg_bg("TelescopePromptNormal", colors.fg, colors.bg_alt)
  set_fg_bg("TelescopePromptPrefix", colors.red, colors.bg)
  set_bg("TelescopeNormal", colors.bg)
  set_fg_bg("TelescopePreviewTitle", colors.bg, colors.green)
  set_fg_bg("LvimInfoHeader", colors.bg, colors.green)
  set_fg_bg("LvimInfoIdentifier", colors.red, colors.bg_alt)
  set_fg_bg("TelescopePromptTitle", colors.bg, colors.red)
  set_fg_bg("TelescopeResultsTitle", colors.bg, colors.bg)
  set_fg_bg("TelescopeResultsBorder", colors.bg, colors.bg)
  set_bg("TelescopeSelection", colors.bg_alt)
end

return M
