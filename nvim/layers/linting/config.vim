" Define global fixers
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\}
" I have simple ale fixers, so I'm okay with this.
let g:ale_fix_on_save = 1

" Always have the side column open (prevents annoying shifts)
let g:ale_sign_column_always = 1

let g:ale_sign_error = '!!'
let g:ale_sign_warning = '--'
