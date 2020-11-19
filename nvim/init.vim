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

if executable('fd')
  let $FZF_DEFAULT_COMMAND = 'fd --type f'
end

" Easy leader
let mapleader = ' '
" Prevent space from moving forward in normal mode
nnoremap <Space> <NOP>

" I like using s for other mappings
nnoremap s <NOP>

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

lua require("plugins")
" lua require("config")

" Base16 colorscheme
if has('termguicolors') && $TERM != "screen"
  set termguicolors
endif
set background=dark
colorscheme solarized8

" TODO: Check out Gina.vim
" EditorConfig + Fugitive
" let g:EditorConfig_exclude_patterns = ['fugitive://.\*']
" Interactive (fug)git(ive)
" nnoremap <leader>gs <cmd>Gstatus<CR>
" nnoremap <leader>gp <cmd>Gpush<CR>

" TODO: Colors?
set laststatus=2
set statusline=%f%m%r%w%q
set statusline+=%=
set statusline+=%{FugitiveHead()}

" " Don't open unnecessary files
" let g:fzf_buffers_jump = 1
" let g:fzf_layout = { 'window': { 'width': 0.85, 'height': 0.8 } }
" let g:fzf_preview_window = ''
" " Nice keybindings
" nnoremap <leader>o <cmd>Buffers<CR>
" nnoremap <leader>O <cmd>Files<CR>
" nnoremap <leader>h <cmd>BLines<CR>
" nnoremap <leader>H <cmd>Rg<CR>

" Floating terminal
" nnoremap <leader>t <cmd>FloatermToggle<CR>
" let g:floaterm_width = 0.8
" let g:floaterm_height = 0.8

" LSP {{{
" nnoremap <silent> gd        <cmd>lua vim.lsp.buf.declaration()<CR>
" nnoremap <silent> <c-]>     <cmd>lua vim.lsp.buf.definition()<CR>
" nnoremap <silent> K         <cmd>lua vim.lsp.buf.hover()<CR>
" nnoremap <silent> gD        <cmd>lua vim.lsp.buf.implementation()<CR>
" nnoremap <silent> <C-s>     <cmd>lua vim.lsp.buf.signature_help()<CR>
" inoremap <silent> <C-s>     <cmd>lua vim.lsp.buf.signature_help()<CR>
" nnoremap <silent> 1gD       <cmd>lua vim.lsp.buf.type_definition()<CR>
" nnoremap <silent> gr        <cmd>lua vim.lsp.buf.references()<CR>
" nnoremap <silent> <leader>r <cmd>lua vim.lsp.buf.rename()<CR>
" nnoremap <silent> <leader>f <cmd>lua vim.lsp.buf.formatting()<CR>
" nnoremap <silent> g0        <cmd>lua vim.lsp.buf.document_symbol()<CR>
" nnoremap <silent> gW        <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
" nnoremap <silent> ge        <cmd>lua vim.lsp.util.show_line_diagnostics()<CR>
" nnoremap <silent> ga        <cmd>lua vim.lsp.buf.code_action()<CR>
" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect
" Avoid showing message extra message when using completion
set shortmess+=c
" nnoremap ]d <cmd>NextDiagnostic<CR>
" nnoremap [d <cmd>PrevDiagnostic<CR>

" Manually highlight usages
" nnoremap S <Cmd>lua require'nvim-treesitter-refactor.highlight_definitions'.highlight_usages(vim.fn.bufnr())<CR>
" }}}
