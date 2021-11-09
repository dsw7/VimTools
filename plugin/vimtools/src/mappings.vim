" Automatically close braces
inoremap {<CR> {<CR>}<Esc>ko<tab>

" Automatically close brackets
inoremap [<CR> [<CR>]<Esc>ko<tab>

" Automatically close parentheses
inoremap (<CR> (<CR>)<Esc>ko<tab>

" Use jj to esc
inoremap jj <Esc>l

" Use a to jump to end of word and insert
nnoremap a f<Space>i

" Use C-{hjkl} to move around while in insert mode
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>

" Jump to beginning of line
" Note that you can also just use _
nnoremap ff 0w

" Remap PGUP and PGDN to slide viewport
nnoremap <PageDown> <C-d>
nnoremap <PageUp> <C-u>

" Jump between :vsplit (:vs) or :split (:sp) splits
nnoremap tt <C-w>w

" Toggle between absolute and relative line numbering
nnoremap ss :call NumberToggle()<CR>

" Toggle cursorcolumn
nnoremap cx :call ColumnToggle()<CR>
