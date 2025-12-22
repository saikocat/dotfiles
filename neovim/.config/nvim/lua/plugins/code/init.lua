return {
  'NMAC427/guess-indent.nvim', -- Detect tabstop and shiftwidth automatically

  require 'plugins.code.treesitter',
  require 'plugins.code.trouble',
  require 'plugins.code.comment',
  require 'plugins.code.conform',
  require 'plugins.code.lint',
  -- require('plugins.code.autopairs'),

  {
    'NoahTheDuke/vim-just',
    ft = { 'just' },
  },
}
