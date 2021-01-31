" Remove whitespace at end of line and before newline throughout file
function RemoveWhiteSpace()
    execute '%s/\s\+$//g'
endfunction

function RemoveWhiteSpaceBeforeLine(start_line, end_line)
    execute a:start_line . ',' . a:end_line . 's/^\s\+//g'
endfunction
