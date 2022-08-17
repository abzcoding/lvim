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
      File = { icon = kind.File, hl = "TSURI" },
      Module = { icon = kind.Module, hl = "TSNamespace" },
      Namespace = { icon = kind.Namespace, hl = "TSNamespace" },
      Package = { icon = kind.Package, hl = "TSNamespace" },
      Class = { icon = kind.Class, hl = "TSType" },
      Method = { icon = kind.Method, hl = "TSMethod" },
      Property = { icon = kind.Property, hl = "TSMethod" },
      Field = { icon = kind.Field, hl = "TSField" },
      Constructor = { icon = kind.Constructor, hl = "TSConstructor" },
      Enum = { icon = kind.Enum, hl = "TSType" },
      Interface = { icon = kind.Interface, hl = "TSType" },
      Function = { icon = kind.Function, hl = "TSFunction" },
      Variable = { icon = kind.Variable, hl = "TSConstant" },
      Constant = { icon = kind.Constant, hl = "TSConstant" },
      String = { icon = kind.String, hl = "TSString" },
      Number = { icon = kind.Number, hl = "TSNumber" },
      Boolean = { icon = kind.Boolean, hl = "TSBoolean" },
      Array = { icon = kind.Array, hl = "TSConstant" },
      Object = { icon = kind.Object, hl = "TSType" },
      Key = { icon = kind.Key, hl = "TSType" },
      Null = { icon = kind.Null, hl = "TSType" },
      EnumMember = { icon = kind.EnumMember, hl = "TSField" },
      Struct = { icon = kind.Struct, hl = "TSType" },
      Event = { icon = kind.Event, hl = "TSType" },
      Operator = { icon = kind.Operator, hl = "TSOperator" },
      TypeParameter = { icon = kind.TypeParameter, hl = "TSParameter" },
    },
  }

  symout.setup()
end

return M
