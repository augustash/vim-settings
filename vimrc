" This must be first, because it changes other options as side effect
set nocompatible

" Use pathogen to easily modify the runtime path to include all
" plugins under the ~/.vim/bundle directory
filetype off
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()


" ----------------------------------------------------------------------------
" General
" ----------------------------------------------------------------------------

" Enable filetype checking and intelligent indenting
filetype plugin indent on

" Use UTF-8 as the default buffer encoding
set enc=utf-8

" Do not wrap lines
set nowrap

" Show line numbers
set number

" Allow backspacing over everything
set backspace=indent,eol,start

" Remember up to 1000 'colon' commmands and search patterns
set history=1000
set undolevel=1000

" Enable incremental search
set incsearch

" Do not highlight results of a search
set nohlsearch

" Ignore case when searching
set ignorecase

" Always show status line, even for one window
set laststatus=2

" When a bracket is inserted, briefly jump to a matching one
set showmatch

" Jump to matching bracket for 2/10th of a second (works with showmatch)
set matchtime=2

" Show line, column number, and relative position within a file in the status line
set ruler

" Scroll when cursor gets within 3 characters of top/bottom edge
set scrolloff=3

" Round indent to multiple of 'shiftwidth' for > and < commands
set shiftround

" Use 4 spaces for (auto)indent
set shiftwidth=4

" Use 4 spaces for <Tab> and :retab
set tabstop=4
set softtabstop=4

" Expand tabs to spaces
set expandtab

" Show (partial) commands (or size of selection in Visual mode) in the status line
set showcmd

" Use menu to show command-line completion (in 'full' case)
set wildmenu

" Set command-line completion mode:
"   - on first <Tab>, when more than one match, list all matches and complete
"     the longest common  string
"   - on second <Tab>, complete the next full match and show menu
set wildmode=list:longest,full

" Ignore certain types of files on completion
set wildignore+=*.o,*.obj,*.pyc,.git,*.bak

" Change the mapleader from \ to ,
let mapleader=","

" Hide buffers instead of closing
set hidden

" Show hidden characters
set list listchars=tab:>.,trail:.,extends:#,nbsp:.,eol:¬

" Indenting
set autoindent
set smartindent

" No beeps
set visualbell
set noerrorbells

" Do not write backup files
set nobackup
set noswapfile


" ----------------------------------------------------------------------------
" Colors
" ----------------------------------------------------------------------------
if &t_Co >= 256 || has("gui_running")
    colorscheme mustang
endif

if &t_Co > 2 || has("gui_running")
    " switch syntax highlighting on, when the terminal has colors
    syntax on
endif

highlight Comment       ctermfg=DarkGrey guifg=#444444
highlight StatusLineNC  ctermfg=Black ctermbg=DarkGrey cterm=bold
highlight StatusLine    ctermbg=Black ctermfg=LightGrey
highlight NonText       ctermfg=DarkGrey guifg=#444444
highlight SpecialKey    ctermfg=DarkGrey guifg=#444444


" ----------------------------------------------------------------------------
" Key Maps
" ----------------------------------------------------------------------------

" Remap ':' to ';' - Saves two strokes
nnoremap ; :

" Rapidly toggle 'set list'
nmap <leader>l :set list!<CR>

" Use Q for formatting the current paragraph (or selection)
vmap Q gq
nmap Q gqap

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" Changes up/down to move by line in editor
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" Easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Clear highlighted search
nmap <silent> <leader>/ :nohlsearch<CR>

" Forget sudo?
cmap w!! w !sudo tee % >/dev/null

" Key for paste mode
set pastetoggle=<F2>

" Replicate Text Mate's indent/outdent
nmap <D-[> <<
nmap <D-]> >>
vmap <D-[> <gv
vmap <D-]> >gv

" Use <F6> to toggle line numbers
nmap <silent> <F6> :set number!<CR>

" Page down with <Space>
nmap <Space> <PageDown>


" ----------------------------------------------------------------------------
" Auto commands/format
" ----------------------------------------------------------------------------
if has('autocmd')
    
    " Turn off tabs for XML/HTML
    autocmd Filetype html,xml set listchars-=tab:>.
    
    " Set file types
    autocmd BufRead,BufNewFile *.rpdf       set ft=ruby
    autocmd BufRead,BufNewFile *.rxls       set ft=ruby
    autocmd BufRead,BufNewFile *.ru         set ft=ruby
    autocmd BufRead,BufNewFile *.god        set ft=ruby
    autocmd BufRead,BufNewFile *.rtxt       set ft=html spell
    autocmd BufRead,BufNewFile *.sql        set ft=pgsql
    autocmd BufRead,BufNewFile *.haml       set ft=haml
    autocmd BufRead,BufNewFile *.md         set ft=mkd tw=80 ts=4 sts=4 sw=4 expandtab
    autocmd BufRead,BufNewFile *.markdown   set ft=mkd tw=80 ts=4 sts=4 sw=4 expandtab
    autocmd BufRead,BufNewFile *.mdown      set ft=mkd tw=80 ts=4 sts=4 sw=4 expandtab
    autocmd BufRead,BufNewFile *.ronn       set ft=mkd tw=80 ts=4 sts=4 sw=4 expandtab
    autocmd BufNewFile,BufRead *.rss,*.atom set ft=xml

    " Set spacing syntax
    autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
    autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
    autocmd Filetype gitcommit setlocal tw=68 spell
    autocmd Filetype ruby setlocal tw=80 ts=2 sts=2 sw=2 expandtab
    autocmd Filetype sh,bash setlocal ts=4 sts=4 sw=4 expandtab
    autocmd FileType php setlocal ts=4 sts=4 sw=4 expandtab
    autocmd FileType html setlocal ts=4 sts=4 sw=4 expandtab
    autocmd FileType css setlocal ts=4 sts=4 sw=4 expandtab
    autocmd FileType javascript setlocal ts=4 sts=4 sw=4 expandtab

    " Strip trailing white space on specific files
    autocmd BufWritePre *.php,*.phtml,*.rb,*.htm,*.html,*.css,*.py,*.js :call <SID>StripWhitespace()
    
    " Go back to the position the cursor was on the last time this file was edited
    autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")|execute("normal `\"")|endif

    "
    " PHP-specific Highlighting
    "
    
    " Highlight interpolated variables in SQL strings & SQL-syntax highlighting
    autocmd FileType php let php_sql_query=1
    
    " Highlight HTML inside of PHP strings
    autocmd FileType php let php_htmlInStrings=1
    
    " Discourages use of short tags.
    autocmd FileType php let php_noShortTags=1
    
    " Highlight brackets and parentheses
    autocmd FileType php DoMatchParen
    autocmd FileType php hi MatchParen ctermbg=blue guibg=lightblue

endif

" ----------------------------------------------------------------------------
" Functions
" ----------------------------------------------------------------------------

" Switch between tabs (:T) & spaces (:S)
function Spaces(...)
    if a:0 == 1
        let l:width = a:1
    else
        let l:width = 4
    endif
    setlocal expandtab
    let &l:shiftwidth = l:width
    let &l:softtabstop = l:width
endfunction
command! T setlocal noexpandtab shiftwidth=4 softtabstop=0
command! -nargs=? S call Spaces(<args>)</args>

" Strip off trailing whitespace
function! StripWhitespace ()
    exec ':%s/ \+$//gc'
endfunction
map <leader>s :call StripWhitespace ()<CR>