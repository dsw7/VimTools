" Commands                        Mode
" --------                        ----
" nmap, nnoremap, nunmap          Normal mode
" imap, inoremap, iunmap          Insert and Replace mode
" vmap, vnoremap, vunmap          Visual and Select mode
" xmap, xnoremap, xunmap          Visual mode
" smap, snoremap, sunmap          Select mode
" cmap, cnoremap, cunmap          Command-line mode
" omap, onoremap, ounmap          Operator pending mode

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
" Toggle between absolute and relative numbering
nnoremap mm :call NumberToggle()<CR>
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
