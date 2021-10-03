local M = {}

M.formatters = function()
  lvim.lang.asm.formatters = { { exe = "asmfmt" } }
  lvim.lang.cmake.formatters = { { exe = "cmake_format" } }
  lvim.lang.css.formatters = { { exe = "prettierd" } }
  lvim.lang.dockerfile.linters = { { exe = "hadolint" } }
  lvim.lang.go.formatters = { { exe = "goimports" } }
  lvim.lang.html.formatters = { { exe = "prettierd" } }
  lvim.lang.javascript.formatters = { { exe = "prettierd" } }
  lvim.lang.javascriptreact.formatters = { { exe = "prettierd" } }
  lvim.lang.json.formatters = { { exe = "prettierd" } }
  lvim.lang.less.formatters = { { exe = "prettierd" } }
  lvim.lang.lua.formatters = { { exe = "stylua" } }
  lvim.lang.markdown.formatters = { { exe = "prettierd" } }
  -- lvim.lang.nginx.formatters = { { exe = "nginx_beautifier" } }
  -- lvim.lang.perl.formatters = { { exe = "perltidy" } }
  -- lvim.lang.php.formatters = { { exe = "phpcbf" } }
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
  lvim.lang.scala.formatters = { { exe = "scalafmt" } }
  lvim.lang.sh.formatters = {
    {
      exe = "shfmt",
      args = { "-i", "2", "-ci" },
    },
  }
  lvim.lang.solidity.formatters = { { exe = "prettierd" } }
  lvim.lang.sql.formatters = { { exe = "sqlformat" } }
  lvim.lang.terraform.formatters = { { exe = "terraform_fmt" } }
  lvim.lang.typescript.formatters = { { exe = "prettierd" } }
  lvim.lang.typescriptreact.formatters = { { exe = "prettierd" } }
  lvim.lang.vue.formatters = { { exe = "prettierd" } }
  lvim.lang.yaml.formatters = { { exe = "prettierd" } }
end

M.linters = function()
  lvim.lang.css.linters = { { exe = "eslint_d" } }
  lvim.lang.javascript.linters = { { exe = "eslint_d" } }
  lvim.lang.javascriptreact.linters = { { exe = "eslint_d" } }
  lvim.lang.lua.linters = { { exe = "luacheck" } }
  lvim.lang.markdown.linters = {
    {
      exe = "markdownlint",
    },
    {
      exe = "vale",
    },
  }
  lvim.lang.sh.linters = { { exe = "shellcheck" } }
  lvim.lang.tex.linters = { { exe = "chktex" } }
  lvim.lang.typescript.linters = { { exe = "eslint_d" } }
  lvim.lang.typescriptreact.linters = { { exe = "eslint_d" } }
  lvim.lang.vim.linters = { { exe = "vint" } }
end

return M
