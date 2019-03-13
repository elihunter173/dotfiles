" Vim
"
" Author: Eli W. Hunter

" Install vim-plug if it isn't installed and then restart nvim
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | qa
endif

" Install plugins
call plug#begin('~/.local/share/nvim/plugged')
source ~/.local/share/vim/common-package.vim
source ~/.local/share/vim/nvim-package.vim
call plug#end()

source ~/.local/share/vim/common-config.vim
source ~/.local/share/vim/nvim-config.vim
