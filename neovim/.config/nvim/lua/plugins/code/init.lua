return {
  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

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
