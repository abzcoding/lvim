local M = {}

M.config = function()
  local status_ok, gp = pcall(require, "nvim-gps")
  if not status_ok then
    vim.notify "nvim-gps not found"
    return
  end

  gp.setup {
    disable_icons = false, -- Setting it to true will disable all icons

    icons = {
      ["class-name"] = " ", -- Classes and class-like objects
      ["function-name"] = "󰊕 ", -- Functions
      ["method-name"] = " ", -- Methods (functions inside class-like objects)
      -- ["container-name"] = "⛶ ", -- Containers (example: lua tables)
      ["tag-name"] = "󰓹", -- Tags (example: html tags)
    },

    -- Add custom configuration per language or
    -- Disable the plugin for a language
    -- Any language not disabled here is enabled by default
    languages = {
      -- Some languages have custom icons
      ["json"] = {
        icons = {
          ["array-name"] = " ",
          ["object-name"] = " ",
          ["null-name"] = "[] ",
          ["boolean-name"] = "󰦏 ",
          ["number-name"] = "# ",
          ["string-name"] = " ",
        },
      },
      ["latex"] = {
        icons = {
          ["title-name"] = "#",
          ["label-name"] = "",
        },
      },
      ["norg"] = {
        icons = {
          ["title-name"] = "",
        },
      },
      ["toml"] = {
        icons = {
          ["table-name"] = "󰓫 ",
          ["array-name"] = " ",
          ["boolean-name"] = "󰦏 ",
          ["date-name"] = " ",
          ["date-time-name"] = "󰃰 ",
          ["float-name"] = "󰉧 ",
          ["inline-table-name"] = "󰨘 ",
          ["integer-name"] = "# ",
          ["string-name"] = " ",
          ["time-name"] = " ",
        },
      },
      ["verilog"] = {
        icons = {
          ["module-name"] = " ",
        },
      },
      ["yaml"] = {
        icons = {
          ["mapping-name"] = "󰍍 ",
          ["sequence-name"] = "󰜩 ",
          ["null-name"] = "[] ",
          ["boolean-name"] = "󰦏 ",
          ["integer-name"] = "# ",
          ["float-name"] = "󰉧 ",
          ["string-name"] = " ",
        },
      },
      ["yang"] = {
        icons = {
          ["module-name"] = "󰕳",
          ["augment-path"] = "󰴠",
          ["container-name"] = "󱣘",
          ["grouping-name"] = " ",
          ["typedef-name"] = "",
          ["identity-name"] = "󰻾",
          ["list-name"] = "󱃔",
          ["leaf-list-name"] = "󰌪",
          ["leaf-name"] = "󰲓",
          ["action-name"] = "",
        },
      },
    },

    separator = " > ",

    depth = 0,

    -- indicator used when context hits depth limit
    depth_limit_indicator = "..",
  }
end

return M
