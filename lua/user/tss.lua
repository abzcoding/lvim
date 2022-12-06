local M = {}

local api = vim.api

local get_map_options = function(custom_options)
  local options = { silent = true }
  if custom_options then
    options = vim.tbl_extend("force", options, custom_options)
  end
  return options
end

M.map = function(mode, target, source, opts)
  vim.keymap.set(mode, target, source, get_map_options(opts))
end

for _, mode in ipairs { "n", "o", "i", "x", "t", "c" } do
  M[mode .. "map"] = function(...)
    M.map(mode, ...)
  end
end

M.buf_map = function(bufnr, mode, target, source, opts)
  opts = opts or {}
  opts.buffer = bufnr

  M.map(mode, target, source, get_map_options(opts))
end

M.t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

M.input = function(keys, mode)
  api.nvim_feedkeys(M.t(keys), mode or "m", true)
end

M.warn = function(msg)
  api.nvim_echo({ { msg, "WarningMsg" } }, true, {})
end

M.gfind = function(str, substr, cb, init)
  init = init or 1
  local start_pos, end_pos = str:find(substr, init)
  if start_pos then
    cb(start_pos, end_pos)
    return M.gfind(str, substr, cb, end_pos + 1)
  end
end

-- const myString = "hello ${}" ->
-- const myString = `hello ${}`
local change_template_string_quotes = function()
  local row, col = unpack(api.nvim_win_get_cursor(0))
  row = row - 1

  local quote_start, quote_end
  M.gfind(api.nvim_get_current_line(), "[\"']", function(pos)
    if not quote_start then
      -- start at first quote
      quote_start = pos
    elseif pos < col then
      -- move start if quote is closer to col
      if (pos - col) > (quote_start - col) then
        quote_start = pos
      end
    elseif not quote_end then
      -- first quote after col is end
      quote_end = pos
    end
  end)

  -- if found, replace quotes with backticks
  if quote_start and quote_start <= col and quote_end then
    api.nvim_buf_set_text(0, row, quote_start - 1, row, quote_start, { "`" })
    api.nvim_buf_set_text(0, row, quote_end - 1, row, quote_end, { "`" })
  end

  -- input and move cursor into pair
  M.input("${}", "n")
  M.input "<Left>"
end

-- padding: 40px; ->
-- padding: "40px",
local css_to_js = function(opts)
  local start_line, end_line
  if type(opts) == "table" then
    -- called via command
    start_line, end_line = opts.line1 - 1, opts.line2
  else
    -- called as operator
    start_line = api.nvim_buf_get_mark(0, "[")[1] - 1
    end_line = api.nvim_buf_get_mark(0, "]")[1] + 1
  end

  local did_convert = false
  for i, line in ipairs(api.nvim_buf_get_lines(0, start_line, end_line, false)) do
    -- if the line ends in a comma, it's probably already js
    if line:sub(#line) == "," then
      goto continue
    end
    -- ignore comments
    if line:find "%/%*" then
      goto continue
    end

    local indentation, name, val = line:match "(%s+)(.+):%s(.+)"
    -- skip non-matching lines
    if not (name and val) then
      goto continue
    end

    local parsed_name = ""
    for j, component in ipairs(vim.split(name, "-")) do
      parsed_name = parsed_name .. (j == 1 and component or (component:sub(1, 1):upper() .. component:sub(2)))
    end

    local parsed_val = val:gsub(";", "")
    -- keep numbers, wrap others in quotes
    parsed_val = tonumber(parsed_val) or string.format('"%s"', parsed_val)
    local parsed_line = table.concat { indentation, parsed_name, ": ", parsed_val, "," }

    did_convert = true
    local row = start_line + i
    api.nvim_buf_set_lines(0, row - 1, row, false, { parsed_line })

    ::continue::
  end

  if not did_convert then
    M.warn "css-to-js: nothing to convert"
  end
end

_G.css_to_js = css_to_js

local function on_attach(client, bufnr)
  client.server_capabilities.documentFormattingProvider = false
  client.server_capabilities.documentRangeFormattingProvider = false
  require("lvim.lsp").common_on_attach(client, bufnr)
  api.nvim_buf_create_user_command(bufnr, "CssToJs", css_to_js, { range = true })
  M.buf_map(bufnr, "i", "${", change_template_string_quotes, { nowait = true })
  M.buf_map(bufnr, "n", "gx", ":set opfunc=v:lua.css_to_js<CR>g@")
  M.buf_map(bufnr, "n", "gxx", ":CssToJs<CR>")
  M.buf_map(bufnr, "v", "gx", ":CssToJs<CR>")
end

M.config = function()
  local status_ok, ts = pcall(require, "typescript")
  if not status_ok then
    return
  end

  local ok, lvim_lsp = pcall(require, "lvim.lsp")
  if not ok then
    return
  end

  ts.setup {
    disable_commands = false, -- prevent the plugin from creating Vim commands
    disable_formatting = false, -- disable tsserver's formatting capabilities
    debug = false, -- enable debug logging for commands
    server = { -- pass options to lspconfig's setup method
      settings = {
        typescript = {
          inlayHints = {
            includeInlayParameterNameHints = "all",
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
          },
        },
        javascript = {
          inlayHints = {
            includeInlayParameterNameHints = "all",
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
          },
        },
      },
      on_attach = on_attach,
      capabilities = lvim_lsp.common_capabilities(),
    },
  }
end

return M
