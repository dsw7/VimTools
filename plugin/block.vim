function s:IsValidRange(start_line, end_line)
    let exit_status = 1

    if (a:start_line < 0) || (a:end_line < 0)
        echoerr "Start and end lines must be greater than 0!"
        let exit_status = 0
    endif

    if a:start_line > a:end_line
        echoerr "Start line cannot exceed end line!"
        let exit_status = 0
    endif

    return exit_status
endfunction

function s:FileExists(filename)
    let exit_status = 1

    if !filereadable(a:filename)
        echoerr "File " . a:filename . " does not exist!"
        let exit_status = 0
    endif

    return exit_status
endfunction

function s:IsValidEndLine(end_line, filename)
    let exit_status = 1

    if a:end_line > str2nr(system("wc -l " . a:filename . " | awk '{print $1}'"))
        echoerr "End line exceeds file line count!"
        let exit_status = 0
    endif

    return exit_status
endfunction

function s:ResolvePathType(path)
    let path_to_file = a:path
    if a:path[0] != '/'
        path_to_file = getcwd() . '/' . a:path
    endif
    return path_to_file
endfunction

function Block(path_to_file, start_line, end_line) 
    let path_to_file = s:ResolvePathType(a:path_to_file)
    let start_line = str2nr(a:start_line)
    let end_line = str2nr(a:end_line)

    " Note that vimscript automatically coerces str to int
    " This is why we have to str2nr start and end lines in advance
    " This arithmetic would otherwise return weird results
    let offset = end_line - start_line + 1

    if !s:IsValidRange(start_line, end_line)
        return
    endif

    if !s:FileExists(path_to_file)
        return
    endif

    if !s:IsValidEndLine(end_line, path_to_file)
        return
    endif

    let block = "head -n " . a:end_line . " " . path_to_file . " | tail -n " . offset
    echo "Running command: " . block

    let stdout = split(system(block), "\n")
    call add(stdout, "")
    call append('.', stdout)

endfunction
