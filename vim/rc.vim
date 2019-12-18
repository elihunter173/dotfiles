" vim: filetype=vim
" A Vim agnostic vimrc. This works with both Vim and Neovim.
"
" Author: Eli W. Hunter

let g:did_install_default_menus = 1

" Easy leader
let mapleader = " "

" Set up or install minpac
packadd minpac
if !exists('*minpac#init')
  let s:config_path = has('nvim') ? stdpath('config') : '~/.vim'
  execute '!git clone https://github.com/k-takata/minpac.git '.s:config_path.'/pack/minpac/opt/minpac'
  " Load for real this time
  packadd minpac
  autocmd VimEnter * silent call minpac#update('', { 'do': 'quit' })
endif
call minpac#init()
" minpac must have {'type': 'opt'} so that it can be loaded with `packadd`.
call minpac#add('k-takata/minpac', {'type': 'opt'})

" Additional text objects
call minpac#add('wellle/targets.vim')
" Surrounding text objects with any character
call minpac#add('machakann/vim-sandwich')
" Auto-closing for brackets, parens, and quotes
call minpac#add('jiangmiao/auto-pairs')

" https://EditorConfig.org
call minpac#add('editorconfig/editorconfig-vim')

" Easier commenting for any language
call minpac#add('tpope/vim-commentary')

" A bunch of nice matching
call minpac#add('tpope/vim-unimpaired')

" Lightweight git wrapper
call minpac#add('tpope/vim-fugitive')
" Interactive (fug)git(ive)
nnoremap <silent> <leader>g :G<CR>

" Nice session management
call minpac#add('tpope/vim-obsession')
" I don't need things to always save (https://github.com/tpope/vim-obsession/issues/40)
let g:obsession_no_bufenter = 1

" EditorConfig + Fugitive
let g:EditorConfig_exclude_patterns = ['fugitive://.\*']

" Syntax highlighting for more languages
call minpac#add('sheerun/vim-polyglot')
" I take notes in markdown and vim-polyglot's markdown gets laggy for 1000+
" line files. The default one is worse but at least it's not slow.
let g:polyglot_disabled = ['markdown']
" call minpac#add('elihunter173/vim-rpl')

if executable('rg')
  set grepprg=rg\ --vimgrep
end

" Fuzzy Finding
call minpac#add('junegunn/fzf', { 'do': './install --all' })
call minpac#add('junegunn/fzf.vim')
" Don't open unnecessary files
let g:fzf_buffers_jump = 1
" Don't pollute the global namespace
let g:fzf_command_prefix = 'Fzf'
" Nice keybindings
nnoremap <leader>o :FzfFiles<CR>
nnoremap <leader>f :FzfBLines<CR>
nnoremap <leader>F :FzfRg<CR>

" Never think about indentation
call minpac#add('tpope/vim-sleuth')

" Swap things with ease
call minpac#add('tommcdo/vim-exchange')
" Easier unix commands
call minpac#add('tpope/vim-eunuch')

" Netrw but simpler and better
call minpac#add('justinmk/vim-dirvish')
" Disable netrw
let g:loaded_netrwPlugin = 1
command! -nargs=? -complete=dir Explore Dirvish <args>
command! -nargs=? -complete=dir Sexplore belowright split | silent Dirvish <args>
command! -nargs=? -complete=dir Vexplore leftabove vsplit | silent Dirvish <args>

" Session management good
" call minpac#add('tpope/vim-obsession')

" Word motion through CamelCase and friends
call minpac#add('chaoren/vim-wordmotion')
let g:wordmotion_prefix = '['

" Language Server Protocol
call minpac#add('neoclide/coc.nvim', {'branch': 'release'})
nmap gd <Plug>(coc-definition)
nmap <leader>r <Plug>(coc-rename)
nmap <F2> <Plug>(coc-rename)
nmap <F3> :CocDisable<CR>
command! -nargs=0 Format :call CocAction('format')
" Use K for show documentation in preview window
" It's annoying if this fails because we don't have yarn
nnoremap <silent> K :silent! call CocAction('doHover')<CR>
" Highlight all instances using S because idk
nnoremap <silent> S :silent! call CocActionAsync('highlight')<CR>

" Common LSPs
" call minpac#add('neovim/nvim-lsp')

" Base16 colorscheme
call minpac#add('chriskempson/base16-vim')
let base16colorspace=256
silent! colorscheme base16-solarized-dark
if has('termguicolors')
  set termguicolors
endif

" GUI Font settings
set guifont=Hack:h12

" Eye Candy
" Nice lightweight statusline
call minpac#add('itchyny/lightline.vim')
" Don't show mode redundantly
set noshowmode
let g:lightline = {
      \ 'colorscheme': 'solarized',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'filename', 'modified' ],
      \             [  ] ],
      \   'right': [ [  ],
      \              [ 'filetype' ],
      \              [ 'gitbranch' ] ],
      \ },
      \ 'inactive': {
      \   'left': [ [  ],
      \             [ 'filename' ],
      \             [  ] ],
      \   'right': [ [  ],
      \              [  ],
      \              [  ] ],
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
      \ }

" Vim undotree visualizer
call minpac#add('mbbill/undotree')
nmap <F5> :UndotreeToggle<CR>

" Enable ftplugins for everything
filetype plugin indent on

" Be easy on casing
set ignorecase
set smartcase

" No annoying sound or blink on errors
set noerrorbells
set novisualbell

" Enable mouse support for all modes
set mouse=a

" Disable autocomments for all things
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Why would you ever put 2 spaces after punctuation??
set nojoinspaces

" Use X clipboard by default
set clipboard=unnamedplus

" Don't redraw during macros (for performance)
set lazyredraw

if exists('&inccommand')
  set inccommand=nosplit
endif

" Pad cursor when scrolling
set scrolloff=1
set sidescrolloff=5

" Show hidden characters
set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
set list

" Enable line numbers and ruler
set number relativenumber
set ruler

" Make save work as you'd expect
nnoremap <silent> <C-s> :w<CR>
inoremap <silent> <C-s> <ESC>:w<CR>a
" Make paste in work as expected
inoremap <C-v> <ESC>pa
" Make copy in visual mode work as expected
vnoremap <C-c> y

" Make `Y` `y$` consistent with `D`, `C`, etc
nnoremap Y y$

" Remap useless keys
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

" Make saving and quitting easier and faster
nnoremap <silent> <leader>w :write<CR>
nnoremap <silent> <leader>d :quit<CR>

" Make splits make more sense
set splitbelow
set splitright

" Remap undo to make more sense
nnoremap U <C-r>
nnoremap <C-r> <NOP>

" Turn off search highlighting because vim doesn't do that by default for some reason
nnoremap <silent> <ESC><ESC> :nohlsearch<CR>

" Toggle spell checking with F1
nnoremap <F12> :setlocal spell! spelllang=en_us<CR>

" Easier window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
" Easier window resizing. I can't make C-< or C-> work
nnoremap <C-n> <C-w><
nnoremap <C-m> <C-w>>
" Easier tab navigation
nnoremap <M-h> gT
nnoremap <M-l> gt
" Make tabs easier
nnoremap <leader>t :tabnew<CR>
nnoremap <leader>T :tabclose<CR>
" Easier swapping between buffers
nnoremap <tab> <C-^>

if exists(':term')
  " Make terminals always open in insert mode
  autocmd TermOpen * startinsert

  " Easier terminal opening. L for shell
  nnoremap <silent> <leader>l :terminal<CR>

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
end
