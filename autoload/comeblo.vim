let s:save_cpo = &cpo
set cpo&vim

let g:comment_block_length = 50
let g:comment_block_line_char = "-"
let g:newline_char = "\n"

let g:comment_block_type = "#"

function comeblo#create(...)
  let introducer =  a:0 >= 1  ?  a:1  :  g:comment_block_type
  let box_char   =  a:0 >= 2  ?  a:2  :  g:comment_block_line_char
  let width      =  a:0 >= 3  ?  a:3  :  g:comment_block_length
  " blockの出力
  return introducer . repeat(box_char, width) . g:newline_char
  \    . introducer . " "                     . g:newline_char
  \    . introducer . repeat(box_char, width) . g:newline_char
endfunction

function comeblo#puts()
  let block = comeblo#create()
  call append('.', split(block,"",1))
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
