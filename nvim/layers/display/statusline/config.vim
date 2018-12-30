" TODO: Figure out colors

set statusline=
" Left
set statusline+=%{StatuslineGit()}
set statusline+=%#Bold#\ %f       " filepath
set statusline+=%#String#\ %m   " modified tag
set statusline+=%#ErrorMsg#\ %r " readonly tag
set statusline+=%(%h\ %w%) " Add filepath with modified and readonly flag

set statusline+=%=
" Right
set statusline+=%#Bold#%(%l/%L:%v%) " file position info

" This is taken from https://shapeshed.com/vim-statuslines/
" Finds the git object (branch) associated with the current head and then
" deletes all newlines, throwing away stderr
function! GitBranch()
    return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

" I'm not quite sure yet
function! StatuslineGit()
    let l:branchname = GitBranch()
    return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction
