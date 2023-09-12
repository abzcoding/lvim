local fzf_lua = require "fzf-lua"

-- return first matching highlight or nil
local function hl_match(t)
  for _, h in ipairs(t) do
    -- `vim.api.nvim_get_hl_by_name` is deprecated since v0.9.0
    if vim.api.nvim_get_hl then
      local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = h, link = false })
      if ok and type(hl) == "table" and (hl.fg or hl.bg) then
        return h
      end
    else
      local ok, hl = pcall(vim.api.nvim_get_hl_by_name, h, true)
      -- must have at least bg or fg, otherwise this returns
      -- succesffully for cleared highlights (on colorscheme switch)
      if ok and (hl.foreground or hl.background) then
        return h
      end
    end
  end
end

local img_prev_bin = vim.fn.executable "ueberzug" == 1 and { "ueberzug" }
  or vim.fn.executable "chafa" == 1 and { "chafa" }
  or vim.fn.executable "viu" == 1 and { "viu", "-b" }
  or nil

local M = {}

M.profiles = {
  fzf = {
    files = { fzf_opts = { ["--no-separator"] = false } },
    grep = { fzf_opts = { ["--no-separator"] = false } },
  },
  fzf_native = {
    fzf_bin = "fzf",
    -- winopts = { preview = { default = "bat" } },
    manpages = { previewer = "man_native" },
    helptags = { previewer = "help_native" },
    tags = { previewer = "bat" },
    btags = { previewer = "bat" },
  },
  fzf_tmux = {
    fzf_bin = "fzf-tmux",
    fzf_opts = { ["--border"] = "rounded" },
    fzf_tmux_opts = { ["-p"] = "80%,90%" },
    winopts = { preview = { default = "bat", layout = "horizontal" } },
    manpages = { previewer = "man_native" },
    helptags = { previewer = "help_native" },
    tags = { previewer = "bat" },
    btags = { previewer = "bat" },
  },
  sk = {
    fzf_bin = "sk",
    fzf_opts = { ["--no-separator"] = false },
    fzf_colors = {
      ["matched_bg"] = { "bg", "Normal" },
      ["current_match_bg"] = { "bg", hl_match { "NightflyVisual", "CursorLine" } },
    },
  },
}

-- default profile
M.active_profile = M.profiles.fzf_native

