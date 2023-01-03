set nocompatible

" --- Plugin Manager ---
if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif


" --- Essential ---
set encoding=utf-8

set wrap
set nopaste

" Undo
set undofile
set undodir=~/.vim/undo/
set directory=~/.vim/swap/
set backupdir=~/.vim/swap/

set history=64
set undolevels=1000

" write before hiding a buffer
set autowrite

" Don't update the display while executing macros
set lazyredraw

" syntax highlight
syntax on
filetype plugin indent on

" indentation
set autoindent
set expandtab       " spaces instead of tabs
set shiftwidth=4    " (Auto)indent uses 2 characters
set softtabstop=4   " let backspace delete ident
set tabstop=4       " Tabs are 2 characters
set shiftround      " Shift to the next round tab stop

set backspace=indent,eol,start

" line number & relative line number combo
set number
set relativenumber

" no folding
set nofoldenable

" show a ruler
set ruler

" expand the command line using tab
set wildchar=<Tab>
set wildmode=longest,list,full
set wildmenu
" always show the menu, insert longest match
set completeopt=menuone,longest
" ignore
set wildignore+=*.swp,*.bak
set wildignore+=*.pyc,*.class,*.cache,*.dll,*.o,*.obj,*.so
set wildignore+=*/.git/**/*,*/.hg/**/*,*/.svn/**/*
set wildignore+=*/node_modules/*
set wildignore+=*.tar.*,*.zip

" show partial commands
set showcmd

set scrolloff=5
set mouse=a

" always use vertical diffs
set diffopt+=vertical

set laststatus=2

" open new split panes to right and bottom, which feels more natural
set splitright
set splitbelow

" no bells
set noeb vb t_vb=
augroup NoBells
    autocmd GUIEnter * set visualbell t_vb=
augroup END

"Fix terminal timeout when pressing escape
set ttimeoutlen=10
augroup FastEscape
    autocmd!
    au InsertEnter * set timeoutlen=0
    au InsertLeave * set timeoutlen=1000
augroup END

" Looks and Appearance {{{
" =============================================================================
" Colorscheme & Font {{{
" colorscheme monokai
colorscheme srcery
set background=dark
set gfn=Source\ Code\ Pro\ 9
" }}}

" Cursor Shape : _ for replace, | for insert, [] for visual {{{
" fix cursor shape for tmux else it will just block
if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_SR = "\<Esc>]50;CursorShape=2\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif
" }}}

" --- Highlight ---
" highlight the searchterms
set hlsearch
" jump to the matches while typing
set incsearch
" show matching braces
set showmatch

" max column
set textwidth=0
set wrapmargin=0
set colorcolumn=81

" Soft line break {{{
" Make soft line breaks much better looking - if v:version > 703 endif
set breakindent
" Pretty soft break character.
let &showbreak='↳ '
" }}}

" display extra whitespace
set list listchars=tab:»\ ,extends:›,precedes:‹,trail:·,eol:¬

highlight NonText guifg=#444444 guibg=bg ctermfg=DarkGray ctermbg=bg
highlight SpecialKey guifg=#444444 guibg=bg ctermfg=DarkGray ctermbg=bg
" highlight ColorColumn guibg=#232728

" }}}

" --- Per filetype configuration ---
augroup vimrcEx
    autocmd!

    " When editing a file, always jump to the last known cursor position.
    " Don't do it for commit messages, when the position is invalid, or when
    " inside an event handler (happens when dropping a file on gvim).
    autocmd BufReadPost *
        \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal g`\"" |
        \ endif

    " Set syntax highlighting for specific file types
    " Enable spellchecking for Markdown
    " Automatically wrap at 80 characters for Markdown
    autocmd BufRead,BufNewFile *.md setlocal filetype=markdown spell textwidth=80 fo+=t

    " Automatically wrap at 72 characters and spell check git commit messages
    autocmd FileType gitcommit setlocal textwidth=72
    autocmd FileType gitcommit setlocal spell

    " Allow stylesheets to autocomplete hyphenated words
    autocmd FileType css,scss,sass,less setlocal iskeyword+=-

    " JVM filetypes
    au BufWinEnter,BufNewFile,BufRead *.gradle set filetype=groovy

    " Configuration
    autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

    " Java
    " autocmd FileType java setlocal omnifunc=javacomplete#Complete

    " Go
    autocmd BufWritePre *.go :silent call CocAction('runCommand', 'editor.action.organizeImport')
augroup END


" --- Remapping ---
let mapleader = ","

" leader cd to change to current file dir
map ,cd :cd %:p:h<CR>:pwd<CR>

" strip whitespace
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" reselect the text that was just pasted
nnoremap <leader>v V`]

" clear highlight with leader space
nnoremap <leader><space> :noh<cr>

" force redraw with <c-l>
nnoremap <c-l> :redraw!<cr>

" User tab for matching bracket
nnoremap <tab> %
vnoremap <tab> %

" remap to easily access cmd, double tap for ; func for f/F/t/T
nnoremap ; :
vnoremap ; :
noremap ;; ;
autocmd CmdLineEnter * set timeoutlen=175

" Local config
if filereadable($HOME . "/.vimrc.local")
    source ~/.vimrc.local
endif

" vim:sw=2:ts=2:et:foldenable:foldlevel=1:foldmethod=marker:
