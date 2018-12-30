" TODO: Figure out colors

" Left
set statusline=%(\ %{fugitive#head()}\ \|%) " git head position
set statusline+=%(\ %f\ %m%r%h%w\ %) " filepath with modification, readonly, preview, and window tags

set statusline+=%= " the middle spacing
" Right
set statusline+=%(\ %l/%L:%v\ %) " file position info
