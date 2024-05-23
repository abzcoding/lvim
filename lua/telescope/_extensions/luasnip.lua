-- Taken from https://github.com/benfowler/telescope-luasnip.nvim/blob/master/lua/telescope/_extensions/luasnip.lua
-- MIT License

-- Copyright (c) 2021 fhill2

-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:

-- The above copyright notice and this permission notice shall be included in all
-- copies or substantial portions of the Software.

-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
-- SOFTWARE.

local has_telescope, telescope = pcall(require, "telescope")
if not has_telescope then
  error "This plugins requires nvim-telescope/telescope.nvim"
end

local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
local finders = require "telescope.finders"
local pickers = require "telescope.pickers"
local previewers = require "telescope.previewers"
local entry_display = require "telescope.pickers.entry_display"
local conf = require("telescope.config").values

local filter_null = function(str, default)
  return str and str or (default and default or "")
end

local filter_description = function(name, description)
  local result = ""
  if description and #description > 1 then
    for _, line in ipairs(description) do
      result = result .. line .. " "
    end
  elseif name and description and description[1] ~= name then
    result = description[1]
  end

  return result
end

local get_docstring = function(luasnip, ft, context)
  local docstring = {}
  if context then
    local snips_for_ft = luasnip.get_snippets(ft)
    if snips_for_ft then
      for _, snippet in pairs(snips_for_ft) do
        if context.name == snippet.name and context.trigger == snippet.trigger then
          docstring = snippet:get_docstring()
        end
      end
    end
  end
  return docstring
end

local luasnip_fn = function(opts)
  opts = opts or {}
  local objs = {}

  -- Account for the fact that luasnip may be lazy-loaded
  local has_luasnip, luasnip = pcall(require, "luasnip")
  if has_luasnip then
    local available = luasnip.available()

    for filename, file in pairs(available) do
      for _, snippet in ipairs(file) do
        table.insert(objs, {
          ft = filename ~= "" and filename or "-",
          context = snippet,
        })
      end
    end
  else
    print "LuaSnips is not available"
  end

  table.sort(objs, function(a, b)
    if a.ft ~= b.ft then
      return a.ft > b.ft
    elseif a.context.name ~= b.context.name then
      return a.context.name > b.context.name
    else
      return a.context.trigger > b.context.trigger
    end
  end)

  local displayer = entry_display.create {
    separator = " ",
    items = {
      { width = 24 },
      { remaining = true },
    },
  }

  local make_display = function(entry)
    return displayer {
      entry.value.context.name,
      filter_description(entry.value.context.name, entry.value.context.description),
    }
  end

  pickers
    .new(opts, {
      prompt_title = "LuaSnip",
      finder = finders.new_table {

        results = objs,
        entry_maker = function(entry)
          return {
            value = entry,
            display = make_display,

            ordinal = entry.ft
              .. " "
              .. filter_null(entry.context.trigger)
              .. " "
              .. filter_null(entry.context.name)
              .. " "
              .. filter_description(entry.context.name, entry.context.description),

            preview_command = function(_, bufnr)
              local snippet = get_docstring(luasnip, entry.ft, entry.context)
              vim.api.nvim_set_option_value("filetype", entry.ft, { buf = bufnr })
              if type(snippet) ~= "table" then
                local lines = {}
                for s in snippet:gmatch "[^\r\n]+" do
                  table.insert(lines, s)
                end
                snippet = lines
              end
              vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, snippet)
            end,
          }
        end,
      },

      previewer = previewers.display_content.new(opts),
      sorter = conf.generic_sorter(opts),
      attach_mappings = function()
        actions.select_default:replace(function(prompt_bufnr)
          local selection = action_state.get_selected_entry()
          actions.close(prompt_bufnr)
          vim.api.nvim_put({ selection.value.context.trigger }, "", true, true)
          if luasnip.expandable() then
            vim.cmd "startinsert"
            luasnip.expand()
            vim.cmd "stopinsert"
          else
            print(
              "Snippet '"
                .. selection.value.context.name
                .. "'"
                .. "was selected, but LuaSnip.expandable() returned false"
            )
          end
        end)
        return true
      end,
    })
    :find()
end -- end custom function

return telescope.register_extension { exports = { luasnip = luasnip_fn } }
