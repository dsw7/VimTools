function s:HandleNoWhiteSpaceError(exception)
    if stridx(a:exception, 'E486: Pattern not found') == -1
        echoerr a:exception
    else
        echo 'No whitespace found!'
    endif
endfunction

" Remove whitespace at end of line and before newline throughout file
function s:RemoveWhiteSpace()
    try
        execute '%s/\s\+$//g'
    catch
        call s:HandleNoWhiteSpaceError(v:exception)
    endtry
endfunction

" Remove whitespace before lines between a range of lines
function RemoveWhiteSpaceBeforeLine(start_line, end_line)
    try
        execute a:start_line . ',' . a:end_line . 's/^\s\+//g'
    catch
        call s:HandleNoWhiteSpaceError(v:exception)
    endtry
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remove all whitespace
command Ws :call s:RemoveWhiteSpace()
