" TODO: Figure out colors

" Left
set statusline+=\ %{StatuslineGit()}
set statusline+=\ \|
set statusline+=\ %f\ %m%r%h%w " filepath with modification, readonly, preview, and window tags

set statusline+=%= " the middle spacing
" Right
set statusline+=%l/%L:%v " file position info
set statusline+=\ " whitespace buffer

" This is taken from https://shapeshed.com/vim-statuslines/
" Finds the git object (branch) associated with the current head and then
" deletes all newlines, throwing away stderr
function! GitBranch()
    return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

" Returns the branchname only if it exists
function! StatuslineGit()
    let l:branchname = GitBranch()
    " condition option1:option2
    " shorthand for if condition is true, option1, else option2
    return strlen(l:branchname) > 0? l:branchname:''
endfunction
