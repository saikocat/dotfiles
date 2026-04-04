-- vim-just: load for Justfile buffers only.

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'just',
  once = true,
  callback = function()
    vim.pack.add({ 'https://github.com/NoahTheDuke/vim-just' })
  end,
})
