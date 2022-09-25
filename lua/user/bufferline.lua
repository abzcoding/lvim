local M = {}

M.config = function()
  local kind = require "user.lsp_kind"
  lvim.builtin.bufferline.highlights = {
    fill = {
      bg = {
        attribute = "bg",
        highlight = "NormalNC",
      },
    },
    background = { italic = true },
    buffer_selected = { bold = true },
  }
  local g_ok, bufferline_groups = pcall(require, "bufferline.groups")
  if not g_ok then
    bufferline_groups = {
      builtin = {
        pinned = {
          name = "pinned",
          with = function(ico)
            print(ico)
          end,
        },
        ungroupued = { name = "ungrouped" },
      },
    }
  end
  lvim.builtin.bufferline.options = {
    navigation = { mode = "uncentered" },
    diagnostics = false, -- do not show diagnostics in bufferline
    diagnostics_indicator = function(_, _, diagnostics)
      local result = {}
      local symbols = { error = kind.icons.error, warning = kind.icons.warn, info = kind.icons.info }
      for name, count in pairs(diagnostics) do
        if symbols[name] and count > 0 then
          table.insert(result, symbols[name] .. count)
        end
      end
      local res = table.concat(result, " ")
      return #res > 0 and res or ""
    end,

    mode = "buffers",
    sort_by = "insert_after_current",
    groups = {
      options = {
        toggle_hidden_on_enter = true,
      },
      items = {
        bufferline_groups.builtin.pinned:with { icon = "" },
        bufferline_groups.builtin.ungrouped,
        {
          name = "Dependencies",
          icon = kind.icons.config,
          highlight = { fg = "#ECBE7B" },
          matcher = function(buf)
            return vim.startswith(buf.path, string.format("%s/site/pack/packer", vim.fn.stdpath "data"))
              or vim.startswith(buf.path, vim.fn.expand "$VIMRUNTIME")
          end,
        },
        {
          highlight = { sp = "#51AFEF" },
          name = "tests",
          icon = kind.icons.test,
          matcher = function(buf)
            local name = buf.filename
            return name:match "_spec" or name:match "_test" or name:match "test_"
          end,
        },
        {
          name = "Terraform",
          matcher = function(buf)
            return buf.name:match "%.tf" ~= nil
          end,
        },
        {
          name = "SQL",
          matcher = function(buf)
            return buf.filename:match "%.sql$"
          end,
        },
        {
          name = "view models",
          highlight = { sp = "#03589C" },
          matcher = function(buf)
            return buf.filename:match "view_model%.dart"
          end,
        },
        {
          name = "screens",
          icon = kind.icons.screen,
          matcher = function(buf)
            return buf.path:match "screen"
          end,
        },
        {
          highlight = { sp = "#C678DD" },
          name = "docs",
          matcher = function(buf)
            for _, ext in ipairs { "md", "txt", "org", "norg", "wiki" } do
              if ext == vim.fn.fnamemodify(buf.path, ":e") then
                return true
              end
            end
          end,
        },
        {
          highlight = { sp = "#F6A878" },
          name = "config",
          matcher = function(buf)
            local filename = buf.filename
            if filename == nil then
              return false
            end
            return filename:match "go.mod"
              or filename:match "go.sum"
              or filename:match "Cargo.toml"
              or filename:match "manage.py"
              or filename:match "Makefile"
          end,
        },
      },
    },
    hover = { enabled = true, reveal = { "close" } },
    offsets = {
      {
        text = "EXPLORER",
        filetype = "neo-tree",
        highlight = "PanelHeading",
        text_align = "left",
        separator = true,
      },
      {
        text = " FLUTTER OUTLINE",
        filetype = "flutterToolsOutline",
        highlight = "PanelHeading",
        separator = true,
      },
      {
        text = "UNDOTREE",
        filetype = "undotree",
        highlight = "PanelHeading",
        separator = true,
      },
      {
        text = " PACKER",
        filetype = "packer",
        highlight = "PanelHeading",
        separator = true,
      },
      {
        text = " DATABASE VIEWER",
        filetype = "dbui",
        highlight = "PanelHeading",
        separator = true,
      },
      {
        text = " DIFF VIEW",
        filetype = "DiffviewFiles",
        highlight = "PanelHeading",
        separator = true,
      },
    },
    separator_style = os.getenv "KITTY_WINDOW_ID" and "slant" or "thin",
    right_mouse_command = "vert sbuffer %d",
    show_close_icon = false,
    -- indicator = { style = "bold" },
    indicator = {
      icon = "▎", -- this should be omitted if indicator style is not 'icon'
      style = "icon", -- can also be 'underline'|'none',
    },
    max_name_length = 18,
    max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
    truncate_names = true, -- whether or not tab names should be truncated
    tab_size = 18,
    color_icons = true,
    show_buffer_close_icons = true,
    diagnostics_update_in_insert = false,
  }
end

return M
