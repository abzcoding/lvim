local M = {}

M.init = function()
  vim.g.vimtex_view_enabled = true
  vim.g.vimtex_compiler_method = "latexmk"
  vim.g.vimtex_view_method = lvim.builtin.latex.view_method
  if lvim.builtin.latex.view_method == "skim" then
    vim.g.vimtex_view_skim_activate = 1
    vim.g.vimtex_view_skim_reading_bar = 0
  end
  if lvim.builtin.latex.rtl_support then
    vim.g.vimtex_compiler_latexmk_engines = {
      _ = "-xelatex",
      pdflatex = "-pdf",
      dvipdfex = "-pdfdvi",
      lualatex = "-lualatex",
      xelatex = "-xelatex",
    }
    vim.g.vimtex_compiler_latexrun_engines = {
      _ = "xelatex",
      pdflatex = "pdflatex",
      lualatex = "lualatex",
      xelatex = "xelatex",
    }
  end
  vim.g.tex_flavor = "latex"
  vim.g.vimtex_fold_enabled = 0
  vim.g.vimtex_quickfix_ignore_filters = {}
end

M.config = function()
  vim.cmd [[
  augroup vimtex_event_1
    au!
    au User VimtexEventQuit     VimtexClean
    au User VimtexEventInitPost VimtexCompile
  augroup END
  ]]
  local latexmk_args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" }
  if lvim.builtin.latex.rtl_support then
    latexmk_args = { "-xelatex", "-file-line-error", "-interaction=nonstopmode", "-synctex=1", "%f" }
  end
  local tex_preview_settings = {}
  local forward_search_executable = lvim.builtin.latex.preview_exec

  local sumatrapdf_args = { "-reuse-instance", "%p", "-forward-search", "%f", "%l" }
  local evince_args = { "-f", "%l", "%p", '"code -g %f:%l"' }
  local okular_args = { "--unique", "file:%p#src:%l%f" }
  local zathura_args = { "--synctex-forward", "%l:1:%f", "%p" }
  local qpdfview_args = { "--unique", "%p#src:%f:%l:1" }
  local skim_args = { "%l", "%p", "%f" }

  if forward_search_executable == "C:/Users/{User}/AppData/Local/SumatraPDF/SumatraPDF.exe" then
    tex_preview_settings = sumatrapdf_args
  elseif forward_search_executable == "evince-synctex" then
    tex_preview_settings = evince_args
  elseif forward_search_executable == "okular" then
    tex_preview_settings = okular_args
  elseif forward_search_executable == "zathura" then
    tex_preview_settings = zathura_args
  elseif forward_search_executable == "qpdfview" then
    tex_preview_settings = qpdfview_args
  elseif forward_search_executable == "/Applications/Skim.app/Contents/SharedSupport/displayline" then
    tex_preview_settings = skim_args
  end
  return {
    cmd = { vim.fn.stdpath "data" .. "/mason/packages/texlab/texlab" },
    filetypes = { "tex", "bib" },
    root_dir = function(fname)
      return require("lspconfig").util.path.dirname(fname)
    end,
    settings = {
      texlab = {
        auxDirectory = nil,
        bibtexFormatter = "texlab",
        build = {
          executable = "latexmk",
          args = latexmk_args,
          on_save = false,
          forward_search_after = false,
        },
        chktex = {
          on_open_and_save = false,
          on_edit = false,
        },
        forward_search = {
          executable = nil,
          args = {},
        },
        latexindent = {
          ["local"] = nil,
          modify_line_breaks = false,
        },
        linters = { "chktex" },
        auto_save = false,
        ignore_errors = {},
        diagnosticsDelay = 300,
        formatterLineLength = 120,
        forwardSearch = {
          args = tex_preview_settings,
          executable = forward_search_executable,
        },
        latexFormatter = "latexindent",
      },
    },
  }
end

return M
