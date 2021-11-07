" Function is global (i.e. missing the s:* prefix) scoped because there is a mapping in the
" mappings.vim file

function ColumnToggle()
    if(&cursorcolumn == 1)
        set nocursorcolumn
    else
        set cursorcolumn
    endif
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Toggle cursorcolumn
command Col :call ColumnToggle()
