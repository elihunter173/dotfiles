" This is the required dein skeleton
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

  " call dein#add('wsdjeg/dein-ui.vim') " add a ui to dein. Currently doesn't
  " work for non-SpaceVim installs.

  " Read more about these before enabling them!
  "call dein#add('wellle/targets.vim') " create more text objects
  "call dein#add('bkad/CamelCaseMotion') " enable CamelCase text ojects

  """ DISPLAY:
  call dein#add('joshdick/onedark.vim') " switch to onedark theme
  call dein#add('sheerun/vim-polyglot') " enable vim-polyglot for broader language support

  """ WORKFLOW:
  call dein#add('tpope/vim-surround') " enable vim-surround
  call dein#add('tpope/vim-repeat') " enable vim.repeat (installed for vim-surround)

  " enable deoplete, an autocompletion plugin
  call dein#add('Shougo/deoplete.nvim')
  if !has('nvim')
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-neovim-rpc')
  endif
  let g:deoplete#enable_at_startup = 1

  " enable neosnippet, a snippet enabler
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets') " enable the neosnippets library

  " enable denite, Helm for vim
  call dein#add('Shougo/denite.nvim')

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

