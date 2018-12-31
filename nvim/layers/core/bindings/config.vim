" Unmap useless keys
nmap s <Nop>

" *Make* S simply delete the current line
nmap S <Nop>
nnoremap S 0d$

" Leader mappings from the gods (https://www.reddit.com/r/vim/comments/9zy5xg/leader_mapping_from_the_gods/)
" semicolon is now map leader
let mapleader = ";"
" Jump to next match is now . (next to ,)
noremap . ;
" Repeat last command is now space, always easy to reach.
noremap <Space> .

" Make saving and quitting easier and faster.
" I execute :wq as :w and :q separately so that all post-write autocommands
" execute properly.
noremap <leader>w :w<CR>
noremap <leader>W :w!<CR>
noremap <leader>q :q<CR>
noremap <leader>Q :q!<CR>
noremap <leader>z :w<CR>:q<CR>
noremap <leader>Z :w!<CR>q!<CR>

" Move a line of text using META+[jk]
nnoremap <M-j> :m+1<CR>
nnoremap <M-k> :m-2<CR>

" make `Y` `y$` consistent with `D`, `C`, etc.
nnoremap Y y$

" remap undo
noremap U <C-r>

" disable highlighting (run :noh) when escape pressed twice in normal mode
nmap <Esc><Esc> :noh<CR>
