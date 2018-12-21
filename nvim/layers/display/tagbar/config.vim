" autoopen when opening a supported file upon vim entry
autocmd VimEnter * nested :call tagbar#autoopen(1)
" autopen when openning a support file
autocmd FileType * nested :call tagbar#autoopen(0)
" autopen when openning a supported buffer
autocmd BufEnter * nested :call tagbar#autoopen(0)

let g:tagbar_sort=0 " sort the variables as they are in the source file
let g:tagbar_compact=1 " omit the help line at the top
let g:tagbar_width = 35

" abolish text highlighting
highlight link TagbarHighlight Normal
" make the function's signature same as normal text
highlight link TagbarSignature Normal


nmap <F8> :TagbarOpen j<CR>
"nmap <F9> :TagbarToggle<CR>
