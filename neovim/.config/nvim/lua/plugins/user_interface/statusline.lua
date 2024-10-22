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
