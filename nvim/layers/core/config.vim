" Make <Tab> insert 4 spaces.
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab

" Use X clipboard.
set clipboard=unnamedplus

" A modified buffer simply becomes hidden when switched. Makes it possible to
" leave modified buffers.
set hidden

" Don't redraw during macros (for performance)
set lazyredraw

" Ignore case when only typing in lower case. When typing with some uppercase,
" don't ignore case
set ignorecase
set smartcase

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500
