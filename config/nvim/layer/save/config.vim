autocmd BufWritePre * %s/\s\+$//e " trim trailing whitespace on write. `e` disables error messages if none found
