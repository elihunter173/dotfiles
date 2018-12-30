set number relativenumber " enable relative line numbers by default
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber " enable relative line numbers for focused buffer when not in insert mode
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber " disable relative line numbers for non-focused buffers or when in insert mode
augroup END

set listchars=tab:>-,trail:·,extends:>,precedes:< " define hidden characters
set list " show hidden characters

" number of lines to pad cursor by when scrolling
set scrolloff=3

" turn off error beep/flash
set visualbell t_vb=
" turn off visual bell
set novisualbell
