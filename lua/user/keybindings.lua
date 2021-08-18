local M = {}

M.config = function()
  -- Additional keybindings
  -- =========================================
  lvim.keys.normal_mode["<C-n>i"] = { "<C-i>", { noremap = true } }
  lvim.keys.normal_mode["<S-x>"] = ":BufferClose<CR>"
  lvim.keys.normal_mode["<esc><esc>"] = "<cmd>nohlsearch<cr>"
  lvim.keys.normal_mode["Y"] = "y$"
  lvim.keys.visual_mode["p"] = [["_dP]]
  lvim.keys.insert_mode["jk"] = "<ESC>:w<CR>"
  lvim.keys.insert_mode["<c-s>"] = "<cmd>lua vim.lsp.buf.signature_help()<cr>"
  lvim.keys.normal_mode["gv"] = "<cmd>vsplit | lua vim.lsp.buf.definition()<cr>"

  -- WhichKey keybindings
  -- =========================================
  lvim.builtin.which_key.mappings["o"] = { "<cmd>SymbolsOutline<cr>", "Symbol Outline" }
  lvim.builtin.which_key.mappings["t"] = {
    name = "+Trouble",
    r = { "<cmd>Trouble lsp_references<cr>", "References" },
    f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
    d = { "<cmd>Trouble lsp_document_diagnostics<cr>", "Diagnosticss" },
    q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
    l = { "<cmd>Trouble loclist<cr>", "LocationList" },
    t = { "<cmd>TodoLocList <cr>", "Todo" },
    w = { "<cmd>Trouble lsp_workspace_diagnostics<cr>", "Diagnosticss" },
  }
  lvim.builtin.which_key.mappings["z"] = { "<cmd>ZenMode<cr>", "Zen" }
  if lvim.builtin.persistence then
    lvim.builtin.which_key.mappings["q"] = {
      name = "+Quit",
      s = { "<cmd>lua require('persistence').load()<cr>", "Restore for current dir" },
      l = { "<cmd>lua require('persistence').load(last=true)<cr>", "Restore last session" },
      d = { "<cmd>lua require('persistence').stop()<cr>", "Quit without saving session" },
    }
  end
  lvim.builtin.which_key.mappings["gd"] = { "<cmd>DiffviewOpen HEAD~1<cr>", "Diff" }
  lvim.builtin.which_key.mappings["dU"] = { "<cmd>lua require('dapui').toggle()<cr>", "Toggle UI" }
  lvim.builtin.which_key.mappings["de"] = { "<cmd>lua require('dapui').eval()<cr>", "Eval" }
  lvim.builtin.which_key.mappings["lf"] = { "<cmd>lua vim.lsp.buf.formatting()<cr>", "Format" }
  lvim.builtin.which_key.mappings["r"] = "Run"
  lvim.builtin.which_key.mappings["m"] = "Make"
  lvim.builtin.which_key.mappings["T"] = "Test"
  lvim.builtin.which_key.mappings["H"] = "Help"
  lvim.builtin.which_key.mappings["R"] = {
    name = "Replace",
    p = { "<cmd>lua require('spectre').open()<cr>", "Project" },
    w = { "<cmd>lua require('spectre').open_visual({select_word=true})<cr>", "Replace Word" },
    f = { "<cmd>lua require('spectre').open_file_search()<cr>", "Current Buffer" },
  }
  lvim.builtin.which_key.mappings["lh"] = {
    "<cmd>hi LspReferenceRead cterm=bold ctermbg=red guibg=#24283b<cr><cmd>hi LspReferenceText cterm=bold ctermbg=red guibg=#24283b<cr><cmd>hi LspReferenceWrite cterm=bold ctermbg=red guibg=#24283b<cr>",
    "Clear HL",
  }
  if lvim.builtin.lir.active then
    lvim.builtin.which_key.mappings["."] = { "<cmd>lua require('lir.float').toggle()<cr>", "Files" }
  end
end

return M
