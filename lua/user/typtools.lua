local M = {}

M.config = function()
  local status_ok, tools = pcall(require, "typescript-tools")
  if not status_ok then
    return
  end
  local ok, lvim_lsp = pcall(require, "lvim.lsp")
  if not ok then
    return
  end
  local opts = {
    capabilities = lvim_lsp.common_capabilities(),
    on_attach = function(client, bufnr)
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false

      lvim_lsp.common_on_attach(client, bufnr)
    end,
    settings = {
      separate_diagnostic_server = true,
      composite_mode = "separate_diagnostic",
      publish_diagnostic_on = "insert_leave",
      -- tsserver_logs = "verbose",
      tsserver_file_preferences = {
        importModuleSpecifierPreference = "non-relative",
      },
      tsserver_locale = "en",
      -- mirror of VSCode's `typescript.suggest.completeFunctionCalls`
      complete_function_calls = false,
      include_completions_with_insert_text = true,
      -- WARNING: Experimental feature also in VSCode, because it might hit performance of server.
      -- possible values: ("off"|"all"|"implementations_only"|"references_only")
      code_lens = "off",
      disable_member_code_lens = true,
      -- JSXCloseTag
      -- WARNING: it is disabled by default (maybe you configuration or distro already uses nvim-ts-autotag,
      -- that maybe have a conflict if enable this feature. )
      jsx_close_tag = {
        enable = false,
        filetypes = { "javascriptreact", "typescriptreact" },
      },
    },
  }
  tools.setup(opts)
end

return M
