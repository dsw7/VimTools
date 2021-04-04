function Delete(start_line, end_line)
    let l:start_line = str2nr(a:start_line)
    let l:end_line = str2nr(a:end_line)

    if l:start_line <= l:end_line
        execute l:start_line . ',' . l:end_line . 'd'
    else
        echoerr "Start line cannot exceed end line!"
    endif
endfunction
