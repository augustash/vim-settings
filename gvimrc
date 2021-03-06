" Graphical Vim config

set encoding=utf-8
set guioptions-=T           " hide the toolbar
set guioptions-=r           " hide the scrollbars
set guioptions-=R           " hide the scrollbars with vertical split
set guioptions-=l           " hide the scrollbars
set guioptions-=L           " hide the scrollbars with vertical split
set guifont=Inconsolata:h15
set lines=40 columns=85     " window dimensions
set number                  " line numbers

colorscheme solarized

set colorcolumn=81

" Map keys for auto-sizing windows
nmap <leader>1 :set columns=85<CR><C-w>o
nmap <leader>2 <C-w>o:set columns=171<CR><C-w>v
nmap <leader>3 <C-w>o:set columns=117<CR><leader>d<C-l>

function! TallWindow()
    set lines=58
endfunction
command! Tw :call TallWindow()
command! TallWindow :call TallWindow()
