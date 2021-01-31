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

function Replace(replacement, ...)
    if a:0 == 0
        call s:ReplaceGlobally(a:replacement)
    elseif a:0 == 1
        call s:ReplaceOnOneLine(a:replacement, a:1)
    elseif a:0 == 2
        call s:ReplaceBetweenLines(a:replacement, a:1, a:2)
    else
        echoerr "Too many arguments given!"
    endif
endfunction
