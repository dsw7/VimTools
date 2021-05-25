function s:Paste()
    normal! "+p
endfunction

" Paste text from system clipboard
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
command Paste :call s:Paste()
