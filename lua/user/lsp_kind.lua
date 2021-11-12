local lspkind = {}

local kind_symbols = {
  Class = " ",
  Color = " ",
  Constant = "",
  Constructor = " ",
  Default = " ",
  Enum = "練",
  EnumMember = " ",
  Event = " ",
  Field = "ﰠ ",
  File = " ",
  Folder = " ",
  Function = " ",
  Interface = " ",
  Keyword = " ",
  Method = "ƒ ",
  Module = " ",
  Operator = " ",
  Property = " ",
  Reference = "",
  Snippet = "", -- " "," "
  Struct = "פּ",
  Text = " ",
  TypeParameter = "  ",
  Unit = "塞",
  Value = " ",
  Variable = " ",
}

function lspkind.cmp_kind(kind)
  return kind_symbols[kind] or ""
end

function lspkind.symbols()
  return kind_symbols
end

return lspkind
