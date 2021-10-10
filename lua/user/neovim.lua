local M = {}

M.config = function()
  vim.opt.relativenumber = true
  vim.opt.wrap = true
  vim.opt.timeoutlen = 200
  vim.o.foldmethod = "expr"
  vim.o.foldexpr = "nvim_treesitter#foldexpr()"
  vim.o.foldlevel = 4
  vim.o.foldtext =
    [[substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g').'...'.trim(getline(v:foldend)) . ' (' . (v:foldend - v:foldstart + 1) . ' lines)']]
  vim.opt.fillchars = {
    vert = "▕", -- alternatives │
    fold = " ",
    eob = " ", -- suppress ~ at EndOfBuffer
    diff = "╱", -- alternatives = ⣿ ░ ─
    msgsep = "‾",
    foldopen = "▾",
    foldsep = "│",
    foldclose = "▸",
  }
  vim.o.foldnestmax = 3
  vim.o.foldminlines = 1
  vim.opt.guifont = "FiraCode Nerd Font:h13"
  vim.opt.cmdheight = 1
  vim.g.dashboard_enable_session = 0
  vim.g.dashboard_disable_statusline = 1
  vim.opt.pumblend = 10
  vim.opt.joinspaces = false
  vim.opt.list = true
  vim.opt.wildignore = {
    "*.aux,*.out,*.toc",
    "*.o,*.obj,*.dll,*.jar,*.pyc,__pycache__,*.rbc,*.class",
    -- media
    "*.ai,*.bmp,*.gif,*.ico,*.jpg,*.jpeg,*.png,*.psd,*.webp",
    "*.avi,*.m4a,*.mp3,*.oga,*.ogg,*.wav,*.webm",
    "*.eot,*.otf,*.ttf,*.woff",
    "*.doc,*.pdf",
    -- archives
    "*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz",
    -- temp/system
    "*.*~,*~ ",
    "*.swp,.lock,.DS_Store,._*,tags.lock",
    -- version control
    ".git,.svn",
  }
end

return M
