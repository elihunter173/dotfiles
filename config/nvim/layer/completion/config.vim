" enable deoplete when InsertEnter
let g:deoplete#enable_at_startup = 0
autocmd InsertEnter * call deoplete#enable() " Only enable deoplete when insert mode is entered to decrease startup time

" decrease amount of time for deoplete to activate
let g:deoplete#auto_complete_delay = 5  " Default is 50
let g:deoplete#auto_refresh_delay = 30  " Default is 500
