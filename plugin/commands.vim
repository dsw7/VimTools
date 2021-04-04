" Clear a search
command Cls :noh

" Remove all whitespace
command Ws :call RemoveWhiteSpace()

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
command Col :call ColumnToggle()

" Insert block of text from another file (:help command-complete)
command -nargs=+ -complete=file Block :call Block(<f-args>)

" Print a list of the preceding commands
command Help :call Help()

" Open up main menu for various housekeeping tasks
command Menu :call MainMenu()
