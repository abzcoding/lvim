local M = {}

M.config = function()
  local status_ok, sym = pcall(require, "symbol-usage")
  if not status_ok then
    return
  end

  local text_format = function(symbol)
    local res = {}
    local ins = table.insert

    local round_start = { "", "SymbolUsageRounding" }
    local round_end = { "", "SymbolUsageRounding" }

    if symbol.references then
      local usage = symbol.references <= 1 and "usage" or "usages"
      local num = symbol.references == 0 and "no" or symbol.references
      ins(res, round_start)
      ins(res, { "󰌹 ", "SymbolUsageRef" })
      ins(res, { ("%s %s"):format(num, usage), "SymbolUsageContent" })
      ins(res, round_end)
    end

    if symbol.definition then
      if #res > 0 then
        table.insert(res, { " ", "NonText" })
      end
      ins(res, round_start)
      ins(res, { "󰳽 ", "SymbolUsageDef" })
      ins(res, { symbol.definition .. " defs", "SymbolUsageContent" })
      ins(res, round_end)
    end

    if symbol.implementation then
      if #res > 0 then
        table.insert(res, { " ", "NonText" })
      end
      ins(res, round_start)
      ins(res, { "󰡱 ", "SymbolUsageImpl" })
      ins(res, { symbol.implementation .. " impls", "SymbolUsageContent" })
      ins(res, round_end)
    end

    return res
  end
  sym.setup {
    text_format = text_format,
    references = { enabled = true, include_declaration = false },
    definition = { enabled = true },
    implementation = { enabled = true },
  }
end

return M
