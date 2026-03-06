-- Rustファイル保存時にLSP経由でrustfmtを自動適用する
vim.api.nvim_create_autocmd("BufWritePre", {
  buffer = 0,
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})
