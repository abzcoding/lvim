local user_tex = require("user.tex").config()

local opts = {
  setup = user_tex,
}

require("lvim.lsp.manager").setup("texlab", opts)
