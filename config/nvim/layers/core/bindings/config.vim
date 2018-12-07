" unmap needless keys
map s <Nop>
map S <Nop>
"
" Leader mappings from the gods (https://www.reddit.com/r/vim/comments/9zy5xg/leader_mapping_from_the_gods/)
" semicolon is now map leader
let mapleader = ";"
" jump to next match is now . (next to ,)
noremap . ;
" repeat last command is now space, always easy to reach
noremap <Space> .

" set `w!!` to be writing with sudo; currently broken
cmap w!! w !sudo tee >/dev/null %
" This works by writing the file to `sudo tee >/dev/null %`
" tee simply writes the file to stdout (being thrown out here) and to the
" specified file (% is the current file)

" disable highlighting (run :noh) when escape pressed twice in normal mode
nmap <Esc><Esc> :noh<CR>

" make `Y` `y$` consistent with `D`, `C`, etc.
nmap Y y$
