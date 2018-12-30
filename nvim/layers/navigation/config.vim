" Simplify the return the last buffer keystroke
" N.B. <C-r> must be reassigned as well or else this doesn't work as intended
noremap <C-r> <C-^>

" Easier window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l


" Tab is included to bring up the wildmenu
nmap <leader>s :buffer<Space>
nmap <leader>o :edit<Space>
