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
  vim.g.tokyonight_italic_comments = true
  vim.g.tokyonight_italic_keywords = true
  vim.g.tokyonight_italic_functions = false
  vim.g.tokyonight_italic_variables = false
  vim.g.tokyonight_transparent = false
  vim.g.tokyonight_hide_inactive_statusline = true
  vim.g.tokyonight_dark_sidebar = true
  vim.g.tokyonight_dark_float = true
  local _time = os.date "*t"
  if _time.hour < 8 then
    vim.g.tokyonight_style = "night"
  end
end

M.catppuccino = function()
  local catppuccino = require "catppuccino"
  catppuccino.setup {
    colorscheme = "dark_catppuccino",
    transparency = false,
    term_colors = false,
    styles = {
      comments = "italic",
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
      lsp_saga = false,
      gitgutter = false,
      gitsigns = true,
      telescope = true,
      nvimtree = {
        enabled = true,
        show_root = true,
      },
      which_key = true,
      indent_blankline = {
        enabled = true,
        colored_indent_levels = true,
      },
      dashboard = true,
      neogit = false,
      vim_sneak = false,
      fern = false,
      barbar = true,
      bufferline = true,
      markdown = true,
      lightspeed = false,
      ts_rainbow = false,
      hop = true,
    },
  }
  catppuccino.load()
end

M.doom = function()
  local doom = require "doom-one"
  doom.setup {
    cursor_coloring = true,
    terminal_colors = false,
    italic_comments = true,
    enable_treesitter = true,
    transparent_background = false,
    pumblend = {
      enable = true,
      transparency_amount = 20,
    },
    plugins_integrations = {
      barbar = true,
      bufferline = true,
      cmp = true,
      gitgutter = false,
      gitsigns = true,
      telescope = true,
      neogit = false,
      nvim_tree = true,
      dashboard = true,
      startify = true,
      whichkey = true,
      indent_blankline = true,
      vim_illuminate = false,
      lspsaga = false,
    },
  }
end

M.colors = {
  tokyonight_colors = {
    none = "NONE",
    bg_dark = "#1f2335",
    bg_alt = "#1f2335",
    bg = "#1a1b26",
    bg_highlight = "#292e42",
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

  catppuccino_colors = {
    none = "NONE",
    -- bg = "#2a2e36", -- nvim bg
    bg = "#222424",
    fg = "#abb2bf", -- fg color (text)
    fg_gutter = "#3b4261",
    black = "#393b44",
    gray = "#2a2e36",
    red = "#c94f6d",
    green = "#97c374",
    yellow = "#dbc074",
    blue = "#61afef",
    magenta = "#c678dd",
    cyan = "#63cdcf",
    white = "#dfdfe0",
    orange = "#F4A261",
    pink = "#D67AD2",
    black_br = "#7f8c98",
    red_br = "#e06c75",
    green_br = "#58cd8b",
    yellow_br = "#FFE37E",
    blue_br = "#84CEE4",
    magenta_br = "#B8A1E3",
    cyan_br = "#59F0FF",
    white_br = "#FDEBC3",
    orange_br = "#F6A878",
    pink_br = "#DF97DB",
    comment = "#526175",
    bg_alt = "#0e171c", -- nvim bg
    git = {
      add = "#dfdfe0",
      change = "#F6A878",
      delete = "#e06c75",
      conflict = "#FFE37E",
    },
  },

  doom_one_colors = {
    grey = "#3f444a",
    red = "#ff6c6b",
    orange = "#da8548",
    green = "#98be65",
    yellow = "#ECBE7B",
    blue = "#51afef",
    dark_blue = "#2257A0",
    magenta = "#c678dd",
    violet = "#a9a1e1",
    cyan = "#46D9FF",
    white = "#efefef",

    bg_alt = "#282c34",
    bg = "#21242b",
    bg_highlight = "#21252a",
    bg_popup = "#3E4556",
    bg_statusline = "#3E4556",
    bg_highlighted = "#4A4A45",

    fg = "#bbc2cf",
    fg_alt = "#5B6268",

    git = {
      add = "#98be65",
      change = "#51afef",
      delete = "#ff6c6b",
      conflict = "#da8548",
    },
  },

  onedarker_colors = {
    fg = "#abb2bf",
    bg_alt = "#1f2227",
    bg = "#282c34",
    dark = "#282c34",
    accent = "#BBBBBB",
    dark_gray = "#2a2f3e",
    context = "#4b5263",
    popup_back = "#282c34",
    search_orange = "#613214",
    search_blue = "#5e81ac",
    gray = "#5c6370",
    light_gray = "#abb2bf",
    blue = "#61AFEF",
    dark_blue = "#223E55",
    green = "#98C379",
    cyan = "#56B6C2",
    red = "#e06c75",
    orange = "#D19A66",
    light_red = "#be5046",
    yellow = "#E5C07B",
    yellow_orange = "#D7BA7D",
    purple = "#C678DD",
    magenta = "#D16D9E",
    cursor_fg = "#515052",
    cursor_bg = "#AEAFAD",
    error_red = "#F44747",
    warning_orange = "#ff8800",
    info_yellow = "#FFCC66",
    hint_blue = "#4FC1FF",
    purple_test = "#ff007c",
    cyan_test = "#00dfff",
    ui_blue = "#264F78",
    git = {
      add = "#587c0c",
      change = "#0c7d9d",
      delete = "#e06c75",
      conflict = "#ff8800",
    },
  },

  zephyr_colors = {
    base0 = "#1B2229",
    base1 = "#1c1f24",
    base2 = "#202328",
    base3 = "#23272e",
    base4 = "#3f444a",
    base5 = "#5B6268",
    base6 = "#73797e",
    base7 = "#9ca0a4",
    base8 = "#b1b1b1",

    bg_alt = "#282a36",
    bg = "#2E323C",
    bg_popup = "#3E4556",
    bg_highlight = "#2E323C",
    bg_visual = "#b3deef",
    fg = "#bbc2cf",
    fg_alt = "#5B6268",
    red = "#e95678",
    redwine = "#d16d9e",
    orange = "#D98E48",
    yellow = "#f0c674",
    light_green = "#abcf84",
    green = "#afd700",
    dark_green = "#98be65",
    cyan = "#36d0e0",
    blue = "#61afef",
    violet = "#b294bb",
    magenta = "#c678dd",
    teal = "#1abc9c",
    grey = "#928374",
    brown = "#c78665",
    black = "#000000",
    bracket = "#80A0C2",
    currsor_bg = "#4f5b66",
    none = "NONE",
    git = {
      add = "#98be65",
      change = "#61afef",
      delete = "#e95678",
      conflict = "#D98e48",
    },
  },
}

return M
