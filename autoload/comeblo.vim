let s:save_cpo = &cpo
set cpo&vim

" global field{{{
let g:comment_block_length = 70
let g:comment_block_line_char = "-"
let g:newline_char = "\n"
let g:comment_block_type = "//"
"}}}

" functions{{{
function! s:set_comment_type(type)
  let g:comment_block_type = type
endfunction

function comeblo#create_block(...)
  let introducer =  a:0 >= 1  ?  a:1  :  g:comment_block_type
  let box_char   =  a:0 >= 2  ?  a:2  :  g:comment_block_line_char
  let width      =  a:0 >= 3  ?  a:3  :  g:comment_block_length
  " blockの出力
  return introducer . repeat(box_char, width) . g:newline_char
  \    . introducer . " "                     . g:newline_char
  \    . introducer . repeat(box_char, width) . g:newline_char
endfunction

function comeblo#move_cursor()
  let pos = getpos(".")
  let pos[1] = pos[1] + 2
  let pos[2] = pos[2] + 2
  call setpos(".", pos)
endfunction

function comeblo#puts_block()
  let block = comeblo#create_block()
  call append('.', split(block,"",1))
  comeblo#move_cursor()
endfunction
"}}}

" autogroup{{{
augroup ComebloPluginAuto
  autocmd!
  autocmd BufWritePost *.c call s:set_comment_type("//")
  autocmd BufWritePost *.rb call s:set_comment_type("#")
augroup END
"}}}

let &cpo = s:save_cpo
unlet s:save_cpo
