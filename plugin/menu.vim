" For more information about popup menus:
" https://vimhelp.org/popup.txt.html

" Cannot resolve path to script from inside function
let s:DIRNAME_PLUGIN = expand('<sfile>:p:h')
let s:MARKER_FILEPATH = s:DIRNAME_PLUGIN . "/" . "nomenumarker"

function s:CreateDisableMenuMarker()
    call system("touch " . s:MARKER_FILEPATH)
    if v:shell_error != 0
        echo "Failed to create new marker file"
    else
        echo "Wrote marker file to disable start up menu: " . s:MARKER_FILEPATH
    endif
endfunction

function s:DeleteDisableMenuMarker()
    call system("rm " . s:MARKER_FILEPATH)
    if v:shell_error != 0
        echo "Failed to remove marker file. Did it exist?"
    else
        echo "Removed marker file to enable start up menu: " . s:MARKER_FILEPATH
    endif
endfunction

function s:CheckIfMarkerExists()
    let exit_status = 1

    if !filereadable(s:MARKER_FILEPATH)
        let exit_status = 0
    endif

    return exit_status
endfunction

function MainMenuCallback(id, result)
    if a:result == 1
        echo "Continuing program normally"
    elseif a:result == 2
        help VimTools
        echo "Continuing program normally"
    elseif a:result == 3
        helptags ALL
        echo "Success! Refreshed helptags for VimTools"
    elseif a:result == 4
        call s:CreateDisableMenuMarker()
    elseif a:result == 5
        call s:DeleteDisableMenuMarker()
    else
        exit
    endif
endfunction

function MainMenu()
    call popup_menu(
    \   [
    \       '> Continue VimTools normally',
    \       '> Open VimTools help documentation',
    \       '> Refresh helptags',
    \       '> Disable this menu on start',
    \       '> Enable this menu on start',
    \       '> Exit VimTools'
    \   ],
    \   #{
    \       title: " *** David Weber VimTools Utilities *** ",
    \       callback: 'MainMenuCallback',
    \       line: 25,
    \       col: 40,
    \       highlight: 'WildMenu',
    \       border: [],
    \       close: 'click',
    \       padding: [1, 1, 0, 1]
    \   }
    \)
endfunction

function CallMainMenuOnStart()
    if s:CheckIfMarkerExists() == 1
        return
    endif
    call MainMenu()
endfunction