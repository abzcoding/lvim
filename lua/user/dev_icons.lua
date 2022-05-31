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
  lvim.builtin.nvimtree.setup.renderer.icons.show = {
    git = true,
    folder = true,
    file = true,
    folder_arrow = true,
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
  lvim.builtin.bufferline.options.show_buffer_icons = true
  lvim.builtin.bufferline.options.show_buffer_close_icons = true
end

return M
