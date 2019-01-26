" This is Eli W. Hunter's Neovim init.vim.
"
" Author: Eli W. Hunter
"
" Inspiration: https://afnan.io/2018-04-12/my-neovim-development-setup/
"              https://github.com/jeaye/vimrc/blob/master/vimrc

" no vi compatibility
set nocompatible

" Install vim-plug if it isn't installed and then restart vim
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | qa
endif

" Install plugins
call plug#begin('~/.local/share/nvim/plugged')
runtime! layers/**/package.vim
call plug#end()

runtime! layers/**/config.vim " Load the config of each layer

" NOTES:
"
" vim-plug
" ========
" plug#begin must have a parameter that specifies a directory for plugins
" - Avoid using standard Vim directory names like 'plugin'
" Make sure you use single quotes
" Shorthand notation for GitHub repos (`user/repo`).
" Otherwise, use any valid git URL.
