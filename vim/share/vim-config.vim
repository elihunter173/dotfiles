" Make vim's cursor change shape in different modes (VTE)
" (https://vim.fandom.com/wiki/Change_cursor_shape_in_different_modes)
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"
