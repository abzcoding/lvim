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
  if vim.g.neovide then
    vim.g.neovide_cursor_animation_length = 0.01
    vim.g.neovide_cursor_trail_length = 0.05
    vim.g.neovide_cursor_antialiasing = true
    vim.g.neovide_remember_window_size = true
    vim.cmd [[set guifont=JetBrainsMono\ Nerd\ Font:h16]]
  end

  if vim.fn.exists "g:nvui" ~= 0 then
    -- Configure nvui here
    vim.cmd [[NvuiCmdFontFamily VictorMono Nerd Font]]
    vim.cmd [[set linespace=1]]
    vim.cmd [[set guifont=VictorMono\ Nerd\ Font:h18]]
    vim.cmd [[NvuiPopupMenuDefaultIconFg white]]
    vim.cmd [[NvuiCmdBg #1e2125]]
    vim.cmd [[NvuiCmdFg #abb2bf]]
    vim.cmd [[NvuiCmdBigFontScaleFactor 1.0]]
    vim.cmd [[NvuiCmdPadding 10]]
    vim.cmd [[NvuiCmdCenterXPos 0.5]]
    vim.cmd [[NvuiCmdTopPos 0.0]]
    vim.cmd [[NvuiCmdFontSize 25.0]]
    vim.cmd [[NvuiCmdBorderWidth 5]]
    vim.cmd [[NvuiPopupMenuIconFg variable #56b6c2]]
    vim.cmd [[NvuiPopupMenuIconFg function #c678dd]]
    vim.cmd [[NvuiPopupMenuIconFg method #c678dd]]
    vim.cmd [[NvuiPopupMenuIconFg field #d19a66]]
    vim.cmd [[NvuiPopupMenuIconFg property #d19a66]]
    vim.cmd [[NvuiPopupMenuIconFg module white]]
    vim.cmd [[NvuiPopupMenuIconFg struct #e5c07b]]
    vim.cmd [[NvuiCaretExtendTop 15]]
    vim.cmd [[NvuiCaretExtendBottom 8]]
    vim.cmd [[NvuiTitlebarFontSize 12]]
    vim.cmd [[NvuiTitlebarFontFamily Arial]]
    vim.cmd [[NvuiCursorAnimationDuration 0.1]]
  end
end

return M
