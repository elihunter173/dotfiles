" Ignore case when only typing in lower case. When typing with some uppercase,
" don't ignore case
set ignorecase
set smartcase

" When in command mode, tab completion first fills the longest match and shows
" the wildmenu. After the first one, it cycles through all possible matches.
set wildmenu
set wildmode=longest:full,full

" Required for operations modifying multiple buffers like rename.
set hidden

" Enable deoplete when InsertEnter.
let g:deoplete#enable_at_startup = 0
autocmd InsertEnter * call deoplete#enable()

" decrease amount of time for deoplete to activate
let g:deoplete#auto_complete_delay = 5  " Default is 20
let g:deoplete#auto_refresh_delay = 20  " Default is 50
