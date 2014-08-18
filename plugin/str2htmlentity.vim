" str2htmlentity.vim
"
" file created in 2008/11/07 20:52:40.
" LastUpdated :2014/08/18 09:58:06.
" Author: iNo <wdf7322@yahoo.co.jp>
" Version: 1.1
" License: MIT License {{{
"   Permission is hereby granted, free of charge, to any person obtaining
"   a copy of this software and associated documentation files (the
"   "Software"), to deal in the Software without restriction, including
"   without limitation the rights to use, copy, modify, merge, publish,
"   distribute, sublicense, and/or sell copies of the Software, and to
"   permit persons to whom the Software is furnished to do so, subject to
"   the following conditions:
"
"   The above copyright notice and this permission notice shall be included
"   in all copies or substantial portions of the Software.
"
"   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
"   OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
"   MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
"   IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
"   CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
"   TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
"   SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
" }}}
"
" Description: Convert from HTML String to Entity.
"
" Installation: Put this file into $HOME/.vim/plugin directory. Add the following settings into .vimrc file as necessary.
" vmap <silent> sx :Str2HtmlEntity<cr>
" vmap <silent> sr :Entity2HtmlString<cr>
"

if exists('g:loaded_str2htmlentity')
  finish
endif
let g:loaded_str2htmlentity = 1

let s:save_cpo = &cpo
set cpo&vim


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


let &cpo = s:save_cpo
unlet s:save_cpo

" vim:fdl=0 fdm=marker:ts=2 sw=2 sts=0:
