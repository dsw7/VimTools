" Clear a search
command Cls :noh

" Remove all whitespace
command -nargs=? Ws :call RemoveWhiteSpace(<f-args>)

" Remove all whitespace before lines
command -nargs=+ Wl :call RemoveWhiteSpaceBeforeLine(<f-args>)

" Copy a block of lines
command -nargs=+ Cp :call Copy(<f-args>)

" Indent by 4 spaces
command -nargs=+ Ind :call Indent(<f-args>)

" Delete between a range of lines
command -nargs=+ Del :call Delete(<f-args>)

" Insert a delimiter at beginning of lines
command -nargs=+ Ins :call Insert(<f-args>)

" Replace a string in current file
command -nargs=+ S :call Replace(<f-args>)

" Replace a string in all files in working dir
command -nargs=+ SubAll :call ReplaceInAllFiles(<f-args>)

" Move a block of text
command -nargs=+ Mv :call Move(<f-args>)

" Paste text from system clipboard
command -nargs=? Paste :call Paste(<f-args>)

" Toggle cursorcolumn
command -nargs=? Col :call ColumnToggle(<f-args>)

" Insert block of text from another file
command -nargs=+ Block :call Block(<f-args>)

" Print a list of the preceding commands
command -nargs=? Help :call Help(<f-args>)
