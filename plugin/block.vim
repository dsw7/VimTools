function s:CheckValidRange(start_line, end_line)
    if (a:start_line < 0) || (a:end_line < 0)
        echoerr "Start and end lines must be greater than 0!"
        let exit_status = 0
    else
        let exit_status = 1
    endif
    return exit_status
endfunction

function Block(input_filename, start_line, end_line) abort
    let start_line = str2nr(a:start_line)
    let end_line = str2nr(a:end_line)

    if !s:CheckValidRange(start_line, end_line)
        return
    endif

    if !filereadable(a:input_filename)
        echohl ErrorMsg
        echo "File " . a:input_filename . " does not exist!"
        echohl None
        return
    endif

    let line_count = str2nr(system("wc -l " . a:input_filename . " | awk '{print $1}'"))
    if end_line > line_count
        echohl ErrorMsg
        echo "End line exceeds file line count!"
        echohl None
        return
    endif

    " Note that vimscript automatically coerces str to int
    let offset = end_line - start_line + 1
    let block = "head -n " . a:end_line . " " . a:input_filename . " | tail -n " . offset

    echo "Running command: " . block
    let stdout = split(system(block), "\n")
    call add(stdout, "")
    call append('.', stdout)
endfunction
