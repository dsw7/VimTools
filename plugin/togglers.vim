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

" Use a bool local to this script to store the vimdiff split state throughout
" the session
let s:VIMDIFF_IS_VERTICAL_SPLIT = 1

" Turn a vertical vimdiff split (the default) into a horizontal split
function s:MakeSplitHorizontal()
    execute "normal! \<C-w>J"
    let s:VIMDIFF_IS_VERTICAL_SPLIT = 0
endfunction

" Turn a horizontal vimdiff split into a vertical split
function s:MakeSplitVertical()
    execute "normal! \<C-w>H"
    let s:VIMDIFF_IS_VERTICAL_SPLIT = 1
endfunction

" Toggle the vimdiff splits
function VimDiffToggle()
    if(s:VIMDIFF_IS_VERTICAL_SPLIT == 1)
        call s:MakeSplitHorizontal()
    else
        call s:MakeSplitVertical()
    endif
endfunction
