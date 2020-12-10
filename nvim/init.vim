" Enable line numbers and ruler
set number relativenumber
" Enable ftplugins for everything
filetype plugin indent on
" Enable mouse support for all modes
set mouse=a
" Pad cursor when scrolling
set scrolloff=1
set sidescrolloff=5
" Show hidden characters
set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
set list
" Make splitting make more sense
set splitbelow
set splitright
" No annoying sound or blink on errors
set noerrorbells
set novisualbell
" Why would you ever put 2 spaces after punctuation??
set nojoinspaces
" Give yourself a useful name in the terminal
set title
" A more civilized tab
set tabstop=4
" Don't redraw during macros (for performance)
set lazyredraw

" GUI Font settings
set guifont=Hack:h12

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect
" Avoid showing message extra message when using completion
set shortmess+=c

" Nice undo
set undofile
if !has('nvim')
  set undodir=~/.vim/undo
endif

if exists('&inccommand')
  set inccommand=nosplit
endif

" ripgrep >> grep
set grepprg=rg\ --vimgrep
let $FZF_DEFAULT_COMMAND = 'fd --type f'

" Easy leader
let mapleader = ' '
" Prevent space from moving forward in normal mode
nnoremap <Space> <NOP>

" I like using s for other mappings
nnoremap s <NOP>

" Make saving and quitting easier and faster
nnoremap <leader>w <cmd>write<cr>
nnoremap <leader>d <cmd>bp\|bd #<cr>

" Turn off search highlighting because vim doesn't do that by default for some
" reason
nnoremap <leader>s <cmd>nohlsearch<cr>

" Easier window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k

nnoremap ]q <cmd>cnext<cr>
nnoremap [q <cmd>cprev<cr>

" Terminal settings
" Easier terminal opening. L for shell
nnoremap <leader>l <cmd>terminal<cr>
" Easier escape
tnoremap <ESC> <C-\><C-n>
" Easier window navigation
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l
augroup TermSettings
  autocmd!
  " Make terminals always open in insert mode and no linenumbers in
  " terminals
  autocmd TermOpen * startinsert | setlocal norelativenumber nonumber
augroup END

" Replace the current line with todo comment. Have to do nmap because gcc is a
" <Plug> mapping from 'tpope/vim-commentary'
" nmap <leader>c ccTODO:<ESC>gcc0f:a<SPACE>
nnoremap <leader>c <cmd>call append('.', substitute(&commentstring, '\s*%s\s*', ' TODO: ', ''))<cr>j==f:la
nnoremap <leader>C <cmd>call append(line('.')-1, substitute(&commentstring, '\s*%s\s*', ' TODO: ', ''))<cr>k==f:la

lua require("plugins")
" lua require("config")

" Base16 colorscheme
if has('termguicolors') && $TERM != "screen"
  set termguicolors
endif
set background=dark
colorscheme solarized8

" TODO: Colors?
set laststatus=2
set statusline=%f%m%r%w%q
set statusline+=%=
set statusline+=%{FugitiveHead()}
