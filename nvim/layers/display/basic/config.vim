set number relativenumber " enable relative line numbers by default
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained * set relativenumber " enable relative line numbers for focused buffer
  autocmd BufLeave,FocusLost   * set norelativenumber " disable relative line numbers for non-focused buffers
augroup END

set listchars=tab:>-,trail:·,extends:>,precedes:< " define hidden characters
set list " show hidden characters

" number of lines to pad cursor by when scrolling
set scrolloff=4
