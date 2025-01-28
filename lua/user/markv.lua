local M = {}

local function generic_hl(group)
  return {
    ["github%.com/[%a%d%-%_%.]+%/?$"] = {
      hl = group,
    },
    ["github%.com/[%a%d%-%_%.]+/[%a%d%-%_%.]+%/?$"] = {
      hl = group,
    },
    ["github%.com/[%a%d%-%_%.]+/[%a%d%-%_%.]+/tree/[%a%d%-%_%.]+%/?$"] = {
      hl = group,
    },
    ["github%.com/[%a%d%-%_%.]+/[%a%d%-%_%.]+/commits/[%a%d%-%_%.]+%/?$"] = {
      hl = group,
    },
    ["github%.com/[%a%d%-%_%.]+/[%a%d%-%_%.]+%/releases$"] = {
      hl = group,
    },
    ["github%.com/[%a%d%-%_%.]+/[%a%d%-%_%.]+%/tags$"] = {
      hl = group,
    },
    ["github%.com/[%a%d%-%_%.]+/[%a%d%-%_%.]+%/issues$"] = {
      hl = group,
    },
    ["github%.com/[%a%d%-%_%.]+/[%a%d%-%_%.]+%/pulls$"] = {
      hl = group,
    },
    ["github%.com/[%a%d%-%_%.]+/[%a%d%-%_%.]+%/wiki$"] = {
      hl = group,
    },
  }
end

M.config = function()
  local status_ok, mv = pcall(require, "markview")
  if not status_ok then
    return
  end
  local presets = require "markview.presets"

  mv.setup {
    markdown_inline = {
      heckboxes = presets.checkboxes.nerd,
      hyperlinks = generic_hl "MarkviewHyperlink",
      uri_autolinks = generic_hl "MarkviewEmail",
    },
    markdown = {
      headings = presets.headings.glow,
      tables = presets.tables.rounded,
      code_blocks = { sign = false },
      reference_definitions = generic_hl "MarkviewPalette4Fg",
    },
    typst = {
      url_links = generic_hl "MarkviewEmail",
    },
  }
end

return M
