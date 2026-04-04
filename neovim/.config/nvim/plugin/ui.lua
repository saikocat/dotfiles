-- UI plugins: which-key, indent-blankline, todo-comments, lualine

-- Indent guides on blank lines
require('ibl').setup()

-- Which-key: show pending keybinds
require('which-key').setup {
  delay = 0,
  icons = {
    mappings = vim.g.have_nerd_font,
    keys = vim.g.have_nerd_font and {} or {
      Up = '<Up> ',
      Down = '<Down> ',
      Left = '<Left> ',
      Right = '<Right> ',
      C = '<C-…> ',
      M = '<M-…> ',
      D = '<D-…> ',
      S = '<S-…> ',
      CR = '<CR> ',
      Esc = '<Esc> ',
      ScrollWheelDown = '<ScrollWheelDown> ',
      ScrollWheelUp = '<ScrollWheelUp> ',
      NL = '<NL> ',
      BS = '<BS> ',
      Space = '<Space> ',
      Tab = '<Tab> ',
      F1 = '<F1>',
      F2 = '<F2>',
      F3 = '<F3>',
      F4 = '<F4>',
      F5 = '<F5>',
      F6 = '<F6>',
      F7 = '<F7>',
      F8 = '<F8>',
      F9 = '<F9>',
      F10 = '<F10>',
      F11 = '<F11>',
      F12 = '<F12>',
    },
  },
  spec = {
    { '<leader>p', group = '[P]ack' },
    { '<leader>s', group = '[S]earch' },
    { '<leader>t', group = '[T]oggle' },
    { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
  },
}

-- Todo-comments: highlight TODO, FIXME, NOTE etc in comments
require('todo-comments').setup { signs = false }

-- Lualine: statusline
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    always_show_tabline = false,
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
}
