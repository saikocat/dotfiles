local function progress_as_scrollbar()
  local sbar_chars = {
    '▔',
    '🮂',
    '🬂',
    '🮃',
    '▀',
    '▄',
    '▃',
    '🬭',
    '▂',
    '▁',
  }

  local cur_line = vim.api.nvim_win_get_cursor(0)[1]
  local lines = vim.api.nvim_buf_line_count(0)

  local i = math.floor((cur_line - 1) / lines * #sbar_chars) + 1
  local sbar = string.rep(sbar_chars[i], 2)

  return '%#' .. 'Substitute' .. '#' .. sbar .. '%*'
end

return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    options = {
      icons_enabled = true,
      theme = 'auto',
    },
    sections = {
      lualine_a = { 'mode' },
      lualine_b = { 'branch', 'diff', 'diagnostics' },
      lualine_c = { { 'filename', path = 3 } },
      lualine_x = { 'encoding', 'fileformat', 'filetype' },
      lualine_y = { 'searchcount', 'selectioncount', 'progress' },
      lualine_z = { 'location' },
    },
    inactive_sections = {
      lualine_c = {
        {
          'filename',
          path = 3,
        },
      },
    },
    tabline = {
      lualine_a = {
        {
          'tabs',
          max_length = vim.o.columns / 3,
          mode = 1,
          path = 0,
          symbols = { modified = '●' },
        },
      },
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = { { 'tabs', symbols = { modified = '●' } } },
    },
    -- winbar = {},
  },
}
