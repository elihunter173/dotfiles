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

" Disable autocomments
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Leader mappings from the gods (https://www.reddit.com/r/vim/comments/9zy5xg/leader_mapping_from_the_gods/)
" semicolon is now map leader
let mapleader = ";"
" Jump to next match is now . (next to ,)
noremap . ;
" Repeat last command is now space, always easy to reach.
noremap <Space> .

" Easier quick macro recording (shift would be ideal but isn't working right now)
nnoremap <C-Space> @q

" Enable mouse support for all modes
set mouse=a

" Make saving and quitting easier and faster. (z to prevent conflict with macros)
nnoremap <leader>w :w<CR>
nnoremap <leader>W :w!<CR>
nnoremap <leader>z :q<CR>
nnoremap <leader>Z :q!<CR>
nnoremap <leader>c :bd<CR>

" s for substitute. This overwrites the default keys
nmap s <plug>(SubversiveSubstitute)
nmap ss <plug>(SubversiveSubstituteLine)
nmap S <plug>(SubversiveSubstituteToEndOfLine)

" Move a line of text using META+[jk]
nnoremap <M-j> :m+1<CR>
nnoremap <M-k> :m-2<CR>

" Make `Y` `y$` consistent with `D`, `C`, etc.
nnoremap Y y$

" Remap undo
nnoremap U <C-r>

" Disable highlighting (run :noh) when escape pressed twice in normal mode
nmap <Esc><Esc> :nohlsearch<CR>

" Tabularize settings
nnoremap <leader>t :Tabularize<Space>/
