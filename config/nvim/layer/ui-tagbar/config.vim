let g:tagbar_sort=0 " sort the variables as they are in the source file
let g:tagbar_compact=1 " omit the help line at the top

" make the function's signature same as normal text
highlight link TagbarSignature Normal

nmap <F8> :TagbarToggle<CR>
nmap <F9> :TagbarOpen j<CR>
