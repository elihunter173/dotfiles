"
"

" Make <Tab> insert 4 spaces.
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab

" Use X clipboard.
set clipboard=unnamedplus

" Enable spell checking by default
set spell spelllang=en_us

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Leader mappings from the gods (https://www.reddit.com/r/vim/comments/9zy5xg/leader_mapping_from_the_gods/)
" semicolon is now map leader
let mapleader = ";"
" Jump to next match is now . (next to ,)
noremap . ;
" Repeat last command is now space, always easy to reach.
noremap <Space> .

" Unmap useless keys
nmap s <Nop>

" Make S simply delete the current line
nnoremap S 0d$

" Make saving and quitting easier and faster.
" I execute :wq as :w and :q separately so that all post-write autocommands
" execute properly.
nnoremap <leader>w :w<CR>
nnoremap <leader>W :w!<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>Q :q!<CR>
nnoremap <leader>z :w<CR>:q<CR>
nnoremap <leader>Z :w!<CR>q!<CR>

" Move a line of text using META+[jk]
nnoremap <M-j> :m+1<CR>
nnoremap <M-k> :m-2<CR>

" Make `Y` `y$` consistent with `D`, `C`, etc.
nnoremap Y y$

" Remap undo
nnoremap U <C-r>

" Disable highlighting (run :noh) when escape pressed twice in normal mode
nmap <Esc><Esc> :noh<CR>
