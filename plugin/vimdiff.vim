" Use a bool local to this script to store the vimdiff split state throughout the session
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

function s:VimDiffToggle()
    if(s:VIMDIFF_IS_VERTICAL_SPLIT == 1)
        call s:MakeSplitHorizontal()
    else
        call s:MakeSplitVertical()
    endif
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Toggle between horizontal and vertical vimdiff splits using a custom command
if &diff
    command Vs :call s:VimDiffToggle()
endif

" Toggle between horizontal and vertical vimdiff splits using a mapping
if &diff
    nnoremap hs :call s:VimDiffToggle()<CR>
endif
