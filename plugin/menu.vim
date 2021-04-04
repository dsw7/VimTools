" https://vimhelp.org/popup.txt.html

function MainMenuCallback(id, result)
    if a:result == 1
        echo "Continuing program normally"
    elseif a:result == 2
        help VimTools
        echo "Continuing program normally"
    elseif a:result == 3
        helptags ALL
        echo "Success! Refreshed helptags for VimTools"
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
