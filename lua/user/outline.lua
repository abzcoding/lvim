local M = {}

M.config = function()
  local kind = require("user.lsp_kind").cmp_kind

  local status_ok, symout = pcall(require, "outline")
  if not status_ok then
    return
  end

  local opts = {
    outline_window = {
      position = "right",
      width = 20,
      relative_width = true,
      auto_close = false,
      auto_jump = false,
      jump_highlight_duration = 300,
      center_on_jump = true,
      show_numbers = false,
      show_relative_numbers = false,
      wrap = false,
      show_cursorline = true,
      hide_cursor = false,
      focus_on_open = true,
    },
    outline_items = {
      show_symbol_details = false,
      show_symbol_lineno = false,
    },
    symbols = {
      icons = {
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
    },
  }
  symout.setup(opts)
end

return M
