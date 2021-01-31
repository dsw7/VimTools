function RemoveWhiteSpace()
    execute '%s/\s\+$//g'
endfunction

function RemoveWhiteSpaceBeforeLine(start_line, end_line)
    let start_line = str2nr(a:start_line)
    let end_line = str2nr(a:end_line)

    if start_line <= end_line
        execute start_line . ',' . end_line . 's/^\s\+//g'
    else
        call s:LineError()
    endif
endfunction
