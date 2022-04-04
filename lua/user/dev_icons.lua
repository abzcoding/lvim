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

return M
