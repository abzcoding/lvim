local M = {}

M.config = function()
  local status_ok, ts_utils = pcall(require, "nvim-lsp-ts-utils")
  if not status_ok then
    return
  end

  -- defaults
  ts_utils.setup {
    debug = false,
    disable_commands = false,
    enable_import_on_completion = false,
    import_all_timeout = 5000, -- ms

    -- eslint
    eslint_enable_code_actions = true,
    eslint_enable_disable_comments = true,
    eslint_bin = "eslint_d",
    eslint_config_fallback = nil,
    eslint_enable_diagnostics = true,

    -- formatting
    enable_formatting = false,
    formatter = "prettier",
    formatter_config_fallback = nil,

    -- parentheses completion
    complete_parens = false,
    signature_help_in_parens = false,

    -- update imports on file move
    update_imports_on_move = false,
    require_confirmation_on_move = false,
    watch_dir = nil,
  }

end

return M
