vim.api.nvim_create_autocmd({
  'BufNewFile',
  'BufRead',
}, {
  pattern = '*.overlay',
  callback = function()
    local buf = vim.api.nvim_get_current_buf()
    vim.api.nvim_set_option_value('filetype', 'dts', { buf = buf })
  end,
})
