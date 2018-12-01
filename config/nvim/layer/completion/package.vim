Plug 'jiangmiao/auto-pairs' " auto-pairs for brackets, parens, and quotes

" deoplete is an autocompletition function
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

" enable neosnippet, a snippet enabler
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets' " enable the neosnippets library

