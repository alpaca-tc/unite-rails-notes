if exists('g:loaded_rails_notes')
  finish
endif
let g:loaded_rails_notes = 1

let s:save_cpo = &cpo
set cpo&vim

let g:rails_note#command_prefix =
      \ get(g:, 'rails_note#command_prefix', 'bundle exec')

let &cpo = s:save_cpo
unlet s:save_cpo
