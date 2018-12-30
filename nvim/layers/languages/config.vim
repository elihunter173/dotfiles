" Currently (11-28-18), markdown syntax highlighting is bugged, so this
" disables it
let g:polyglot_disabled = ['markdown']

" Enable Java language server
let g:LanguageClient_serverCommands = {
    \ 'java': ['/usr/bin/jdtls'],
    \ 'python': ['/usr/bin/pyls'],
    \ }
