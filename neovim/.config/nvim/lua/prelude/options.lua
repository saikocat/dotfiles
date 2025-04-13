local opts_info = vim.api.nvim_get_all_options_info()

local opt_select = setmetatable({}, {
  __newindex = function(_, key, value)
    vim.o[key] = value
    local scope = opts_info[key].scope
    if scope == 'win' then
      vim.wo[key] = value
    elseif scope == 'buf' then
      vim.bo[key] = value
    end
  end,
})

local function append(value, str, sep)
  sep = sep or ','
  str = str or ''
  value = type(value) == 'table' and table.concat(value, sep) or value
  return str ~= '' and table.concat({ value, str }, sep) or value
end

-- [[ Setting options ]]
-- See `:help vim.o`

-- Line numbers {{{

vim.o.number = true
vim.o.relativenumber = true

-- }}}

-- Timing {{{

vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300
-- vim.o.ttimeoutlen = 100

-- }}}

-- Encoding {{{

vim.o.encoding = 'utf-8'
vim.o.fileencoding = 'utf-8'

-- }}}

-- Window splitting and buffers {{{

vim.o.ruler = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.eadirection = 'hor'
-- exclude usetab as we do not want to jump to buffers in already open tabs
-- do not use split or vsplit to ensure we don't open any new windows
vim.o.switchbuf = 'useopen,uselast'
-- hides buffers instead of closing them to prevent forced write or undo changes
vim.o.hidden = true

-- }}}

-- [[ Indentation ]]

opt_select.wrap = true
opt_select.breakindent = true

vim.o.expandtab = true -- spaces instead of tabs
vim.o.shiftwidth = 4 -- (Auto)indent uses 4 characters
vim.o.softtabstop = 4 -- let backspace delete ident
vim.o.tabstop = 4 -- Tabs are 2 characters
vim.o.shiftround = true -- Shift to the next round tab stop
vim.o.backspace = append { 'indent', 'eol', 'start' }

-- Display {{{

vim.o.cmdheight = 2 -- Set command line height to two lines
opt_select.breakindentopt = 'sbr'
vim.o.showbreak = '↪ ' -- '↳ '  -- Options include -> '…', '↳ ', '→','↪ ',[[↪ ]]

vim.g.vimsyn_embed = 'lPr' -- allow embedded syntax highlighting for lua,python and ruby

-- }}}

-- List chars {{{

vim.o.list = true -- invisible chars
vim.opt.listchars = {
  tab = '» ',
  trail = '•',
  eol = '¬',
  extends = '›',
  precedes = '‹',
  nbsp = '␣',
}
-- vim.o.listchars = append {
--   'eol:¬',
--   'tab:| ',
--   'extends:›',
--   'precedes:‹',
--   'trail:•', -- BULLET (U+2022, UTF-8: E2 80 A2)
-- }
-- vim.o.listchars = 'tab:»\\ ,extends:›,precedes:‹,trail:·,eol:¬'

-- }}}

-- Emoji {{{

-- emoji is true by default but makes (n)vim treat all emoji as double width
-- which breaks rendering so we turn this off.
-- CREDIT: https://www.youtube.com/watch?v=F91VWOelFNE
vim.o.emoji = false

-- }}}

-- Clipboard sync {{{
-- Remove this option if you want your OS clipboard to remain independent.
-- See `:help 'clipboard'`

vim.o.clipboard = 'unnamedplus'

-- }}}

-- Match & Search and, Hightlight {{{

vim.o.magic = true
vim.o.hlsearch = true --  Highlight search terms
vim.o.incsearch = true --  Jump while typing
vim.o.showmatch = true --  Show matching braces
vim.o.wrapscan = true
vim.o.smartcase = false
vim.o.ignorecase = false
vim.o.scrolloff = 9 -- number of lines to keep above & below cursor
vim.o.sidescrolloff = 10 -- 5 0 0
vim.o.sidescroll = 1

-- }}}

-- Wild and file globbing stuff in command mode {{{

vim.o.wildchar = ('\t'):byte()
vim.o.wildmenu = true
vim.o.wildmode = 'longest:full,list,full' -- Shows a menu bar as opposed to an enormous list
vim.o.wildignorecase = true -- Ignore case when completing file names and directories
-- Ignore binary files
vim.o.wildignore = append {
  '*.aux,*.out,*.toc',
  '*.o,*.obj,*.dll,*.jar,*.pyc,*.rbc,*.class,*.so',
  '*.ai,*.bmp,*.gif,*.ico,*.jpg,*.jpeg,*.png,*.psd,*.webp',
  '*.avi,*.m4a,*.mp3,*.oga,*.ogg,*.wav,*.webm',
  '*.eot,*.otf,*.ttf,*.woff',
  '*.doc,*.pdf',
  '*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz',
  -- Temp/System
  '*.*~,*~ ',
  '*.swp,.lock,.DS_Store,._*,tags.lock',
}
vim.o.wildoptions = 'pum'
vim.o.pumblend = 3 -- Make popup window translucent

-- }}}

--  Max column {{{

vim.o.textwidth = 0
vim.o.wrapmargin = 0
vim.wo.colorcolumn = '81'
opt_select.linebreak = true -- lines wrap at words rather than random characters
opt_select.synmaxcol = 1024 -- don't syntax highlight long lines
opt_select.signcolumn = 'yes:2'

-- }}}

-- Mouse {{{

vim.o.mouse = 'a'
vim.o.mousefocus = true

-- }}}

-- Backup, undo, and swaps {{{

vim.o.confirm = true

vim.o.undofile = true
vim.o.undolevels = 500
vim.o.undodir = vim.fn.expand '~/.cache/nvim/undo'
vim.o.directory = vim.fn.expand '~/.cache/nvim/swap'
vim.o.backupdir = vim.fn.expand '~/.cache/nvim/backup'
vim.o.history = 1000

for _, dir in pairs { vim.o.undodir, vim.o.backupdir } do
  if vim.fn.isdirectory(dir) == 0 then
    vim.fn.mkdir(dir, 'p')
  end
end

-- }}}

-- Utilities {{{

vim.o.inccommand = 'split'

-- }}}

-- [[ Perf ]]
vim.o.background = 'dark'
vim.o.lazyredraw = true
vim.o.termguicolors = true
-- vim.o.t_Co = '256'

-- Set completeopt to have a better completion experience {{{

vim.o.completeopt = append { 'menuone', 'noinsert', 'noselect' }

-- }}}

-- Diff {{{

vim.o.diffopt = append({
  'vertical',
  'iwhite',
  'hiddenoff',
  'foldcolumn:0',
  'context:4',
  'algorithm:histogram',
  'indent-heuristic',
}, vim.o.diffopt)

-- }}}

-- Folds {{{

-- vim.o.foldtext = 'v:lua.folds()'
-- vim.o.foldopen = add(vim.o.foldopen, 'search')
-- vim.o.foldlevel = 99
-- vim.o.foldlevelstart = 10
-- opt_select.foldmethod = 'syntax'

-- }}}

-- Show which line your cursor is on
vim.o.cursorline = true

vim.o.winborder = 'rounded'

-- vim: ts=2 sts=2 sw=2 et foldenable foldlevel=1 foldmethod=marker
