if exists("g:loaded_comeblo")
  finish
endif
let g:loaded_vimtask = 1

let s:save_cpo = &cpo
set cpo&vim

command! CommentBlockCreate call comeblo#puts_block()

let &cpo = s:save_cpo
unlet s:save_cpo
