Plug 'jiangmiao/auto-pairs' " auto-pairs for brackets, parens, and quotes

" Install for LanguageClient-neovim
Plug 'autozimu/LanguageClient-neovim', {
  \ 'branch': 'next',
  \ 'do': 'bash install.sh',
\ }

" (Optional) Multi-entry selection UI.
Plug 'junegunn/fzf'

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" enable neosnippet, a snippet enabler
Plug 'Shougo/neosnippet.vim'
" neosnippet's library
Plug 'Shougo/neosnippet-snippets' ", { 'on': [] }
