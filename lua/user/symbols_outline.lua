local M = {}

M.config = function()
  local kind = require("user.lsp_kind").symbols_outline

  local status_ok, symout = pcall(require, "symbols-outline")
  if not status_ok then
    return
  end

  local opts = {
    highlight_hovered_item = true,
    show_guides = true,
    auto_preview = false,
    position = "right",
    relative_width = true,
    width = 25,
    show_numbers = false,
    show_relative_numbers = false,
    show_symbol_details = true,
    preview_bg_highlight = "Pmenu",
    keymaps = { -- These keymaps can be a string or a table for multiple keys
      close = { "<Esc>", "q" },
      goto_location = "<Cr>",
      focus_location = "o",
      hover_symbol = "<C-space>",
      toggle_preview = "K",
      rename_symbol = "r",
      code_actions = "a",
    },
    lsp_blacklist = {},
    symbol_blacklist = {},
    symbols = {
      File = { icon = kind.File, hl = "@text.uri" },
      Module = { icon = kind.Module, hl = "@namespace" },
      Namespace = { icon = kind.Namespace, hl = "@namespace" },
      Package = { icon = kind.Package, hl = "@namespace" },
      Class = { icon = kind.Class, hl = "@type" },
      Method = { icon = kind.Method, hl = "@method" },
      Property = { icon = kind.Property, hl = "@method" },
      Field = { icon = kind.Field, hl = "@field" },
      Constructor = { icon = kind.Constructor, hl = "@constructor" },
      Enum = { icon = kind.Enum, hl = "@type" },
      Interface = { icon = kind.Interface, hl = "@type" },
      Function = { icon = kind.Function, hl = "@function" },
      Variable = { icon = kind.Variable, hl = "@constant" },
      Constant = { icon = kind.Constant, hl = "@constant" },
      String = { icon = kind.String, hl = "@string" },
      Number = { icon = kind.Number, hl = "@number" },
      Boolean = { icon = kind.Boolean, hl = "@boolean" },
      Array = { icon = kind.Array, hl = "@constant" },
      Object = { icon = kind.Object, hl = "@type" },
      Key = { icon = kind.Key, hl = "@type" },
      Null = { icon = kind.Null, hl = "@type" },
      EnumMember = { icon = kind.EnumMember, hl = "@field" },
      Struct = { icon = kind.Struct, hl = "@type" },
      Event = { icon = kind.Event, hl = "@type" },
      Operator = { icon = kind.Operator, hl = "@operator" },
      TypeParameter = { icon = kind.TypeParameter, hl = "@parameter" },
    },
  }

  symout.setup(opts)
end

return M
