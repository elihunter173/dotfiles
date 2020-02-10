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
nnoremap <leader>g <Cmd>G<CR>

" Nice session management
call minpac#add('tpope/vim-obsession')
" I don't need things to always save (https://github.com/tpope/vim-obsession/issues/40)
let g:obsession_no_bufenter = 1

" EditorConfig + Fugitive
let g:EditorConfig_exclude_patterns = ['fugitive://.\*']

" Syntax highlighting for more languages
call minpac#add('sheerun/vim-polyglot')
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_auto_insert_bullets = 0
let g:vim_markdown_new_list_item_indent = 2
" LaTeX with no concealing
let g:tex_conceal = ""
let g:vim_markdown_math = 1

if executable('rg')
  set grepprg=rg\ --vimgrep
end

" Fuzzy Finding
call minpac#add('junegunn/fzf', { 'do': '!./install --bin' })
call minpac#add('junegunn/fzf.vim')
" Don't open unnecessary files
let g:fzf_buffers_jump = 1
" Don't pollute the global namespace
let g:fzf_command_prefix = 'Fzf'
" Nice keybindings
nnoremap <leader>o <Cmd>FzfFiles<CR>
nnoremap <leader>f <Cmd>FzfBLines<CR>
nnoremap <leader>F <Cmd>FzfRg<CR>

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

" Word motion through CamelCase and friends
call minpac#add('chaoren/vim-wordmotion')
" let g:wordmotion_prefix = '['

" Common LSPs. Enable when 0.5 hits on all machines
" call minpac#add('neovim/nvim-lsp')

" Make omnifunc more usable
inoremap <C-space> <C-x><C-o>
" Language Server Protocol. Remove when 0.5 hits on all machines
call minpac#add('autozimu/LanguageClient-neovim', {
      \ 'branch': 'next',
      \ 'do': '!bash ./install.sh',
      \ })
" Required for operations modifying multiple buffers like rename.
set hidden
let g:LanguageClient_serverCommands = {
    \ 'rust': ['rustup', 'run', 'stable', 'rls'],
    \ 'cpp': ['clangd', '-background-index',],
    \ 'c': ['clangd', '-background-index',],
    \ 'go': ['gopls'],
    \ 'python': ['pyls'],
    \ 'sh': ['bash-language-server'],
    \ 'java': ['jdtls'],
    \ }
let g:LanguageClient_hoverPreview = 'always'
nnoremap gd <Cmd>call LanguageClient#textDocument_definition()<CR>
nnoremap <leader>r <Cmd>call LanguageClient#textDocument_rename()<CR>
nnoremap <F2> <Cmd>call LanguageClient#textDocument_rename()<CR>
nnoremap <F3> <Cmd>LanguageClientStop<CR>
nnoremap <F4> <Cmd>LanguageClientStart<CR>
command! -nargs=0 Format :call LanguageClient#textDocument_formatting()
" Double tap K to run keywordprg
nnoremap K <nop>
nnoremap KK <Cmd>call LanguageClient#textDocument_hover()<CR>
nnoremap KE <Cmd>call LanguageClient#explainErrorAtPoint()<CR>
" Highlight all instances using S because idk
nnoremap S <Cmd>call LanguageClient#textDocument_documentHighlight()<CR>

" Turn off search highlighting because vim doesn't do that by default for some
" reason
nnoremap <ESC><ESC> <Cmd>nohlsearch\|call LanguageClient#clearDocumentHighlight()<CR>

" A nice tagbar for LSP
call minpac#add('liuchengxu/vista.vim')
" Pretty icons don't work everywhere
let g:vista#renderer#enable_icon = 0

" Base16 colorscheme
call minpac#add('chriskempson/base16-vim')
let base16colorspace=256
" Shut up when we're first installing
silent! colorscheme base16-solarized-dark
if has('termguicolors')
  set termguicolors
endif

" GUI Font settings
set guifont=Hack:h12
" TODO: Colors?
set laststatus=2
set statusline=%f%m%r%w%q%=%{FugitiveHead()}

" Vim undotree visualizer
call minpac#add('mbbill/undotree')
nmap <F5> <Cmd>UndotreeToggle<CR>

" Enable ftplugins for everything
filetype plugin indent on

" Be easy on casing
set ignorecase
set smartcase

" Nice undo
set undofile
if !has('nvim')
  set undodir=~/.vim/undo
endif

" No annoying sound or blink on errors
set noerrorbells
set novisualbell

" Enable mouse support for all modes
set mouse=a

" Disable autocomments for all things
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Why would you ever put 2 spaces after punctuation??
set nojoinspaces

" A more civilized tab
set tabstop=4

" Don't redraw during macros (for performance)
set lazyredraw

if exists('&inccommand')
  set inccommand=nosplit
endif

" Make splitting make more sense
set splitbelow
set splitright

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
nnoremap <C-s> <Cmd>w<CR>
inoremap <C-s> <Cmd>w<CR>
" Make paste in work as expected
inoremap <C-v> <ESC>pa
" Make copy in visual mode work as expected
vnoremap <C-c> y

" TODO: Put these common sense mappings somewhere else
" Make `Y` `y$` consistent with `D`, `C`, etc
nnoremap Y y$
" Remove useless mapping
nnoremap s <NOP>
" Remap undo to make more sense
nnoremap U <C-r>
nnoremap <C-r> <NOP>

" Make saving and quitting easier and faster
nnoremap <leader>w <Cmd>write<CR>
nnoremap <leader>d <Cmd>quit<CR>

" Easier window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
" Easier tab navigation
nnoremap <M-h> gT
nnoremap <M-l> gt
" Make tabs easier
nnoremap <leader>t <Cmd>tabnew<CR>
nnoremap <leader>T <Cmd>tabclose<CR>
" Easier swapping between buffers
nnoremap <tab> <C-^>

if exists(':term')
  " Make terminals always open in insert mode
  autocmd TermOpen * startinsert

  " Easier terminal opening. L for shell
  nnoremap <silent> <leader>l <Cmd>terminal<CR>

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
