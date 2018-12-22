set number relativenumber " enable relative line numbers by default
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber " enable relative line numbers for focused buffer when not in insert mode
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber " disable relative line numbers for non-focused buffers or when in insert mode
augroup END

set listchars=space:·,eol:$,tab:>-,trail:·,extends:>,precedes:< " define hidden characters
set list " show hidden characters
