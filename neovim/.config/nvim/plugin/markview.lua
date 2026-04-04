-- Markview: load when entering supported prose/document filetypes.

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'markdown', 'quarto', 'rmd', 'typst', 'asciidoc' },
  once = true,
  callback = function()
    vim.pack.add({ 'https://github.com/OXY2DEV/markview.nvim' })
  end,
})
