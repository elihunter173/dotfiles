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

" Nice undo
set undofile
if !has('nvim')
  set undodir=~/.vim/undo
endif

if exists('&inccommand')
  set inccommand=nosplit
endif

" ripgrep >> grep
if executable('rg')
  set grepprg=rg\ --vimgrep
end

" Easy leader
let mapleader = ' '
" Prevent space from moving forward in normal mode
nnoremap <Space> <NOP>

" Make saving and quitting easier and faster
nnoremap <leader>w <cmd>write<CR>
nnoremap <leader>d <cmd>bp\|bd #<CR>

" Turn off search highlighting because vim doesn't do that by default for some
" reason
nnoremap <leader>s <cmd>nohlsearch<CR>

" Easier window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k

" Make omnifunc more usable
inoremap <C-space> <C-x><C-o>

" Terminal settings
" Easier terminal opening. L for shell
nnoremap <leader>l <cmd>terminal<CR>
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
nnoremap <leader>c <cmd>call append('.', substitute(&commentstring, '\s*%s\s*', ' TODO: ', ''))<CR>j==f:la
nnoremap <leader>C <cmd>call append(line('.')-1, substitute(&commentstring, '\s*%s\s*', ' TODO: ', ''))<CR>k==f:la

" Set up minpac
packadd minpac
if !exists('*minpac#init')
  " First time setup of minpac (not available)
  silent execute '!git clone https://github.com/k-takata/minpac.git ~/.config/nvim/pack/minpac/opt/minpac'
  packadd minpac
endif
call minpac#init()

" Base16 colorscheme
call minpac#add('chriskempson/base16-vim')
if has('termguicolors') && $TERM != "screen"
  set termguicolors
endif
let base16colorspace=256
colorscheme base16-solarized-dark

" Additional text objects
call minpac#add('wellle/targets.vim')
" Surrounding text objects with any character
call minpac#add('machakann/vim-sandwich')

" Easier commenting for any language
call minpac#add('tpope/vim-commentary')

" Nice mappings
call minpac#add('tpope/vim-unimpaired')

" Lightweight git wrapper
" TODO: Check out Gina.vim
call minpac#add('tpope/vim-fugitive')
" EditorConfig + Fugitive
let g:EditorConfig_exclude_patterns = ['fugitive://.\*']
" Interactive (fug)git(ive)
nnoremap <leader>gs <cmd>Gstatus<CR>
nnoremap <leader>gp <cmd>Gpush<CR>

" TODO: Colors?
set laststatus=2
set statusline=%f%m%r%w%q
set statusline+=%=
set statusline+=%{FugitiveHead()}

" Never think about indentation
call minpac#add('tpope/vim-sleuth')

" Netrw but simpler and better
call minpac#add('justinmk/vim-dirvish')
" Disable netrw because I use Dirvish
let g:loaded_netrwPlugin = 1

" https://EditorConfig.org
call minpac#add('editorconfig/editorconfig-vim')

" For :TableFormat in markdown
call minpac#add('godlygeek/tabular')
" Syntax highlighting for more languages
call minpac#add('sheerun/vim-polyglot')
" Markdown shit
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_auto_insert_bullets = 0
let g:vim_markdown_new_list_item_indent = 2
" LaTeX with no concealing
let g:tex_conceal = ""
let g:vim_markdown_math = 1

" Enable editing of readonly files using sudo.
" Remove when   https://github.com/neovim/neovim/pull/10842 gets merged
call minpac#add('lambdalisue/suda.vim')
" Automatically open readonly files with sudo using suda.vim
let g:suda_smart_edit = 1

" Vim undotree visualizer
call minpac#add('mbbill/undotree')

" Fuzzy Finding
" Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
call minpac#add('junegunn/fzf.vim')
" Don't open unnecessary files
let g:fzf_buffers_jump = 1
let g:fzf_layout = { 'window': { 'width': 0.85, 'height': 0.8 } }
let g:fzf_preview_window = ''
" Nice keybindings
nnoremap <leader>o :Buffers<CR>
nnoremap <leader>O :Files<CR>
nnoremap <leader>h :BLines<CR>
nnoremap <leader>H :Rg<CR>

" Floating terminal
call minpac#add('voldikss/vim-floaterm')
nnoremap <leader>t <Cmd>FloatermToggle<CR>
let g:floaterm_width = 0.8
let g:floaterm_height = 0.8

" Common LSPs. Enable when 0.5 hits on all machines
" Plug 'neovim/nvim-lsp'
" Language Server Protocol. Remove in favor of build-in language server when
" Neovim 0.5 hits all my machines.
call minpac#add('prabirshrestha/async.vim')
call minpac#add('prabirshrestha/vim-lsp')
call minpac#add('mattn/vim-lsp-settings')
" Required for operations modifying multiple buffers like rename.
" set hidden
" Nice LSP bindings
nnoremap gd <Cmd>LspDefinition<CR>
nnoremap <leader>r <Cmd>LspRename<CR>
nnoremap <leader>f <Cmd>LspDocumentFormat<CR>
nnoremap K <Cmd>LspHover<CR>
" Diagnostics in floating windows, not virtual text. Helpful for long errors
" and narrow windows
let g:lsp_diagnostics_float_cursor = 1
let g:lsp_virtual_text_enabled = 0

" A nice tagbar for LSP
call minpac#add('liuchengxu/vista.vim')
" Pretty icons don't work everywhere and are idiosyncratic IMO
let g:vista#renderer#enable_icon = 0
let g:vista_fold_toggle_icons = ['-', '+']
