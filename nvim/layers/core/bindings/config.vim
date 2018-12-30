" Unmap useless keys
map s <Nop>
map S <Nop>

" Leader mappings from the gods (https://www.reddit.com/r/vim/comments/9zy5xg/leader_mapping_from_the_gods/)
" semicolon is now map leader
let mapleader = ";"
" jump to next match is now . (next to ,)
noremap . ;
" repeat last command is now space, always easy to reach
noremap <Space> .

" make saving and quitting easier and faster
noremap <leader>w :w<CR>
noremap <leader>q :q<CR>

" Move a line of text using META+[jk]
nmap <M-j> :m+1<CR>
nmap <M-k> :m-2<CR>

" make `Y` `y$` consistent with `D`, `C`, etc.
nnoremap Y y$

" remap undo
noremap U <C-r>

" disable highlighting (run :noh) when escape pressed twice in normal mode
nmap <Esc><Esc> :noh<CR>
