Plug 'jiangmiao/auto-pairs' " auto-pairs for brackets, parens, and quotes

" This is manual lazy loading. I do this here because it saves ~100ms on
" startup time.
" It works by loading the plugins on nothing and then running them whenever
" insert mode is entered for the first time

" deoplete is an autocompletition plugin
" Since this is a Neovim-only setup, I do not bother including the vim setup
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins', 'on': [] }

" enable neosnippet, a snippet enabler
Plug 'Shougo/neosnippet.vim', { 'on': [] }
" neosnippet's library
Plug 'Shougo/neosnippet-snippets', { 'on': [] }

augroup load_completion_plugins
  autocmd!
  autocmd InsertEnter * call plug#load('deoplete.nvim', 'neosnippet.vim', 'neosnippet-snippets')
                     \| autocmd! load_completion_plugins
augroup END
