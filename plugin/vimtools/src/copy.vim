function s:Copy(start_line, end_line, position)
    let l:start_line = str2nr(a:start_line)
    let l:end_line = str2nr(a:end_line)
    let l:position = str2nr(a:position)

    if l:start_line <= l:end_line
        execute l:start_line . ',' . l:end_line . 't' . l:position
    else
        echoerr "Start line cannot exceed end line!"
    endif
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Copy a block of lines
command -nargs=+ Cp :call s:Copy(<f-args>)
