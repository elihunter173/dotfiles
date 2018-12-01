" This is Eli W. Hunter's Neovim init.vim.
"
" Author: Eli W. Hunter
"
" Inspiration: https://afnan.io/2018-04-12/my-neovim-development-setup/
"              https://github.com/jeaye/vimrc/blob/master/vimrc

" no vi compatibility
set nocompatible

" This finds the absolute path (:p) of the folder (:h) in which this script
" resides in with the script (s:) scope.
let s:path = expand('<sfile>:p:h')

" Install vim-plug if it isn't installed and then reload the config
" files once vim is done loading.
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  let s:install_dir = ~/.local/share/nvim/site/autoload/plug.vim
  silent !curl -fLo s:install_dir --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | exec 'source' s:path . '/init.vim'
endif

let layers = split(globpath(s:path . '/layer', "*" ), "\n")

" Add each layer's after dir to the runtime path
for l in layers
  let s:after = l . '/after'
  if !empty(glob(s:after))
     exec "set runtimepath+=" . s:after
  endif
endfor

" Install plugins
call plug#begin('~/.local/share/nvim/plugged')
for l in layers
  let s:package = l . '/package.vim'
  if filereadable(s:package)
    exec "source" s:package
  endif
endfor
call plug#end()

" Load the config of each layer
for l in layers
  let s:config = l . '/config.vim'
  if filereadable(s:config)
    exec "source" s:config
  endif
endfor

" NOTES:
"
" vim-plug
" ========
" plug#begin must have a parameter that specifies a directory for plugins
" - Avoid using standard Vim directory names like 'plugin'
" Make sure you use single quotes
" Shorthand notation for GitHub repos (`user/repo`).
" Otherwise, use any valid git URL.
"


" enable ftplugins for everything
filetype plugin indent on
