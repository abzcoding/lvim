local M = {}

M.config = function()
  require("filetype").setup {
    overrides = {
      literal = {
        ["kitty.conf"] = "kitty",
        [".gitignore"] = "conf",
      },
      complex = {
        [".clang*"] = "yaml",
        [".*%.env.*"] = "sh",
        [".*ignore"] = "conf",
      },
      extensions = {
        tf = "terraform",
        tfvars = "terraform",
        hcl = "hcl",
        tfstate = "json",
        eslintrc = "json",
        prettierrc = "json",
        mdx = "markdown",
      },
    },
  }
end

return M
