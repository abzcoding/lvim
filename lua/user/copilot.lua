local M = {}

M.config = function()
  vim.g.copilot_no_tab_map = true
  vim.g.copilot_assume_mapped = true
  vim.g.copilot_tab_fallback = ""
  vim.g.copilot_filetypes = {
    ["*"] = false,
    python = true,
    lua = true,
    go = true,
    rust = true,
    html = true,
    c = true,
    cpp = true,
    java = true,
    javascript = true,
    typescript = true,
    javascriptreact = true,
    typescriptreact = true,
    terraform = true,
  }
end

return M
