function s:IndentBySingleTab(start_line, end_line)
    execute a:start_line . ',' . a:end_line . 's/^/    /g'
endfunction

function s:IndentByMultipleTabs(start_line, end_line, count)
    let l:tabs = repeat('    ', str2nr(a:count))
    execute a:start_line . ',' . a:end_line . 's/^/' . l:tabs . '/g'
endfunction

function s:Indent(start_line, end_line, ...)
    if a:0 == 0
        call s:IndentBySingleTab(a:start_line, a:end_line)
    elseif a:0 == 1
        call s:IndentByMultipleTabs(a:start_line, a:end_line, a:1)
    else
        echoerr 'Function takes only one additional argument'
    endif
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Indent by 4 spaces
command -nargs=+ Ind :call s:Indent(<f-args>)
