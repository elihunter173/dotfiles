" unmap needless keys
map s <Nop>
map S <Nop>

" Leader mappings from the gods (https://www.reddit.com/r/vim/comments/9zy5xg/leader_mapping_from_the_gods/)
" semicolon is now map leader
let mapleader = ";"
" jump to next match is now . (next to ,)
noremap . ;
" repeat last command is now space, always easy to reach
noremap <Space> .

" make command mode a single key and avoid shift typos
nnoremap <CR> :

" make `Y` `y$` consistent with `D`, `C`, etc.
nnoremap Y y$

" make easier return to last buffer keystroke
noremap <C-r> <C-^>
" remap undo
noremap U <C-r>

" easier window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" disable highlighting (run :noh) when escape pressed twice in normal mode
nmap <Esc><Esc> :noh<CR>
