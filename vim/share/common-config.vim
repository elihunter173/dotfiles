" vim: foldmethod=marker foldlevel=0
" Basic Settings {{{1
" No vi compatibility
set nocompatible

" Enable ftplugins for everything
filetype plugin indent on

" No annoying sound or blink on errors
set noerrorbells
set novisualbell

" Enable mouse support for all modes
set mouse=a

" Disable autocomments for all things
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Ignore case only when typing in purely lower case
set ignorecase
set smartcase

" When in command mode, tab completion first fills the longest match and shows
" the wildmenu. After the first one, it cycles through all possible matches.
set wildmenu
set wildmode=longest:full,full

" Allows switching unsaved buffers (instead of abandoning them, hide them)
set hidden

" Use X clipboard.
set clipboard=unnamedplus

" Don't redraw during macros (for performance)
set lazyredraw

" Set to indent folding with default of no folds
set foldmethod=indent
set foldlevel=999

" Display {{{1
" Show hidden characters
set listchars=tab:>-,trail:~,extends:>,precedes:<
set list

" Enable line numbers and ruler
set number relativenumber
set ruler

" number of lines to pad cursor by when scrolling
set scrolloff=4

" Allow GUI style colors in terminal if supported
" if exists('+termguicolors')
"     set termguicolors
" endif

" Set base16 background
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif
" Swap default statusline focus and no-focus colors
call Base16hi("StatusLine", g:base16_gui05, g:base16_gui01, g:base16_cterm05, g:base16_cterm01)
call Base16hi("StatusLineNC", g:base16_gui05, g:base16_gui02, g:base16_cterm05, g:base16_cterm02)

" Keybindings {{{1
" Leader mappings from the gods (https://www.reddit.com/r/vim/comments/9zy5xg/leader_mapping_from_the_gods/)
" semicolon is now map leader
let mapleader = ";"
" Jump to next match is now . (next to ,)
noremap . ;
" Repeat last command is now space, always easy to reach.
noremap <Space> .

" Remove useless keybindings
nnoremap s <NOP>
nnoremap S <NOP>

" Swap 0 and _ since _ is more useful and 0 is easier to reach
nnoremap 0 _
nnoremap _ 0

" Make `Y` `y$` consistent with `D`, `C`, etc.
nnoremap Y y$

" Make 'c' go to the black hole register
nnoremap c "_c
nnoremap C "_C

" Make saving and quitting easier and faster. (z to prevent conflict with macros)
nnoremap <leader>w :w<CR>
nnoremap <leader>W :w!<CR>
nnoremap <leader>z :q<CR>
nnoremap <leader>Z :q!<CR>
nnoremap <leader>c :bd<CR>

" Easier quick macro use (shift would be ideal but isn't working right now)
nnoremap <C-Space> @@
" Easier quick command repeating
nnoremap <M-Space> @:

" Remap undo
nnoremap U <C-r>
nnoremap <C-r> <NOP>

" Easier window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Turn off search highlighting easily
nnoremap <ESC><ESC> :nohlsearch<CR>

" Easier swapping between files
nnoremap <leader>o :edit<Space>
" Easier tag jumping
nnoremap <leader>t :tag<Space>

" Easier interactive git (fugitive)
nnoremap <leader>g :G<CR>

" Toggle spell checking with F1
nnoremap <F12> :setlocal spell! spelllang=en_us<CR>

" Easy tagbar activation and toggling
nnoremap <F1> :TagbarToggle<CR>
" A nice keybinding to toggle the undotree
nnoremap <F2> :UndotreeToggle<CR>

" Custom Extensions {{{1
autocmd BufNewFile,BufRead *.nvim set filetype=vim

" Plugin Settings {{{1

" Gutentags {{{2
" Hide gutentags tag files in this cache to prevent polluting tagspace
let g:gutentags_cache_dir = '~/.cache/vim-gutentags'

" Vim Sandwich {{{2
" Custom vim-sandwich recipes
let g:sandwich#recipes = deepcopy(g:sandwich#default_recipes)

" Vim Markdown {{{2
" Make Markdown indent by 2 by default
let g:vim_markdown_new_list_item_indent = 2

" Disable markdown concealing because it's laggy
let g:vim_markdown_conceal = 0

" Disable folding in markdown completely
let g:vim_markdown_folding_disabled = 1

" Enable LaTeX syntax highlighting
let g:vim_markdown_math = 1
" Enable YAML Frontmatter syntax highlighting
let g:vim_markdown_frontmatter = 1

" ALE {{{2
" Polybar config uses ini format, and I set up polybar with .bar extension
" Define global fixers
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\}
" I have simple ale fixers, so I'm okay with this.
let g:ale_fix_on_save = 1

" Always have the side column open (prevents annoying shifts)
let g:ale_sign_column_always = 1

let g:ale_sign_error = '!!'
let g:ale_sign_warning = '--'
