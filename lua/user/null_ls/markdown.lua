local M = {}
local helpers = require "null-ls.helpers"
local methods = require "null-ls.methods"
local hover = methods.internal.HOVER

M.dictionary = helpers.make_builtin {
  name = "dictionary",
  method = hover,
  filetypes = { "text", "markdown" },
  generator = {
    fn = function(_, done)
      local cword = vim.fn.expand "<cword>"
      local send_definition = function(def)
        done { cword .. ": " .. def }
      end

      -- If this is a BibTeX citation, don't look it up:
      if string.find(cword, "@", 1, true) then
        done()
        return
      end

      require("plenary.curl").request {
        url = "https://api.dictionaryapi.dev/api/v2/entries/en/" .. cword,
        method = "get",
        callback = vim.schedule_wrap(function(data)
          if not (data and data.body) then
            done()
            return
          end

          local ok, decoded = pcall(vim.fn.json_decode, data.body)
          if not ok or not (decoded and decoded[1]) then
            done()
            return
          end

          send_definition(decoded[1].meanings[1].definitions[1].definition)
        end),
      }
    end,
    async = true,
  },
}

return M
