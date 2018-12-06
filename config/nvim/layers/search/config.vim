" map Ctrl-o to opening denite to look at all files relative to current
" buffer's location

" set S to search buffers and switch
nmap S :Denite buffer<CR>
" set ctrl+o to searching files recursively
nmap <C-o> :Denite file/rec<CR>
