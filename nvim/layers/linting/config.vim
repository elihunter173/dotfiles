" Enable display on airline
let g:airline#extensions#ale#enabled = 1

" Define global fixers
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\}
let g:ale_fix_on_save = 1 " I have simple ale fixers, so I'm okay with this.

let g:ale_sign_column_always = 1 " always have the side column open

let g:ale_sign_error = '!!'
let g:ale_sign_warning = '--'
