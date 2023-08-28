-- HACK: make sure pyright is running no matter what
local lsp_active = true
local buf_clients = vim.lsp.get_active_clients { bufnr = 0 }
if #buf_clients == 0 then
  lsp_active = false
end
-- add client
for _, client in pairs(buf_clients) do
  if client.name == "pyright" then
    lsp_active = true
  end
end
if not lsp_active then
  vim.cmd [[LspStart pyright]]
end
