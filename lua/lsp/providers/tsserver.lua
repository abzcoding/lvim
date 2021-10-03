local opts = {
  on_attach = function(client, _)
    require("nvim-lsp-ts-utils").setup_client(client)
  end,
}

return opts
