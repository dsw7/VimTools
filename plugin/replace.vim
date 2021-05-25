" Replace whatever is in / register throughout file
function s:ReplaceGlobally(replacement)
    execute '%s/' . escape(getreg('/'), '/') . '/' . a:replacement . '/g'
endfunction

" Replace whatever is in / register on single line
function s:ReplaceOnOneLine(replacement, line)
    execute a:line . 's/' . escape(getreg('/'), '/') . '/' . a:replacement . '/g'
endfunction

" Replace whatever is in / register between lines
function s:ReplaceBetweenLines(replacement, start_line, end_line)
    execute a:start_line . ',' . a:end_line . 's/' . escape(getreg('/'), '/') . '/' . a:replacement . '/g'
endfunction

" Replace whatever is in / register from line 1 to specific line
function s:ReplaceFromStartToLine(replacement, end_line)
    execute '1,' . a:end_line . 's/' . escape(getreg('/'), '/') . '/' . a:replacement . '/g'
endfunction

" Replace whatever is in / register from specific line to last line in file
function s:ReplaceFromLineToEndOfFile(replacement, start_line)
    execute a:start_line . ',$s/' . escape(getreg('/'), '/') . '/' . a:replacement . '/g'
endfunction

function s:Replace(replacement, ...)
    if a:0 == 0
        call s:ReplaceGlobally(a:replacement)
    elseif a:0 == 1
        if a:1[0] == ":"
            call s:ReplaceFromStartToLine(a:replacement, a:1[1:-1])
        elseif a:1[-1:] == ":"
            call s:ReplaceFromLineToEndOfFile(a:replacement, a:1[0:-2])
        else
            call s:ReplaceOnOneLine(a:replacement, a:1)
        endif
    elseif a:0 == 2
        call s:ReplaceBetweenLines(a:replacement, a:1, a:2)
    else
        echoerr "Too many arguments given!"
    endif
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Replace a string in current file
command -nargs=+ S :call s:Replace(<f-args>)
