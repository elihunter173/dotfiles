" This is Eli W. Hunter's Neovim init.vim.
"
" Author: Eli W. Hunter
"

" This idea comes from https://afnan.io/2018-04-12/my-neovim-development-setup/
" Files are numbered to control load order
for file in split(glob('/home/eli/.config/nvim/config/*.vim'), '\n')
    exec 'source' file
endfor
