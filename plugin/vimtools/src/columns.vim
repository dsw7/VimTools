function s:ColumnToggle()
    if(&cursorcolumn == 1)
        set nocursorcolumn
    else
        set cursorcolumn
    endif
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Toggle cursorcolumn
command Col :call s:ColumnToggle()
