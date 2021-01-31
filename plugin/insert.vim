function Insert(character, ...)
    if a:0 == 0
        execute '%s/^/' . a:character. '/g'
    elseif a:0 == 1
        call s:InsertHelp()
    elseif a:0 == 2
        let start_line = str2nr(a:1)
        let end_line = str2nr(a:2)
        if start_line <= end_line
            execute start_line . ',' . end_line . 's/^/' . a:character . '/g'
        else
            call s:LineError()
        endif
    endif
endfunction
