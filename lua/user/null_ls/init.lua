local M = {}

M.config = function()
  -- NOTE: By default, all null-ls providers are checked on startup.
  -- If you want to avoid that or want to only set up the provider
  -- when you opening the associated file-type,
  -- then you can use filetype plugins for this purpose.
  -- https://www.lunarvim.org/languages/#lazy-loading-the-formatter-setup
  local status_ok, nls = pcall(require, "null-ls")
  if not status_ok then
    return
  end

  local custom_go_actions = require "user.null_ls.go"
  local custom_md_hover = require "user.null_ls.markdown"

  -- you can either config null-ls itself
  nls.config {
    debounce = 150,
    save_after_format = false,
    sources = {
      nls.builtins.formatting.prettierd,
      nls.builtins.formatting.stylua,
      nls.builtins.formatting.goimports,
      nls.builtins.formatting.cmake_format,
      nls.builtins.formatting.scalafmt,
      nls.builtins.formatting.sqlformat,
      nls.builtins.formatting.terraform_fmt,
      nls.builtins.formatting.shfmt.with { extra_args = { "-i", "2", "-ci" } },
      nls.builtins.formatting.black.with { extra_args = { "--fast" }, filetypes = {"python"} },
      nls.builtins.formatting.isort.with { extra_args = { "--profile", "black" }, filetypes = {"python"} },
      nls.builtins.diagnostics.hadolint,
      nls.builtins.diagnostics.eslint_d,
      nls.builtins.diagnostics.shellcheck,
      nls.builtins.diagnostics.luacheck,
      nls.builtins.diagnostics.vint,
      nls.builtins.diagnostics.chktex,
      nls.builtins.diagnostics.markdownlint.with {
        filetypes = { "markdown" },
      },
      nls.builtins.diagnostics.vale.with {
        filetypes = { "markdown" },
      },
      custom_go_actions.gomodifytags,
      custom_go_actions.gostructhelper,
      custom_md_hover.dictionary,
    },
  }
end

return M
