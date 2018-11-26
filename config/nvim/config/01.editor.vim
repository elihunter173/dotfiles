" This file describes default editor behavior.

set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab " make <Tab> insert 4 spaces

" line numbers
set number relativenumber " enable relative line numbers by default
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber " enable relative line numbers for focused buffer when not in insert mode
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber " disable relative line numbers for non-focused buffers or when in insert mode
augroup END

set clipboard+=unnamedplus " make neovim use X clipboard

autocmd BufWritePre * %s/\s\+$//e " trim trailing whitespace on write. `e` disables error messages if none found
