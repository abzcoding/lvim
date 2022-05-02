local M = {}

M.set_icon = function()
  require("nvim-web-devicons").set_icon {
    rs = {
      icon = "",
      color = "#d28445",
      name = "Rust",
    },
    tf = {
      icon = "ﲽ",
      color = "#3d59a1",
      name = "Terraform",
    },
    tfvars = {
      icon = "ﲽ",
      color = "#51afef",
      name = "Terraform",
    },
    mod = {
      icon = "ﳑ",
      color = "#6a9fb5",
      name = "Mod",
    },
    sum = {
      icon = "",
      color = "#6a9fb5",
      name = "Sum",
    },
    txt = {
      icon = "",
      color = "#bbc2cf",
      name = "Text",
    },
    csv = {
      icon = "",
      color = "#31B53E",
      name = "CSV",
    },
    plist = {
      icon = "",
      color = "#8FAA54",
      name = "Plist",
    },
    burp = {
      icon = "",
      color = "#F16529",
      name = "Burp",
    },
    mp4 = {
      icon = "",
      color = "#5fd7ff",
      name = "MP4",
    },
    mkv = {
      icon = "",
      color = "#5fd7ff",
      name = "MKV",
    },
    hcl = {
      icon = "",
      color = "#689FB6",
      name = "HCL",
    },
    sol = {
      icon = "",
      color = "#555555",
      name = "Sol",
    },
  }
end

M.use_my_icons = function()
  for _, sign in ipairs(lvim.lsp.diagnostics.signs.values) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
  end
  lvim.builtin.nvimtree.setup.diagnostics.enable = true
  lvim.builtin.nvimtree.setup.renderer.icons.webdev_colors = true
  lvim.builtin.nvimtree.show_icons = {
    git = 1,
    folders = 1,
    files = 1,
    folder_arrows = 1,
  }
  vim.fn.sign_define("DapBreakpoint", lvim.builtin.dap.breakpoint)
  vim.fn.sign_define("DapBreakpointRejected", lvim.builtin.dap.breakpoint_rejected)
  vim.fn.sign_define("DapStopped", lvim.builtin.dap.stopped)
  lvim.builtin.notify.opts.icons = {
    ERROR = "",
    WARN = "",
    INFO = "",
    DEBUG = "",
    TRACE = "✎",
  }
  lvim.builtin.cmp.formatting.format = function(entry, vim_item)
    local max_width = lvim.builtin.cmp.formatting.max_width
    if max_width ~= 0 and #vim_item.abbr > max_width then
      vim_item.abbr = string.sub(vim_item.abbr, 1, max_width - 1) .. "…"
    end
    vim_item.kind = lvim.builtin.cmp.formatting.kind_icons[vim_item.kind]
    vim_item.menu = lvim.builtin.cmp.formatting.source_names[entry.source.name]
    vim_item.dup = lvim.builtin.cmp.formatting.duplicates[entry.source.name]
      or lvim.builtin.cmp.formatting.duplicates_default
    return vim_item
  end
  lvim.builtin.bufferline.options.show_buffer_icons = true
  lvim.builtin.bufferline.options.show_buffer_close_icons = true
end

return M
