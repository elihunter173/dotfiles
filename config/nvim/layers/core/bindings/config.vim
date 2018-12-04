" set `w!!` to be writing with sudo; currently broken
cmap w!! w !sudo tee >/dev/null %
" This works by writing the file to `sudo tee >/dev/null %`
" tee simply writes the file to stdout (being thrown out here) and to the
" specified file (% is the current file)

" disable highlighting (run :noh) when escape pressed twice in normal mode
nmap <Esc><Esc> :noh<CR>

" make `Y` `y$` consistent with `D`, `C`, etc.
nmap Y y$

" Buffer Hotkeys
map <M-h> :previous<CR>
map <M-l> :next<CR>
map <M-1> :buffer 1<CR>
map <M-2> :buffer 2<CR>
map <M-3> :buffer 3<CR>
map <M-4> :buffer 4<CR>
map <M-5> :buffer 5<CR>
map <M-6> :buffer 6<CR>
map <M-7> :buffer 7<CR>
map <M-8> :buffer 8<CR>
map <M-9> :buffer 9<CR>
map <M-0> :buffer 10<CR>
