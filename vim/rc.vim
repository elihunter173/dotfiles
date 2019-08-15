" vim: filetype=vim foldmethod=marker foldlevel=0
" A Vim agnostic vimrc. This works with both Vim and Neovim
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
" Surrounding text objects with any character
Plug 'machakann/vim-sandwich'
" Easier word motion
Plug 'chaoren/vim-wordmotion'
" The missing motion
Plug 'justinmk/vim-sneak'
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
" Fuzzy Finding
Plug 'junegunn/fzf.vim'
" https://EditorConfig.org
Plug 'editorconfig/editorconfig-vim'
" Netrw enhancements
Plug 'tpope/vim-vinegar'

" Language Definition
Plug 'elihunter173/vim-rpl'
" Plug '~/src/research/vim-rpl'

" Visualizers
" Nice lightweight statusline
Plug 'itchyny/lightline.vim'
" Nice start screen for GUIs
Plug 'mhinz/vim-startify'

" C Tags tagbar
Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }
" Vim undotree visualizer
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }

" Display
" Base16 colorschemes
Plug 'chriskempson/base16-vim'

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

" Why would you ever put 2 spaces after punctuation??
set nojoinspaces

" Ignore case only when typing in purely lower case
set ignorecase
set smartcase

" Allows switching unsaved buffers (instead of abandoning them, hide them)
set hidden

" Use X clipboard by default
set clipboard=unnamedplus

" Don't redraw during macros (for performance)
set lazyredraw

" Default to no folds
set foldlevel=999

if exists('&inccommand')
    set inccommand=nosplit
endif

" Trim Whitespace
function! s:StripTrailingWhitespace()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    %s/\n\+\%$//e
    call cursor(l, c)
endfunction
autocmd BufWritePre * call s:StripTrailingWhitespace()

" number of lines to pad cursor by when scrolling
set scrolloff=2

" Show hidden characters
set listchars=tab:>-,trail:~,extends:>,precedes:<
set list

" Enable line numbers and ruler
set number relativenumber
set ruler

" Allow GUI style colors in terminal if supported
if exists('+termguicolors')
    set termguicolors
endif

" Set base16 background
let base16colorspace=256
colorscheme base16-solarized-dark

" GUI Font settings
set guifont=Hack:h12

" Keybindings

" Easy leader
let mapleader = " "

" Make save work as you'd expect
nnoremap <silent> <C-s> :w<CR>
inoremap <silent> <C-s> <ESC>:w<CR>a
" Make paste in work as expected
inoremap <C-v> <ESC>pa
" Make copy in visual mode work as expected
vnoremap <C-c> y

" Make `Y` `y$` consistent with `D`, `C`, etc
nnoremap Y y$

" Remove useless keybindings
nnoremap s <NOP>
nnoremap S <NOP>

" Swap 0 and _ since _ is more useful and 0 is easier to reach
nnoremap 0 _
nnoremap _ 0

" Make 'c' go to the black hole register
nnoremap c "_c
nnoremap C "_C
vnoremap c "_c
vnoremap C "_C

" I create tabs a lot more than I use gn and gN
nnoremap <leader>t :tabnew<CR>
nnoremap <leader>T :tabclose<CR>

" Sneaky motions 🤫
map <leader>f <Plug>Sneak_s
map <leader>F <Plug>Sneak_S

" Make saving and quitting easier and faster
nnoremap <silent> <leader>w :write<CR>
nnoremap <silent> <leader>c :bdelete!<CR>
command Bye execute ":mksession! | quitall!"

" Remap undo to make more sense
nnoremap U <C-r>
nnoremap <C-r> <NOP>

" Turn off search highlighting because vim doesn't do that by default for some reason
nnoremap <silent> <ESC><ESC> :nohlsearch<CR>

" Easier interactive git (fugitive)
nnoremap <silent> <leader>g :Gstatus<CR>

" Toggle spell checking with F1
nnoremap <silent> <F12> :setlocal spell! spelllang=en_us<CR>

" Easy tagbar activation and toggling
nnoremap <silent> <F1> :TagbarToggle<CR>
" A nice keybinding to toggle the undotree
nnoremap <silent> <F2> :UndotreeToggle<CR>

" Easier window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
" Easier tab navigation
nnoremap <M-h> gT
nnoremap <M-l> gt

if exists(':terminal')
    " Easier terminal opening
    nnoremap <silent> <leader>s :terminal<CR>

    " Easier escape
    tnoremap <ESC><ESC> <C-\><C-n>

    " Make paste in work as expected
    tnoremap <C-v> <C-\><C-n>pi

    " Easier window navigation
    tnoremap <C-h> <C-\><C-n><C-w>h
    tnoremap <C-j> <C-\><C-n><C-w>j
    tnoremap <C-k> <C-\><C-n><C-w>k
    tnoremap <C-l> <C-\><C-n><C-w>l
    " Easier tab navigation
    tnoremap <M-h> <C-\><C-n>gT
    tnoremap <M-l> <C-\><C-n>gt

    " No linenumbers in terminals
    autocmd TermOpen * setlocal norelativenumber nonumber
endif

" Plugin Settings

" EditorConfig + Fugitive
let g:EditorConfig_exclude_patterns = ['fugitive://.\*']

" Lightline
set noshowmode " Don't show mode redundantly
let g:lightline = {
            \ 'colorscheme': 'solarized',
            \ }

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
