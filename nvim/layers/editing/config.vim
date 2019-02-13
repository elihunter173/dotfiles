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

" Use indent based folding (it works well enough and doesn't lag)
set foldmethod=indent
" Unfold everything when entering a file
autocmd BufRead * normal zR

" Make saving and quitting easier and faster. (z to prevent conflict with macros)
nnoremap <leader>w :w<CR>
nnoremap <leader>W :w!<CR>
nnoremap <leader>z :q<CR>
nnoremap <leader>Z :q!<CR>
nnoremap <leader>c :bd<CR>

" Easier quick macro use (shift would be ideal but isn't working right now)
nnoremap <C-Space> @q
" Easier quick command repeating
nnoremap <M-Space> @:

" Remap undo
nnoremap U <C-r>

" Toggle spell checking with F1
map <F12> :setlocal spell! spelllang=en_us<CR>

" Make `Y` `y$` consistent with `D`, `C`, etc.
nnoremap Y y$

" Make 0 reference first non-whitespace character instead of first character
" Make _ reference first character instead of first non-whitespace character
nnoremap 0 _
nnoremap _ 0

" Disable highlighting (run :noh) when escape pressed twice in normal mode
nmap <Esc><Esc> :nohlsearch<CR>

" s for substitute. This overwrites the default keys
" Only capital S is used to prevent conflict with vim-sandwich
nmap S <plug>(SubversiveSubstitute)
nmap SS <plug>(SubversiveSubstituteLine)
" nmap S <plug>(SubversiveSubstituteToEndOfLine)

" Custom vim-sandwich recipes
let g:sandwich#recipes = deepcopy(g:sandwich#default_recipes)

" Goyo settings
function! s:goyo_enter()
  set noshowmode
  set noshowcmd
  " Go into typewriter mode
  set scrolloff=999
endfunction

function! s:goyo_leave()
  set showmode
  set showcmd
  " Default scrolloff
  set scrolloff=4
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

nnoremap <F3> :Goyo<CR>

" Default: 80
let g:goyo_width = 100
" Default: 85%
" let g:goyo_height = 85%
" Default: 0
" let g:goyo_linenr = 0
