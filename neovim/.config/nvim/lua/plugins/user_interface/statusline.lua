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
      theme = 'ayu',
    },
    sections = {
      lualine_c = {
        {
          'filename',
          path = 3,
        },
      },
      lualine_y = {
        function()
          return progress_as_scrollbar()
        end,
      },
    },
    inactive_sections = {
      lualine_c = {
        {
          'filename',
          path = 3,
        },
      },
    },
  },
}
