" vim: filetype=vim foldmethod=marker foldlevel=0
" A Vim agnostic vimrc. This works with both Vim and Neovim.
"
" Author: Eli W. Hunter
"

" vim-plug setup {{{
if has('nvim')
    let s:vim_plug_path = '~/.local/share/nvim/site/autoload/plug.vim'
    let s:plugins_path = '~/.local/share/nvim/plugged'
else
    let s:vim_plug_path = '~/.vim/autoload/plug.vim'
    let s:plugins_path = '~/.vim/plugged'
endif
let s:vim_plug_url = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

if empty(glob(s:vim_plug_path))
    silent execute '!curl -fLo '.s:vim_plug_path.' --create-dirs '.s:vim_plug_url
    autocmd VimEnter * PlugInstall --sync | qa
endif
" }}}

" Install Plugins {{{
call plug#begin(s:plugins_path)
" Editing
" Additional text objects
Plug 'wellle/targets.vim'
" PascalCase, snake_case, etc. words (How things should be)
Plug 'chaoren/vim-wordmotion'
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
" Fuzzy Finding
Plug 'junegunn/fzf.vim'

" Nice lightweight statusline
Plug 'itchyny/lightline.vim'
" Nice start screen for GUIs
Plug 'mhinz/vim-startify'

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

" Linting
Plug 'w0rp/ale'

" Neovim Specific Plugins
if has('nvim')
    " Autocomplete
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
endif

call plug#end()
"""}}}

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

" I create tabs a lot more than I use gn and gN
nnoremap gn :tabnew<CR>
nnoremap gN :tabclose<CR>

if exists('&inccommand')
    set inccommand=nosplit
endif

" Add some custom extensions
autocmd BufNewFile,BufRead *.nvim set filetype=vim

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
let base16colorspace=256
colorscheme base16-solarized-dark
" Swap default statusline focus and no-focus colors
" call Base16hi("StatusLine", g:base16_gui05, g:base16_gui01, g:base16_cterm05, g:base16_cterm01)
" call Base16hi("StatusLineNC", g:base16_gui05, g:base16_gui02, g:base16_cterm05, g:base16_cterm02)

" GUI Font settings
set guifont=Hack:h11

" Keybindings
let mapleader = " "

" Make save work as you'd expect
nnoremap <silent> <C-s> :w<CR>
inoremap <silent> <C-s> :w<CR>
" Make paste in work as expected
inoremap <C-v> <ESC>pli
" Make copy in visual mode work as expected
vnoremap <C-c> y

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

" Make saving and quitting easier and faster.
nnoremap <silent> <leader>w :write<CR>
nnoremap <silent> <leader>s :mksession<CR>
nnoremap <silent> <leader>c :close<CR>

" Buffer navigation
nnoremap <silent> <Tab> :bnext<CR>
nnoremap <silent> <S-Tab> :bprevious<CR>
nnoremap <leader><leader> <C-^>

" Remap undo
nnoremap U <C-r>
nnoremap <C-r> <NOP>

" Easier window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
" Easier tab navigation
nnoremap <M-h> gT
nnoremap <M-l> gt

" Clear the search really easily
nnoremap <silent> <ESC><ESC> :let @/ = ""<CR>

" Easier swapping between files
nnoremap <silent> <leader>o :edit<Space>

" Easier interactive git (fugitive)
nnoremap <silent> <leader>g :Gstatus<CR>

" Toggle spell checking with F1
nnoremap <silent> <F12> :setlocal spell! spelllang=en_us<CR>

" Easy tagbar activation and toggling
nnoremap <silent> <F1> :TagbarToggle<CR>
" A nice keybinding to toggle the undotree
nnoremap <silent> <F2> :UndotreeToggle<CR>

" FZF Hotkeys
nnoremap <silent> <leader>l :BLines<CR>
" f for find
nnoremap <silent> <leader>f :BTags<CR>
nnoremap <silent> <leader>F :Tags<CR>

if exists(':terminal')
    "Easier escape
    tnoremap <ESC><ESC> <C-\><C-n>

    " Easier terminal opening
    nnoremap <silent> <leader>t :terminal<CR>

    " Easier window navigation
    tnoremap <C-h> <C-\><C-n><C-w>h
    tnoremap <C-j> <C-\><C-n><C-w>j
    tnoremap <C-k> <C-\><C-n><C-w>k
    tnoremap <C-l> <C-\><C-n><C-w>l
    " Easier tab navigation
    tnoremap <M-h> <C-\><C-n>gT
    tnoremap <M-l> <C-\><C-n>gt
endif

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

" Version Specific Settings {{{1
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
