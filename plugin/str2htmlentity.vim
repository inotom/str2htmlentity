" str2htmlentity.vim
"
" file created in 2008/11/07 20:52:40.
" LastUpdated :2013/04/04 15:08:56.
" Author: iNo
" Version: 1.0
" Licence: MIT license
"
" Description: Convert from HTML String to Entity.
"
" Installation: Put this file into $HOME/.vim/plugin directory. Add these settings into .vimrc file.
" vmap <silent> sx :Str2HtmlEntity<cr>
" vmap <silent> sr :Entity2HtmlString<cr>
"

function! s:char2entity(str)
    let result = a:str
    if a:str ==? '<'
        let result = '&lt;'
    elseif a:str ==? '>'
        let result = '&gt;'
    elseif a:str ==? '"'
        let result = '&quot;'
    elseif a:str ==? '&'
        let result = '&amp;'
    endif
    return result
endfunction

function! s:entity2char(str)
    let result = a:str
    if a:str ==? '&lt;'
        let result = '<'
    elseif a:str ==? '&gt;'
        let result = '>'
    elseif a:str ==? '&quot;'
        let result = '"'
    elseif a:str ==? '&amp;'
        let result = '&'
    endif
    return result
endfunction

function! s:range2HtmlEntity() range
    silent execute "normal! gv:s/\\%V[\&<>\"]/\\= s:char2entity(submatch(0)) /g\<CR>"
endfunction

function! s:range2HtmlString() range
    silent execute "normal! gv:s/\\%V\&[^;#]\\+;/\\= s:entity2char(submatch(0)) /g\<CR>"
endfunction

" for range command
command! -range Str2HtmlEntity :<line1>,<line2>call s:range2HtmlEntity()
command! -range Entity2HtmlString :<line1>,<line2>call s:range2HtmlString()

" vim:fdl=0 fdm=marker:ts=4 sw=4 sts=0:
