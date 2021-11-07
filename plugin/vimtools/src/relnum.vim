" Function is global (i.e. missing the s:* prefix) scoped because there is a mapping in the
" mappings.vim file

function NumberToggle()
    if(&relativenumber == 1)
        set norelativenumber
    else
        set relativenumber
    endif
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Toggle between absolute and relative numbering
command Num :call NumberToggle()
