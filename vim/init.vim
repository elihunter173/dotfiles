" Eli W. Hunter's Neovim init.vim.
"
" Author: Eli W. Hunter

" Install vim-plug if it isn't installed and then restart vim
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | qa
endif

" Install plugins
call plug#begin('~/.local/share/nvim/plugged')
source ~/.local/share/vim/package.vim
source ~/.local/share/vim/package.nvim
call plug#end()

source ~/.local/share/vim/config.vim
source ~/.local/share/vim/config.nvim

" NOTES:
"
" vim-plug
" ========
" plug#begin must have a parameter that specifies a directory for plugins
" - Avoid using standard Vim directory names like 'plugin'
" Make sure you use single quotes
" Shorthand notation for GitHub repos (`user/repo`).
" Otherwise, use any valid git URL.
