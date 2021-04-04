function s:IsValidRange(start_line, end_line)
    let l:exit_status = 1

    if (a:start_line < 0) || (a:end_line < 0)
        echoerr "Start and end lines must be greater than 0!"
        let l:exit_status = 0
    endif

    if a:start_line > a:end_line
        echoerr "Start line cannot exceed end line!"
        let l:exit_status = 0
    endif

    return l:exit_status
endfunction

function s:FileExists(filename)
    let l:exit_status = 1

    if !filereadable(a:filename)
        echoerr "File " . a:filename . " does not exist!"
        let l:exit_status = 0
    endif

    return l:exit_status
endfunction

function s:IsValidEndLine(end_line, filename)
    let l:exit_status = 1

    if a:end_line > str2nr(system("wc -l " . a:filename . " | awk '{print $1}'"))
        echoerr "End line exceeds file line count!"
        let l:exit_status = 0
    endif

    return l:exit_status
endfunction

function s:ResolvePathType(path)
    let l:path_to_file = a:path
    if a:path[0] != '/'
        let l:path_to_file = getcwd() . '/' . a:path
    endif
    return l:path_to_file
endfunction

function Block(path_to_file, start_line, end_line)
    let l:path_to_file = s:ResolvePathType(a:path_to_file)
    let l:start_line = str2nr(a:start_line)
    let l:end_line = str2nr(a:end_line)

    " Note that vimscript automatically coerces str to int
    " This is why we have to str2nr start and end lines in advance
    " This arithmetic would otherwise return weird results
    let l:offset = l:end_line - l:start_line + 1

    if !s:IsValidRange(l:start_line, l:end_line)
        return
    endif

    if !s:FileExists(l:path_to_file)
        return
    endif

    if !s:IsValidEndLine(l:end_line, l:path_to_file)
        return
    endif

    let l:block = "head -n " . a:end_line . " " . l:path_to_file . " | tail -n " . l:offset
    echo "Running command: " . l:block

    let l:stdout = split(system(l:block), "\n")
    call add(l:stdout, "")
    call append('.', l:stdout)

endfunction
