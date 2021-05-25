function s:InsertGlobal(character)
    execute '%s/^/' . a:character. '/g'
endfunction

function s:InsertBetweenLines(character, start_line, end_line)
    execute a:start_line . ',' . a:end_line . 's/^/' . a:character . '/g'
endfunction

function s:Insert(character, ...)
    if a:0 == 0
        call s:InsertGlobal(a:character)
    elseif a:0 == 2
        call s:InsertBetweenLines(a:character, a:1, a:2)
    else
        echoerr 'Function takes either 0 or 2 arguments'
    endif
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Insert a delimiter at beginning of lines
command -nargs=+ Ins :call s:Insert(<f-args>)
