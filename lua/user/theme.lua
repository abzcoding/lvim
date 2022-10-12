local M = {}

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
      Cursor = { fg = "#232136", bg = "#e0def4" },
      NormalFloat = { bg = "#191724" },
      VertSplit = { fg = "#21202e", bg = "#21202e" },
      SignColumn = { fg = "#e0def4", bg = "NONE" },
      SignColumnSB = { fg = "#e0def4", bg = "NONE" },
      mkdInlineURL = { fg = "#c4a7e7", style = "NONE" },
    },
  }
end

M.catppuccin = function()
  local catppuccin = require "catppuccin"
  local opts = {
    transparent_background = lvim.transparent_window,
    term_colors = false,
    styles = {
      comments = {},
      keywords = { "italic" },
    },
    compile = {
      enabled = true, -- NOTE: make sure to run `:CatppuccinCompile`
      path = vim.fn.stdpath "cache" .. "/catppuccin",
    },
    dim_inactive = {
      enabled = lvim.builtin.global_statusline,
      shade = "dark",
      percentage = 0.15,
    },
    integrations = {
      cmp = true,
      fidget = true,
      lsp_trouble = true,
      telescope = true,
      treesitter = true,
      native_lsp = {
        enabled = true,
        virtual_text = {
          errors = { "italic" },
          hints = {},
          warnings = { "italic" },
          information = {},
        },
        underlines = {
          errors = { "undercurl" },
          hints = {},
          warnings = { "undercurl" },
          information = {},
        },
      },
      dap = {
        enabled = lvim.builtin.dap.active,
        enable_ui = lvim.builtin.dap.active,
      },
      indent_blankline = {
        enabled = true,
        colored_indent_levels = true,
      },
      gitsigns = lvim.builtin.gitsigns.active,
      notify = lvim.builtin.notify.active,
      nvimtree = true,
      neotree = lvim.builtin.tree_provider == "neo-tree",
      overseer = lvim.builtin.task_runner == "overseer",
      symbols_outline = lvim.builtin.tag_provider == "symbols-outline",
      which_key = lvim.builtin.which_key.active,
      lightspeed = lvim.builtin.motion_provider == "lightspeed",
      hop = lvim.builtin.motion_provider == "hop",
    },
    highlight_overrides = {
      mocha = {
        NormalFloat = { fg = "#CDD6F4", bg = "#151521" },
      },
    },
  }
  if lvim.transparent_window then
    local colors = require("catppuccin.palettes").get_palette()
    colors.none = "NONE"
    opts.custom_highlights = {
      Comment = { fg = colors.overlay1 },
      LineNr = { fg = colors.overlay1 },
      CursorLine = { bg = colors.none },
      CursorLineNr = { fg = colors.lavender },
      DiagnosticVirtualTextError = { bg = colors.none },
      DiagnosticVirtualTextWarn = { bg = colors.none },
      DiagnosticVirtualTextInfo = { bg = colors.none },
      DiagnosticVirtualTextHint = { bg = colors.none },
    }
  end
  catppuccin.setup(opts)
end

M.kanagawa = function()
  local kanagawa = require "kanagawa"
  kanagawa.setup {
    undercurl = true, -- enable undercurls
    commentStyle = {},
    functionStyle = {},
    keywordStyle = { italic = true },
    statementStyle = { italic = true },
    typeStyle = {},
    variablebuiltinStyle = { italic = true },
    specialReturn = true, -- special highlight for the return keyword
    specialException = true, -- special highlight for exception handling keywords
    dimInactive = lvim.builtin.global_statusline, -- dim inactive window `:h hl-NormalNC`
    globalStatus = lvim.builtin.global_statusline, -- adjust window separators highlight for laststatus=3
    transparent = lvim.transparent_window,
    colors = { sumiInk1b = "#1b1b23" },
    overrides = {
      diffRemoved = { fg = "#E46876" },
      NvimTreeFolderIcon = { fg = "#7e9cd8" },
    },
  }
end

M.colors = {
  tokyonight_colors = {
    none = "NONE",
    bg_dark = "#1f2335",
    bg_alt = "#1a1b26",
    bg = "#24283b",
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
    bg = "#302D41",
    surface1 = "#302D41",
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
    bg = "#21212A",
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
      conflict = "#DCA561",
      delete = "#E46876",
      change = "#7FB4CA",
    },
  },
}
M.current_colors = function()
  local colors = M.colors.tokyonight_colors
  if not lvim.builtin.time_based_themes then
    return colors
  end
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

  -- NOTE: these are my personal preferences
  if lvim.builtin.time_based_themes then
    local _time = os.date "*t"
    local current_colors = M.current_colors()
    set_fg_bg("CmpBorder", current_colors.bg_alt, current_colors.bg_alt)
    set_fg_bg("diffAdded", current_colors.git.add, "NONE")
    set_fg_bg("diffRemoved", current_colors.git.delete, "NONE")
    set_fg_bg("diffChanged", current_colors.git.change, "NONE")
    set_fg_bg("WinSeparator", current_colors.bg_alt, current_colors.bg_alt)
    set_fg_bg("SignColumn", current_colors.bg, "NONE")
    set_fg_bg("SignColumnSB", current_colors.bg, "NONE")
    if _time.hour >= 9 and _time.hour < 17 then
      -- HACK: change highlights for tokyonight theme
      set_fg_bg("CmpBorder", "#181924", "#181924")
      set_fg_bg("NormalFloat", current_colors.fg, "#181924")
      set_fg_bg("Cursor", current_colors.bg, current_colors.fg)
      set_fg_bg("NormalNC", current_colors.fg_dark, "#1c1d28")
      set_fg_bg("Normal", current_colors.fg, "#1f2335")
      set_fg_bg("CursorLineNr", current_colors.orange, "bold")
    end
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
