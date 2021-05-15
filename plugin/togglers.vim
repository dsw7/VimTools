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

let s:VimDiff_IsVerticalSplit = 1

" Turn a vertical vimdiff split (the default) into a horizontal split
function s:MakeSplitHorizontal()
    execute "normal! \<C-w>J"
    let s:VimDiff_IsVerticalSplit = 0
endfunction

" Turn a horizontal vimdiff split into a vertical split
function s:MakeSplitVertical()
    execute "normal! \<C-w>H"
    let s:VimDiff_IsVerticalSplit = 1
endfunction

" Toggle the splits
function VimDiffToggle()
    if(s:VimDiff_IsVerticalSplit == 1)
        call s:MakeSplitHorizontal()
    else
        call s:MakeSplitVertical()
    endif
endfunction
