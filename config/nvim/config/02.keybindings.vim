" set `w!!` to be writing with sudo; currently broken
cmap w!! w !sudo tee > /dev/null %
" This works by writing the file to `sudo tee > /dev/null %`
" tee simply writes the file to stdout (being thrown out here) and to the
" specified file (% is the current file)

" disable highlighting (run :noh) when escape pressed twice in normal mode
nmap <Esc><Esc> :noh<CR>
