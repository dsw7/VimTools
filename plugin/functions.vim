" --------------------------------------------------------------
" PRIVATE FUNCTIONS
" --------------------------------------------------------------
function s:ErrorMsgHeader()
    " Do not use echoerr("message") because this actually throws an error
    echohl ErrorMsg
    echo "Invalid syntax!"
    echohl None
endfunction

function s:LineError()
    call s:ErrorMsgHeader()
    echo "The <start-line> value must not exceed the <end-line> value."
endfunction

" --------------------------------------------------------------
" PUBLIC FUNCTIONS
" --------------------------------------------------------------
function Move(start_line, end_line, position)
    let start_line = str2nr(a:start_line)
    let end_line = str2nr(a:end_line)
    let position = str2nr(a:position)

    if start_line <= end_line
        execute start_line . ',' . end_line . 'm' . position
    else
        call s:LineError()
    endif
endfunction

function Paste()
    normal! "+p
endfunction

function Help()
    echo "List of commands:"
    echo "=========================================================="
    echo ":Cls    -> Clear a search"
    echo ":Ws     -> Remove all whitespace"
    echo ":Wl     -> Remove all whitespace before a set of lines"
    echo ":Cp     -> Copy a block of lines"
    echo ":Ind    -> Indent by 4 spaces"
    echo ":Del    -> Delete between a range of lines"
    echo ":Ins    -> Insert a delimiter at beginning of lines"
    echo ":S      -> Replace a string in current file"
    echo ":Mv     -> Move a block of text"
    echo ":Paste  -> Paste a block of text from system clipboard"
    echo ":Col    -> Toggle cursorcolumn"
    echo ":Block  -> Insert a block of text from another file"
    echo "=========================================================="
endfunction
