function NumberToggle()
    if(&relativenumber == 1)
        set norelativenumber
    else
        set relativenumber
    endif
endfunction

function ColumnToggle()
    if(&cursorcolumn == 1)
        set nocursorcolumn
    else
        set cursorcolumn
    endif
endfunction
