-- HACK: make sure rust_analyzer is running no matter what
local rustToolsLoaded, _ = pcall(require, "rust-tools")
if rustToolsLoaded then
  local rustAnalyzerLspActive = true
  local activeLspClients = vim.lsp.get_active_clients { bufnr = 0 }
  if #activeLspClients == 0 then
    rustAnalyzerLspActive = false
  end
  if not rustAnalyzerLspActive then
    vim.cmd [[LspStart rust_analyzer]]
  end
end
