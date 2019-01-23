" Make <Tab> insert 4 spaces.
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab

" Disable autocomments for all things
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Use X clipboard.
set clipboard=unnamedplus

" Enable mouse support for all modes
set mouse=a

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Make saving and quitting easier and faster. (z to prevent conflict with macros)
nnoremap <leader>w :w<CR>
nnoremap <leader>W :w!<CR>
nnoremap <leader>z :q<CR>
nnoremap <leader>Z :q!<CR>
nnoremap <leader>c :bd<CR>

" Easier quick macro recording (shift would be ideal but isn't working right now)
nnoremap <C-Space> @q

" Remap undo
nnoremap U <C-r>

" Move a line of text using META+[jk]
nnoremap <M-j> :m+1<CR>
nnoremap <M-k> :m-2<CR>

" Toggle spell checking with F1
map <F12> :setlocal spell! spelllang=en_us<CR>

" Make `Y` `y$` consistent with `D`, `C`, etc.
nnoremap Y y$

" Disable highlighting (run :noh) when escape pressed twice in normal mode
nmap <Esc><Esc> :nohlsearch<CR>

" s for substitute. This overwrites the default keys
" Only capital S is used to prevent conflict with vim-sandwich
nmap S <plug>(SubversiveSubstitute)
nmap SS <plug>(SubversiveSubstituteLine)
" nmap S <plug>(SubversiveSubstituteToEndOfLine)

" Custom vim-sandwich recipes
let g:sandwich#recipes = deepcopy(g:sandwich#default_recipes)
