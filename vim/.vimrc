set nocompatible

" --- Plugin Manager ---
if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif


" --- Essential ---
set encoding=utf-8

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


" --- Colorscheme ---
set background=dark
colorscheme monokai
set gfn=Source\ Code\ Pro\ 9


" --- Highlight ---
" highlight the searchterms
set hlsearch
" jump to the matches while typing
set incsearch
" show matching braces
set showmatch

" max column
set textwidth=80
set colorcolumn=81

" display extra whitespace
set list listchars=tab:»\ ,extends:›,precedes:‹,trail:·,eol:¬

highlight NonText guifg=#444444 guibg=bg ctermfg=DarkGray ctermbg=bg
highlight SpecialKey guifg=#444444 guibg=bg ctermfg=DarkGray ctermbg=bg
" highlight ColorColumn guibg=#232728


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
    autocmd BufRead,BufNewFile *.md set filetype=markdown

    " Enable spellchecking for Markdown
    autocmd FileType markdown setlocal spell

    " Automatically wrap at 80 characters for Markdown
    autocmd BufRead,BufNewFile *.md setlocal textwidth=80

    " Automatically wrap at 72 characters and spell check git commit messages
    autocmd FileType gitcommit setlocal textwidth=72
    autocmd FileType gitcommit setlocal spell

    " Allow stylesheets to autocomplete hyphenated words
    autocmd FileType css,scss,sass,less setlocal iskeyword+=-

    " JVM filetypes
    au BufWinEnter,BufNewFile,BufRead *.gradle set filetype=groovy
    au BufWinEnter,BufNewFile,BufRead *.sbt set filetype=scala
    autocmd BufWritePost *.scala silent :EnTypeCheck

    " Configuration
    autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

    " Java
    autocmd FileType java setlocal omnifunc=javacomplete#Complete
augroup END


" --- Remapping ---
" leader cd to change to current file dir
map ,cd :cd %:p:h<CR>:pwd<CR>

" strip whitespace
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" reselect the text that was just pasted
nnoremap <leader>v V`]

" clear highlight with leader space
nnoremap <leader><space> :noh<cr>

" User tab for matching bracket
nnoremap <tab> %
vnoremap <tab> %

" --- Bundles config
noremap <F1> <CR>:NERDTreeToggle<CR>

" - jistr/vim-nerdtree-tabs
" Open/close NERDTree Tabs with \t
nmap <silent> <leader>t :NERDTreeTabsToggle<CR>
let g:nerdtree_tabs_open_on_console_startup = 0
let g:nerdtree_tabs_open_on_gui_startup = 0

" - airblade/vim-gitgutter settings
" Required after having changed the colorscheme
hi clear SignColumn

" - ctrlp settings
let g:ctrlp_map = '<F2>'
let g:ctrlp_use_caching = 1
let g:ctrlp_clear_cache_on_exit = 1
let g:ctrlp_cache_dir = '~/.vim/.cache/ctrlp'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(class|exe|so|dll|jar)$'
  \ }

" - maximizer
nnoremap <silent><F3> :MaximizerToggle<CR>
vnoremap <silent><F3> :MaximizerToggle<CR>gv
inoremap <silent><F3> <C-o>:MaximizerToggle<CR>

" Local config
if filereadable($HOME . "/.vimrc.local")
    source ~/.vimrc.local
endif
