-- Treesitter: Highlight, edit, and navigate code
--
-- To recompile everything, delete all from these 2 directories:
--   * ~/.local/share/nvim/site/parser/
--   * ~/.local/share/nvim/site/queries/

-- Disable built-in ftplugin mappings to avoid conflicts with textobjects.
-- See https://github.com/neovim/neovim/tree/master/runtime/ftplugin
vim.g.no_plugin_maps = true

-- Treesitter context
require('treesitter-context').setup {
  max_lines = 4,
  multiline_threshold = 2,
}

-- Textobject keymaps
require('config.treesitter_textobjects_keymaps').setup()

-- Main treesitter config
local ts = require 'nvim-treesitter'
ts.install({
  'bash',
  'c',
  'comment',
  'cmake',
  'diff',
  'dockerfile',
  'editorconfig',
  'git_config',
  'git_rebase',
  'gitcommit',
  'gitignore',
  'go',
  'gomod',
  'gotmpl',
  'html',
  'java',
  'javascript',
  'jq',
  'json',
  'just',
  'kotlin',
  'latex',
  'lua',
  'luadoc',
  'markdown',
  'markdown_inline',
  'python',
  'query',
  'regex',
  'rust',
  'scala',
  'sql',
  'terraform',
  'toml',
  'typescript',
  'vim',
  'vimdoc',
}, {
  max_jobs = 8,
})

local group = vim.api.nvim_create_augroup('TreesitterSetup', { clear = true })

local ignore_filetypes = {
  'checkhealth',
  'blink-cmp-menu',
  'fidget',
  'mason',
  'mason_backdrop',
  'netrw',
  'neo-tree',
  'snacks_dashboard',
  'snacks_notif',
  'snacks_win',
}

-- Auto-install parsers and enable highlighting on FileType
vim.api.nvim_create_autocmd('FileType', {
  group = group,
  desc = 'Enable treesitter highlighting and indentation',
  callback = function(event)
    if vim.tbl_contains(ignore_filetypes, event.match) then
      return
    end

    local lang = vim.treesitter.language.get_lang(event.match) or event.match
    local buf = event.buf

    -- Start highlighting immediately (works if parser exists)
    pcall(vim.treesitter.start, buf, lang)

    -- Enable treesitter indentation
    vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

    -- Install missing parsers (async, no-op if already installed)
    ts.install { lang }
  end,
})
