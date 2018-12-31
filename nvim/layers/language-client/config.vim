" I really don't like Language Client

" Map various language client functions to keystrokes
nnoremap <F5> :call LanguageClient_contextMenu()<CR>
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

" Enable Java language server
let g:LanguageClient_serverCommands = {
    \ 'java': ['/usr/bin/jdtls'],
    \ 'python': ['/usr/bin/pyls'],
    \ }
