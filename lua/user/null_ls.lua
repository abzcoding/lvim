local M = {}

M.config = function()
  local status_ok, nls = pcall(require, "null-ls")
  if not status_ok then
    return
  end

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
      nls.builtins.diagnostics.hadolint,
      nls.builtins.diagnostics.eslint_d,
      nls.builtins.diagnostics.shellcheck,
      nls.builtins.diagnostics.luacheck,
      nls.builtins.diagnostics.vint,
      nls.builtins.diagnostics.chktex,
    },
  }

  -- or use the lunarvim syntax
  lvim.lang.python.formatters = {
    {
      exe = "black",
      args = { "--fast" },
    },
    {
      exe = "isort",
      args = {
        "--profile",
        "black",
      },
    },
  }
  lvim.lang.markdown.linters = {
    {
      exe = "markdownlint",
    },
    {
      exe = "vale",
    },
  }
end

return M
