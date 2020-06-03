" vim: filetype=vim
" A Vim agnostic vimrc. This works with both Vim and Neovim.
"
" Author: Eli W. Hunter

" TODO: Remove <silent> commands mappings and replace them with <Cmd>
" TODO: Remove vim support
" TODO: Switch to minpac

" Set up or install minpac
if has('nvim')
  let s:vimplug_path = stdpath('data').'/site/autoload/plug.vim'
  let s:plugged_path = stdpath('data').'/plugged'
else
  let s:vimplug_path = '~/.vim/autoload/plug.vim'
  let s:plugged_path = '~/.vim/plugged'
endif
let s:new_install = 0
let s:vimplug_url = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
if empty(glob(s:vimplug_path))
  silent execute '!curl -fLo '.s:vimplug_path.' --create-dirs '.s:vimplug_url
  let s:new_install = 1
endif

" TODO: Switch to minpac when you never have to deal with Vim 7 :)
call plug#begin(s:plugged_path)
" Additional text objects
Plug 'wellle/targets.vim'
" Surrounding text objects with any character
Plug 'machakann/vim-sandwich'

" Nice matching of paired things (e.g. parens)
" Plug 'jiangmiao/auto-pairs'

" Easier commenting for any language
Plug 'tpope/vim-commentary'

" Nice mappings
Plug 'tpope/vim-unimpaired'

" Lightweight git wrapper
" TODO: Check out Gina.vim
Plug 'tpope/vim-fugitive'

" https://EditorConfig.org
Plug 'editorconfig/editorconfig-vim'

" For :TableFormat in markdown
Plug 'godlygeek/tabular'
" Syntax highlighting for more languages
Plug 'sheerun/vim-polyglot'

" Fuzzy Finding
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Never think about indentation
Plug 'tpope/vim-sleuth'

" Netrw but simpler and better
Plug 'justinmk/vim-dirvish'

" Floating terminal
Plug 'voldikss/vim-floaterm'

" Common LSPs. Enable when 0.5 hits on all machines
" Plug 'neovim/nvim-lsp'
" Language Server Protocol. Remove in favor of build-in language server when
" Neovim 0.5 hits all my machines.
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
" A nice tagbar for LSP
Plug 'liuchengxu/vista.vim'

" Base16 colorscheme
Plug 'chriskempson/base16-vim'

" Enable editing of readonly files using sudo.
" Remove when   https://github.com/neovim/neovim/pull/10842 gets merged
Plug 'lambdalisue/suda.vim'

" Vim undotree visualizer
Plug 'mbbill/undotree'

call plug#end()

if s:new_install
  PlugInstall --sync
endif

" Easy leader
let mapleader = ' '
" Prevent space from moving forward in normal mode
nnoremap <Space> <NOP>

if has('termguicolors') && $TERM != "screen"
  set termguicolors
endif
let base16colorspace=256
colorscheme base16-solarized-dark

" Pretty icons don't work everywhere and are idiosyncratic IMO
let g:vista#renderer#enable_icon = 0
let g:vista_fold_toggle_icons = ['-', '+']

" GUI Font settings
set guifont=Hack:h12

" Give yourself a useful name in the terminal
set title

" TODO: Colors?
set laststatus=2
set statusline=%f%m%r%w%q
set statusline+=%=
set statusline+=%{FugitiveHead()}

" Enable ftplugins for everything
filetype plugin indent on

" Disable netrw because I use Dirvish
let g:loaded_netrwPlugin = 1

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

" Make omnifunc more usable
inoremap <C-space> <C-x><C-o>

" Required for operations modifying multiple buffers like rename.
" set hidden
" Nice LSP bindings
nnoremap <silent> gd :LspDefinition<CR>
nnoremap <silent> <leader>r :LspRename<CR>
nnoremap <silent> K :LspHover<CR>
command! -nargs=0 Format LspDocumentFormat
let g:lsp_semantic_enabled = 1

" Turn off search highlighting because vim doesn't do that by default for some
" reason
nnoremap <silent> <leader>s :nohlsearch<CR>

" Case insensitive searching
set ignorecase

" Markdown shit
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_auto_insert_bullets = 0
let g:vim_markdown_new_list_item_indent = 2
" LaTeX with no concealing
let g:tex_conceal = ""
let g:vim_markdown_math = 1

" Automatically open readonly files with sudo using suda.vim
let g:suda_smart_edit = 1

if executable('rg')
  set grepprg=rg\ --vimgrep
end

" Don't open unnecessary files
let g:fzf_buffers_jump = 1
let g:fzf_layout = { 'window': { 'width': 0.85, 'height': 0.8 } }
let g:fzf_preview_window = ''
" Nice keybindings
nnoremap <leader>o :Buffers<CR>
nnoremap <leader>O :Files<CR>
nnoremap <leader>f :BLines<CR>
nnoremap <leader>F :Rg<CR>

" EditorConfig + Fugitive
let g:EditorConfig_exclude_patterns = ['fugitive://.\*']
" Interactive (fug)git(ive)
nnoremap <silent> <leader>gs :Gstatus<CR>
nnoremap <silent> <leader>gp :Gpush<CR>

" Make tabs easier
nnoremap <silent> <leader>t :FloatermToggle<CR>
let g:floaterm_width = 0.8
let g:floaterm_height = 0.8

" I don't need things to always save (https://github.com/tpope/vim-obsession/issues/40)
let g:obsession_no_bufenter = 1

" Pad cursor when scrolling
set scrolloff=1
set sidescrolloff=5

" Show hidden characters
set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
set list

" Enable line numbers and ruler
set number relativenumber

" Make saving and quitting easier and faster
nnoremap <silent> <leader>w :write<CR>
nnoremap <silent> <leader>d :bdelete<CR>

" Easier window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
" Easier swapping between buffers
nnoremap <tab> <C-^>

if exists(':terminal')
  " Easier terminal opening. L for shell
  nnoremap <silent> <leader>l :terminal<CR>

  " Easier escape
  tnoremap <ESC> <C-\><C-n>

  " Easier window navigation
  tnoremap <C-h> <C-\><C-n><C-w>h
  tnoremap <C-j> <C-\><C-n><C-w>j
  tnoremap <C-k> <C-\><C-n><C-w>k
  tnoremap <C-l> <C-\><C-n><C-w>l

  if has('nvim')
    augroup TermSettings
      autocmd!
      " Make terminals always open in insert mode and no linenumbers in
      " terminals
      autocmd TermOpen * startinsert | setlocal norelativenumber nonumber
    augroup END
  end
end
