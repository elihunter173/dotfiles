" This is Eli W. Hunter's Neovim init.vim.
"
" Author: Eli W. Hunter
"

" This idea comes from https://afnan.io/2018-04-12/my-neovim-development-setup/
" load plugins (plugin is a safe word)
for file in split(glob('/home/eli/.config/nvim/packages/*.vim'), '\n')
    exec 'source' file
endfor

" load core config
for file in split(glob('/home/eli/.config/nvim/core/*.vim'), '\n')
    exec 'source' file
endfor
