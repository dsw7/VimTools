command Cls :noh                                               " Clear a search
command -nargs=? Ws :call RemoveWhiteSpace(<f-args>)           " Remove all whitespace
command -nargs=+ Wl :call RemoveWhiteSpaceBeforeLine(<f-args>) " Remove all whitespace before lines
command -nargs=+ Cp :call Copy(<f-args>)                       " Copy a block of lines
command -nargs=+ Ind :call Indent(<f-args>)                    " Indent by 4 spaces
command -nargs=+ Del :call Delete(<f-args>)                    " Delete between a range of lines
command -nargs=+ Ins :call Insert(<f-args>)                    " Insert a delimiter at beginning of lines
command -nargs=+ S :call Replace(<f-args>)                     " Replace a string in current file
command -nargs=+ SubAll :call ReplaceInAllFiles(<f-args>)      " Replace a string in all files in working dir
command -nargs=+ Mv :call Move(<f-args>)                       " Move a block of text
command -nargs=? Paste :call Paste(<f-args>)                   " Paste text from system clipboard
command -nargs=+ Header :call Header(<f-args>)                 " Create some header text
command -nargs=? Col :call ColumnToggle(<f-args>)              " Toggle cursorcolumn
command -nargs=? Help :call Help(<f-args>)                     " Print a list of the preceding commands
