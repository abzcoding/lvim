local M = {}

M.config = function()
  -- Additional keybindings
  -- =========================================
  lvim.keys.insert_mode["jk"] = "<ESC>:w<CR>"
  lvim.keys.insert_mode["<C-s>"] = "<cmd>lua vim.lsp.buf.signature_help()<cr>"
  lvim.keys.normal_mode["<C-n>i"] = { "<C-i>", { noremap = true } }
  if lvim.builtin.fancy_bufferline.active then
    lvim.keys.normal_mode["<S-x>"] = ":bdelete!<CR>"
    lvim.keys.normal_mode["<S-l>"] = "<Cmd>BufferLineCycleNext<CR>"
    lvim.keys.normal_mode["<S-h>"] = "<Cmd>BufferLineCyclePrev<CR>"
    lvim.keys.normal_mode["[b"] = "<Cmd>BufferLineMoveNext<CR>"
    lvim.keys.normal_mode["]b"] = "<Cmd>BufferLineMovePrev<CR>"
  else
    lvim.keys.normal_mode["<S-x>"] = ":BufferClose<CR>"
  end
  lvim.keys.normal_mode["<esc><esc>"] = "<cmd>nohlsearch<cr>"
  lvim.keys.normal_mode["Y"] = "y$"
  lvim.keys.normal_mode["gv"] = "<cmd>vsplit | lua vim.lsp.buf.definition()<cr>"
  lvim.keys.visual_mode["p"] = [["_dP]]

  -- WhichKey keybindings
  -- =========================================
  if lvim.builtin.fancy_bufferline.active then
    lvim.builtin.which_key.mappings["b1"] = { "<Cmd>BufferLineGoToBuffer 1<CR>", "goto 1" }
    lvim.builtin.which_key.mappings["b2"] = { "<Cmd>BufferLineGoToBuffer 2<CR>", "goto 2" }
    lvim.builtin.which_key.mappings["b3"] = { "<Cmd>BufferLineGoToBuffer 3<CR>", "goto 3" }
    lvim.builtin.which_key.mappings["b4"] = { "<Cmd>BufferLineGoToBuffer 4<CR>", "goto 4" }
    lvim.builtin.which_key.mappings["b5"] = { "<Cmd>BufferLineGoToBuffer 5<CR>", "goto 5" }
    lvim.builtin.which_key.mappings["b6"] = { "<Cmd>BufferLineGoToBuffer 6<CR>", "goto 6" }
    lvim.builtin.which_key.mappings["b7"] = { "<Cmd>BufferLineGoToBuffer 7<CR>", "goto 7" }
    lvim.builtin.which_key.mappings["b8"] = { "<Cmd>BufferLineGoToBuffer 8<CR>", "goto 8" }
    lvim.builtin.which_key.mappings["b9"] = { "<Cmd>BufferLineGoToBuffer 9<CR>", "goto 9" }
    lvim.builtin.which_key.mappings["bc"] = { "<Cmd>BufferLinePickClose<CR>", "bufferline: delete buffer" }
    lvim.builtin.which_key.mappings["bp"] = { "<Cmd>BufferLinePick<CR>", "bufferline: pick buffer" }
  end
  if lvim.builtin.dap.active then
    lvim.builtin.which_key.mappings["de"] = { "<cmd>lua require('dapui').eval()<cr>", "Eval" }
    lvim.builtin.which_key.mappings["dU"] = { "<cmd>lua require('dapui').toggle()<cr>", "Toggle UI" }
  end
  lvim.builtin.which_key.mappings["H"] = "Help"
  lvim.builtin.which_key.mappings["lf"] = { "<cmd>lua vim.lsp.buf.formatting()<cr>", "Format" }
  lvim.builtin.which_key.mappings["lh"] = {
    "<cmd>hi LspReferenceRead cterm=bold ctermbg=red guibg=#24283b<cr><cmd>hi LspReferenceText cterm=bold ctermbg=red guibg=#24283b<cr><cmd>hi LspReferenceWrite cterm=bold ctermbg=red guibg=#24283b<cr>",
    "Clear HL",
  }
  if lvim.builtin.persistence then
    lvim.builtin.which_key.mappings["q"] = {
      name = "+Quit",
      d = { "<cmd>lua require('persistence').stop()<cr>", "Quit without saving session" },
      l = { "<cmd>lua require('persistence').load(last=true)<cr>", "Restore last session" },
      s = { "<cmd>lua require('persistence').load()<cr>", "Restore for current dir" },
    }
  end
  lvim.builtin.which_key.mappings["m"] = "Make"
  lvim.builtin.which_key.mappings["n"] = {
    name = "Neogen",
    c = { "<cmd>lua require('neogen').generate({ type = 'class'})<CR>", "Class Documentation" },
    f = { "<cmd>lua require('neogen').generate({ type = 'func'})<CR>", "Function Documentation" },
  }
  lvim.builtin.which_key.mappings["o"] = { "<cmd>SymbolsOutline<cr>", "Symbol Outline" }
  lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
  lvim.builtin.which_key.mappings["R"] = {
    name = "Replace",
    f = { "<cmd>lua require('spectre').open_file_search()<cr>", "Current Buffer" },
    p = { "<cmd>lua require('spectre').open()<cr>", "Project" },
    w = { "<cmd>lua require('spectre').open_visual({select_word=true})<cr>", "Replace Word" },
  }

  lvim.builtin.which_key.mappings["se"] = { "<cmd>lua require('user.telescope').file_browser()<cr>", "File Browser" }
  lvim.builtin.which_key.mappings["ss"] = { "<cmd>lua require('user.telescope').find_string()<cr>", "String" }
  lvim.builtin.which_key.mappings["r"] = "Run"
  lvim.builtin.which_key.mappings["T"] = {
    name = "Test",
    f = { "<cmd>TestFile<cr>", "File" },
    n = { "<cmd>TestNearest<cr>", "Nearest" },
    s = { "<cmd>TestSuite<cr>", "Suite" },
  }
  lvim.builtin.which_key.mappings["t"] = {
    name = "+Trouble",
    d = { "<cmd>Trouble lsp_document_diagnostics<cr>", "Diagnosticss" },
    f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
    l = { "<cmd>Trouble loclist<cr>", "LocationList" },
    q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
    r = { "<cmd>Trouble lsp_references<cr>", "References" },
    t = { "<cmd>TodoLocList <cr>", "Todo" },
    w = { "<cmd>Trouble lsp_workspace_diagnostics<cr>", "Diagnosticss" },
  }
  lvim.builtin.which_key.mappings["z"] = { "<cmd>ZenMode<cr>", "Zen" }
end

return M
