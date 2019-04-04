" vim: filetype=vim foldmethod=marker foldlevel=0
" A Vim agnostic vimrc. This works with both Vim and Neovim.
"
" Author: Eli W. Hunter

" vim-plug setup {{{1
if has('nvim')
    let s:vim_plug_path = '~/.local/share/nvim/site/autoload/plug.vim'
    let s:plugins_path = '~/.local/share/nvim/plugged'
else
    let s:vim_plug_path = '~/.vim/autoload/plug.vim'
    let s:plugins_path = '~/.vim/plugged'
endif

if empty(glob(s:vim_plug_path))
    silent !curl -fLo s:vim_plug_path --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | qa
endif

" Install Plugins {{{1
call plug#begin(s:plugins_path)
" Editing
" Additional text objects
Plug 'wellle/targets.vim'
" Surrounding text objects with any character
Plug 'machakann/vim-sandwich'
" Syntax highlighting for almost every language
Plug 'sheerun/vim-polyglot'
" Lightweight git wrapper
Plug 'tpope/vim-fugitive'
" Automatically detect indentation
Plug 'tpope/vim-sleuth'
" Easier commenting for any language
Plug 'tpope/vim-commentary'
" Auto-closing for brackets, parens, and quotes
Plug 'jiangmiao/auto-pairs'
" C Tag management
Plug 'ludovicchabant/vim-gutentags'
" Easy text alignment
Plug 'godlygeek/tabular'

" Nice lightweight statusline
Plug 'itchyny/lightline.vim'

" Advanced language features
" Linting
Plug 'w0rp/ale'

" Visualization tools
" Netrw enhancements
Plug 'tpope/vim-vinegar'
" C Tags tagbar
Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }
" Vim undotree visualizer
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }

" Display
" Base16 colorschemes
Plug 'chriskempson/base16-vim'

" Markdown
Plug 'masukomi/vim-markdown-folding'

" Neovim Specific Plugins {{{
if has('nvim')
    " Autocomplete
    Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}
endif
" }}}
call plug#end()

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

" Default to no folds
set foldlevel=999

" Add some custom extensions
autocmd BufNewFile,BufRead *.nvim set filetype=vim

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
if exists('+termguicolors')
    set termguicolors
endif

" Set base16 background
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif
" Swap default statusline focus and no-focus colors
call Base16hi("StatusLine", g:base16_gui05, g:base16_gui01, g:base16_cterm05, g:base16_cterm01)
call Base16hi("StatusLineNC", g:base16_gui05, g:base16_gui02, g:base16_cterm05, g:base16_cterm02)

" Keybindings {{{1
let mapleader = " "

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


" Plugin Settings {{{1

" Gutentags
" Hide gutentags tag files in this cache to prevent polluting tagspace
let g:gutentags_cache_dir = '~/.cache/vim-gutentags'

" Vim Sandwich
" Custom vim-sandwich recipes
let g:sandwich#recipes = deepcopy(g:sandwich#default_recipes)

" Vim Markdown
autocmd FileType markdown set foldexpr=NestedMarkdownFolds()

" ALE
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

" Lightline
" Don't show mode in command line
set noshowmode

let g:lightline = {
      \ 'colorscheme': 'solarized',
      \ }

" Vim Specific Settings {{{1
if !has('nvim')
    " Make vim's cursor change shape in different modes (VTE)
    " (https://vim.fandom.com/wiki/Change_cursor_shape_in_different_modes)
    let &t_SI = "\<Esc>[6 q"
    let &t_SR = "\<Esc>[4 q"
    let &t_EI = "\<Esc>[2 q"
endif

" Neovim Specific Settings {{{1
if has('nvim')
  " Coc.nvim setup
  nmap <silent> gd <Plug>(coc-definition)

  " Remap for rename current word
  nmap <leader>r <Plug>(coc-rename)

  " Use K for show documentation in preview window
  nnoremap <silent> K :call <SID>show_documentation()<CR>
  function! s:show_documentation()
    if &filetype == 'vim'
      execute 'h '.expand('<cword>')
    else
      call CocAction('doHover')
    endif
  endfunction

  " Highlight symbol under cursor on CursorHold
  autocmd CursorHold * silent call CocActionAsync('highlight')
endif
