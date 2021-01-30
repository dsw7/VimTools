" Replace whatever is in / register throughout file
function s:ReplaceGlobally(replacement)
    execute '%s/' . escape(getreg('/'), '/') . '/' . a:replacement . '/g'
endfunction

" Replace whatever is in / register on line start_line
function s:ReplaceOnOneLine(replacement, line)
    execute a:line . 's/' . escape(getreg('/'), '/') . '/' . a:replacement . '/g'
endfunction

" Replace whatever is in / between lines start_line and end_line


function ReplaceTest(output, ...)
    if a:0 == 0
        call s:ReplaceGlobally(a:output)
    elseif a:0 == 1
        call s:ReplaceOnOneLine(a:output, str2nr(a:1))
    elseif a:0 == 2    " Replace whatever is in / between lines start_line and end_line
        let start_line = str2nr(a:1)
        let end_line = str2nr(a:2)
        if start_line <= end_line
            execute start_line . ',' . end_line . 's/' . escape(getreg('/'), '/') . '/' . a:output . '/g'
        else
            call s:LineError()
        endif
    else
        call s:ReplaceHelp()
    endif
endfunction

command -nargs=+ R :call ReplaceTest(<f-args>)
