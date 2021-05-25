" Clear a search
command Cls :noh

" Replace a string in current file
command -nargs=+ S :call Replace(<f-args>)

" Replace a string in all files in working dir
command -nargs=+ SubAll :call ReplaceInAllFiles(<f-args>)

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