M.default_opts = {
  fzf_opts = { ["--no-separator"] = "" },
  fzf_colors = function()
    return {
      ["fg"] = { "fg", "Normal" },
      ["bg"] = { "bg", "Normal" },
      ["hl"] = { "fg", hl_match { "NightflyViolet", "Directory" } },
      ["fg+"] = { "fg", "Normal" },
      ["bg+"] = { "bg", hl_match { "NightflyVisual", "CursorLine" } },
      ["hl+"] = { "fg", "CmpItemKindVariable" },
      ["info"] = { "fg", hl_match { "NightflyPeach", "WarningMsg" } },
      -- ["prompt"] = { "fg", "SpecialKey" },
      ["pointer"] = { "fg", "DiagnosticError" },
      ["marker"] = { "fg", "DiagnosticError" },
      ["spinner"] = { "fg", "Label" },
      ["header"] = { "fg", "Comment" },
      ["gutter"] = { "bg", "Normal" },
      ["scrollbar"] = { "fg", hl_match { "NightflyPeach", "WarningMsg" } },
    }
  end,
  winopts = {
    -- split   = "belowright new",
    -- split   = "aboveleft vnew",
    height = 0.90,
    width = 0.85,
    row = 0.35,
    col = 0.55,
    -- border = { {'╭', 'IncSearch'}, {'─', 'IncSearch'},
    -- {'╮', 'IncSearch'}, '│', '╯', '─', '╰', '│' },
    preview = {
      layout = "flex",
      flip_columns = 130,
      scrollbar = "float",
      -- scrolloff        = '-1',
      -- scrollchars      = {'█', '░' },
    },
    on_create = function()
      -- disable miniindentscope
      vim.b.miniindentscope_disable = true
    end,
  },
  previewers = {
    -- bat = { theme = "Coldark-Dark" },
    builtin = {
      ueberzug_scaler = "cover",
      extensions = {
        ["gif"] = img_prev_bin,
        ["png"] = img_prev_bin,
        ["jpg"] = img_prev_bin,
        ["jpeg"] = img_prev_bin,
        ["svg"] = { "chafa" },
      },
    },
  },
  actions = {
    files = {
      ["default"] = fzf_lua.actions.file_edit_or_qf,
      ["ctrl-l"] = fzf_lua.actions.arg_add,
      ["ctrl-s"] = fzf_lua.actions.file_split,
      ["ctrl-v"] = fzf_lua.actions.file_vsplit,
      ["ctrl-t"] = fzf_lua.actions.file_tabedit,
      ["ctrl-q"] = fzf_lua.actions.file_sel_to_qf,
      ["alt-q"] = fzf_lua.actions.file_sel_to_ll,
    },
  },
  buffers = { no_action_zz = true },
  files = {
    -- uncomment to override .gitignore
    -- fd_opts  = "--no-ignore --color=never --type f --hidden --follow --exclude .git",
    fzf_opts = { ["--tiebreak"] = "end" },
  },
  grep = {
    debug = false,
    rg_glob = true,
    rg_opts = "--hidden --column --line-number --no-heading" .. " --color=always --smart-case -g '!.git' -e",
    fzf_opts = {
      ["--history"] = vim.fn.shellescape(vim.fn.stdpath "data" .. "/fzf_search_hist"),
    },
  },
  git = {
    status = {
      cmd = "git status -su",
      winopts = {
        preview = { vertical = "down:70%", horizontal = "right:70%" },
      },
      preview_pager = vim.fn.executable "delta" == 1 and "delta --width=$COLUMNS",
    },
    commits = {
      winopts = { preview = { vertical = "down:60%" } },
      preview_pager = vim.fn.executable "delta" == 1 and "delta --width=${COLUMNS:-0}",
    },
    bcommits = {
      winopts = { preview = { vertical = "down:60%" } },
      preview_pager = vim.fn.executable "delta" == 1 and "delta --width=${COLUMNS:-0}",
    },
    branches = {
      winopts = {
        preview = { vertical = "down:75%", horizontal = "right:75%" },
      },
    },
  },
  lsp = {
    finder = {
      providers = {
        { "definitions", prefix = fzf_lua.utils.ansi_codes.green "def " },
        { "declarations", prefix = fzf_lua.utils.ansi_codes.magenta "decl" },
        { "implementations", prefix = fzf_lua.utils.ansi_codes.green "impl" },
        { "typedefs", prefix = fzf_lua.utils.ansi_codes.red "tdef" },
        { "references", prefix = fzf_lua.utils.ansi_codes.blue "ref " },
        { "incoming_calls", prefix = fzf_lua.utils.ansi_codes.cyan "in  " },
        { "outgoing_calls", prefix = fzf_lua.utils.ansi_codes.yellow "out " },
      },
    },
    symbols = {
      path_shorten = 1,
      symbol_icons = {
        File = "",
        Module = "",
        Namespace = "󰅩",
        Package = "",
        Class = "󰌗",
        Method = "󰊕",
        Property = "",
        Field = "",
        Constructor = "",
        Enum = "",
        Interface = "󰠱",
        Function = "󰊕",
        Variable = "󰀫",
        Constant = "󰏿",
        String = "󰊄",
        Number = "󰎠",
        Boolean = "󰝖",
        Array = "",
        Object = "󰜫",
        Key = "󰌆",
        Null = "Ø",
        EnumMember = "",
        Struct = "󰙅",
        Event = "",
        Operator = "󰆕",
        TypeParameter = "",
      },
    },
  },
  diagnostics = { file_icons = false, icon_padding = " ", path_shorten = 1 },
  file_icon_padding = " ",
  file_ignore_patterns = {
    "vendor/*",
    "%.lock",
    "__pycache__/*",
    "%.sqlite3",
    "%.ipynb",
    "node_modules/*",
    "%.jpg",
    "%.jpeg",
    "%.png",
    "%.svg",
    "%.otf",
    "%.ttf",
    ".git/",
    "%.webp",
    ".dart_tool/",
    ".github/",
    ".gradle/",
    ".idea/",
    ".settings/",
    ".vscode/",
    "__pycache__/",
    "build/",
    "env/",
    "gradle/",
    "node_modules/",
    "target/",
    "%.pdb",
    "%.dll",
    "%.class",
    "%.exe",
    "%.cache",
    "%.ico",
    "%.pdf",
    "%.dylib",
    "%.jar",
    "%.docx",
    "%.met",
    "smalljre_*/*",
    ".vale/",
    "%.burp",
    "%.mp4",
    "%.mkv",
    "%.rar",
    "%.zip",
    "%.7z",
    "%.tar",
    "%.bz2",
    "%.epub",
    "%.flac",
    "%.tar.gz",
  },
}

M.setup = function()
  fzf_lua.setup(vim.tbl_deep_extend("keep", vim.deepcopy(M.active_profile), M.default_opts))
end

return M
