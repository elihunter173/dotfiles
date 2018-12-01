set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab " make <Tab> insert 4 spaces

set clipboard+=unnamedplus " make neovim use X clipboard

set hidden " make it possible to leave modified buffers

" set `w!!` to be writing with sudo; currently broken
cmap w!! w !sudo tee >/dev/null %
" This works by writing the file to `sudo tee >/dev/null %`
" tee simply writes the file to stdout (being thrown out here) and to the
" specified file (% is the current file)

" disable highlighting (run :noh) when escape pressed twice in normal mode
nmap <Esc><Esc> :noh<CR>

" make `Y` `y$` consistent with `D`, `C`, etc.
nmap Y y$
