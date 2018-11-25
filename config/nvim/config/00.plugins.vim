" This is the required dein header
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=/home/eli/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('/home/eli/.cache/dein')
  call dein#begin('/home/eli/.cache/dein')

  " Let dein manage dein
  " Required:
  call dein#add('/home/eli/.cache/dein/repos/github.com/Shougo/dein.vim')

  " Add or remove your plugins here like this:
  "call dein#add('Shougo/neosnippet.vim')
  "call dein#add('Shougo/neosnippet-snippets')
  call dein#add('tpope/vim-surround') " enable vim-surround

  " enable deoplete
  call dein#add('Shougo/deoplete.nvim')
  if !has('nvim')
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-neovim-rpc')
  endif
  let g:deoplete#enable_at_startup = 1

  " enble neosnippet with neosnippets
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
"if dein#check_install()
"  call dein#install()
"endif
