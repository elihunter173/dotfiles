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
  autocmd TermOpen * startinsert | setlocal norelativenumber nonumber signcolumn=no
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

" General editing
" Easier commenting for any language
call minpac#add('tpope/vim-commentary')
" Additional text objects
call minpac#add('wellle/targets.vim')
" Surrounding text objects with any character
call minpac#add('machakann/vim-sandwich')
" Nice mappings
call minpac#add('tpope/vim-unimpaired')
" gS to split lines and gJ to join lines in a logical way
call minpac#add('AndrewRadev/splitjoin.vim')

" Configuration stuff
" Never think about indentation
call minpac#add('tpope/vim-sleuth')
" https://EditorConfig.org
call minpac#add('editorconfig/editorconfig-vim')

" Enable editing of readonly files using sudo.
" Remove when https://github.com/neovim/neovim/pull/10842 gets merged
call minpac#add('lambdalisue/suda.vim')
" Automatically open readonly files with sudo using suda.vim
let g:suda_smart_edit = 1

" Neovim's CursorHold is a little laggy right now. This fixes that.
call minpac#add('antoinemadec/FixCursorHold.nvim')

" Nice start screen
call minpac#add('mhinz/vim-startify')

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

" Netrw but simpler and better
call minpac#add('justinmk/vim-dirvish')
" Disable netrw because I use Dirvish
let g:loaded_netrwPlugin = 1

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

" Vim undotree visualizer
call minpac#add('mbbill/undotree')

" Fuzzy Finding
call minpac#add('junegunn/fzf.vim')
call minpac#add('junegunn/fzf', { 'do': { -> fzf#install() } })
" Don't open unnecessary files
let g:fzf_buffers_jump = 1
let g:fzf_layout = { 'window': { 'width': 0.85, 'height': 0.8 } }
let g:fzf_preview_window = ''
" Nice keybindings
nnoremap <leader>o <cmd>Buffers<CR>
nnoremap <leader>O <cmd>Files<CR>
nnoremap <leader>h <cmd>BLines<CR>
nnoremap <leader>H <cmd>Rg<CR>

" Floating terminal
call minpac#add('voldikss/vim-floaterm')
nnoremap <leader>t <cmd>FloatermToggle<CR>
let g:floaterm_width = 0.8
let g:floaterm_height = 0.8

" LSP {{{
nnoremap <silent> gd        <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> <c-]>     <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K         <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD        <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <C-s>     <cmd>lua vim.lsp.buf.signature_help()<CR>
inoremap <silent> <C-s>     <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD       <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr        <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> <leader>r <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> <leader>f <cmd>lua vim.lsp.buf.formatting()<CR>
nnoremap <silent> g0        <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW        <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> ge        <cmd>lua vim.lsp.util.show_line_diagnostics()<CR>
nnoremap <silent> ga        <cmd>lua vim.lsp.buf.code_action()<CR>
" This is a lua plugin. Neovim doesn't source lua/ in an autostart plugin
" package by default (for now) so you have to manually packadd it.
call minpac#add('neovim/nvim-lspconfig', {'type': 'opt'})
packadd nvim-lspconfig
call minpac#add('nvim-lua/completion-nvim', {'type': 'opt'})
packadd completion-nvim
" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect
" Avoid showing message extra message when using completion
set shortmess+=c
call minpac#add('nvim-lua/diagnostic-nvim', {'type': 'opt'})
packadd diagnostic-nvim
nnoremap ]d <cmd>NextDiagnostic<CR>
nnoremap [d <cmd>PrevDiagnostic<CR>
lua <<EOF
local nvim_lsp = require("nvim_lsp")
local nvim_completion = require("completion")
local nvim_diagnostic = require("diagnostic")

local custom_attach = function()
  nvim_completion.on_attach()
  nvim_diagnostic.on_attach()
  print("LSP Attached.")
end

nvim_lsp.pyls.setup{ on_attach = custom_attach }
nvim_lsp.jdtls.setup{ on_attach = custom_attach }

nvim_lsp.vimls.setup{ on_attach = custom_attach }
nvim_lsp.sumneko_lua.setup {
  cmd = { vim.fn.stdpath("cache") .. "/nvim_lsp/sumneko_lua/lua-language-server/bin/Linux/lua-language-server", "-E", vim.fn.stdpath("cache") .. "/nvim_lsp/sumneko_lua/lua-language-server/main.lua" },
  on_attach = custom_attach,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
    },
  },
}

nvim_lsp.yamlls.setup{ on_attach = custom_attach }
nvim_lsp.bashls.setup{ on_attach = custom_attach }

nvim_lsp.texlab.setup{ on_attach = custom_attach }

nvim_lsp.clangd.setup{ on_attach = custom_attach }
nvim_lsp.rust_analyzer.setup{ on_attach = custom_attach }
EOF

" A nice tagbar for LSP
call minpac#add('liuchengxu/vista.vim')
" Pretty icons don't work everywhere and are idiosyncratic IMO
let g:vista#renderer#enable_icon = 0
let g:vista_fold_toggle_icons = ['-', '+']
let g:vista_icon_indent = [' ', ' ']
" }}}

" TreeSitter {{{
call minpac#add('nvim-treesitter/nvim-treesitter', {'type': 'opt'})
call minpac#add('nvim-treesitter/nvim-treesitter-refactor', {'type': 'opt'})
packadd nvim-treesitter
packadd nvim-treesitter-refactor
" Manually highlight usages
nnoremap S <Cmd>lua require'nvim-treesitter-refactor.highlight_definitions'.highlight_usages(vim.fn.bufnr())<CR>
lua <<EOF
require'nvim-treesitter.configs'.setup {
  -- one of "all", "language", or a list of languages
  ensure_installed = "all",
  highlight = {
    enable = true,
  },
  refactor = {
    highlight_definitions = { enable = true },
  },
}
EOF
" }}}
