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

" Paste text from system clipboard
command Paste :call Paste()

" Toggle cursorcolumn
command Col :call ColumnToggle()

" Open up main menu for various housekeeping tasks
command Menu :call MainMenu()

" Insert block of text from another file (:help command-complete)
if &diff
    command -nargs=+ Block :call BlockDiff(<f-args>)
else
    command -nargs=+ -complete=file Block :call BlockBasic(<f-args>)
endif

" Toggle between horizontal and vertical vimdiff splits
if &diff
    command Vs :call VimDiffToggle()
endif
