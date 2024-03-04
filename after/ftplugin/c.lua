local opts = {}
if lvim.builtin.cpp_programming.active then
  local clangd_flags = {
    "--background-index",
    "--fallback-style=google",
    "-j=12",
    "--all-scopes-completion",
    "--pch-storage=memory",
    "--clang-tidy",
    "--log=error",
    "--completion-style=detailed",
    "--header-insertion=iwyu",
    "--header-insertion-decorators",
    "--enable-config",
    "--offset-encoding=utf-16",
    "--ranking-model=heuristics",
  }

  local provider = "clangd"

  local custom_on_attach = function(client, bufnr)
    require("lvim.lsp").common_on_attach(client, bufnr)
    require("clangd_extensions.inlay_hints").setup_autocmd()
    require("clangd_extensions.inlay_hints").set_inlay_hints()
  end

  local status_ok, project_config = pcall(require, "rhel.clangd_wrl")
  if status_ok then
    clangd_flags = vim.tbl_deep_extend("keep", project_config, clangd_flags)
  end

  local custom_on_init = function(client, bufnr)
    require("lvim.lsp").common_on_init(client, bufnr)
    require("clangd_extensions.config").setup {}
    vim.cmd [[
  command ClangdToggleInlayHints lua require('clangd_extensions.inlay_hints').toggle_inlay_hints()
  command -range ClangdAST lua require('clangd_extensions.ast').display_ast(<line1>, <line2>)
  command ClangdTypeHierarchy lua require('clangd_extensions.type_hierarchy').show_hierarchy()
  command ClangdSymbolInfo lua require('clangd_extensions.symbol_info').show_symbol_info()
  command -nargs=? -complete=customlist,s:memuse_compl ClangdMemoryUsage lua require('clangd_extensions.memory_usage').show_memory_usage('<args>' == 'expand_preamble')
  ]]
  end

  opts = {
    cmd = { provider, unpack(clangd_flags) },
    on_attach = custom_on_attach,
    on_init = custom_on_init,
  }
end

require("lvim.lsp.manager").setup("clangd", opts)
