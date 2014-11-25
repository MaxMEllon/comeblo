let s:save_cpo = &cpo
set cpo&vim

" global field{{{
let g:comment_block_width = 70
let g:comment_block_line_char = "-"
let g:newline_char = "\n"
let s:comment_block_type = "."
"}}}

" functions{{{
function! comeblo#set_comment_type(type)
  let s:comment_block_type = type
  " echo "hoge"
endfunction

function comeblo#create_block(...)
  let introducer = s:comment_block_type
  let box_char   = g:comment_block_line_char
  let width      = g:comment_block_width
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
  call comeblo#move_cursor()
endfunction
"}}}

" autogroup{{{
augroup ComebloPluginAuto
  autocmd!
  autocmd BufRead,BufNewFile,BufNew *.c  call comeblo#set_comment_type("//")
  autocmd BufRead,BufNewFile,BufNew *.rb call comeblo#set_comment_type("#")
  autocmd BufRead,BufNewFile,BufNew * call comeblo#set_comment_type(".")
augroup END
"}}}

let &cpo = s:save_cpo
unlet s:save_cpo
