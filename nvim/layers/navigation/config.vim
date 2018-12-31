" A modified buffer simply becomes hidden when switched. Makes it possible to
" leave modified buffers.
set hidden

" Simplify the return the last buffer keystroke
" N.B. <C-r> must be reassigned as well or else this doesn't work as intended
noremap <C-r> <C-^>

" Easier window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Easier swapping between buffers and files
nmap <leader>s :buffer<Space>
nmap <leader>o :edit<Space>
