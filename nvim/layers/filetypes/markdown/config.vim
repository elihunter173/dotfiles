" Make Markdown indent by 2 by default
let g:vim_markdown_new_list_item_indent = 2

" Disable markdown concealing (it's gross)
let g:vim_markdown_conceal = 0

" Enable LaTeX syntax highlighting
let g:vim_markdown_math = 1
" Enable YAML Frontmatter syntax highlighting
let g:vim_markdown_frontmatter = 1

" Follow links to files and anchors within files `file#anchor`
let g:vim_markdown_follow_anchor = 1

" Make the TOC autoscale
let g:vim_markdown_toc_autofit = 1

" Easy table formatting
nnoremap <leader>t :TableFormat<CR>
