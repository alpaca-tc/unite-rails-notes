let s:source = {
      \ 'name' : 'rails/notes',
      \ 'hooks' : {},
      \ 'is_multiline' : 1,
      \ 'description' : '',
      \ 'default_kind' : 'jump_list',
      \ 'syntax' : 'uniteSource__NotesDefault',
      \ }

function! unite#sources#notes#define() "{{{
  return s:source
endfunction"}}}

function! s:source.hooks.on_syntax(args, context) "{{{
  syntax case ignore
  syntax region uniteSource__NotesLine start=' ' end='$'
  syntax region uniteSource__NotesFirstLine
        \ start='\w\+\s*(' end=')$'
        \ containedin=uniteSource__NotesLine
  syntax match uniteSource__NotesTag /\(FIXME\|TODO\)/
        \ contained containedin=uniteSource__NotesFirstLine
  syntax match uniteSource__NotesTag / \(\w\+\) (/ms=s+1,me=e-2
        \ containedin=uniteSource__NotesFirstLine

  " filepath
  syntax match uniteSource__NotesPath /([^)]\+)/ contained
        \ containedin=uniteSource__NotesFirstLine

  highlight NotesBracket cterm=NONE gui=bold cterm=bold
  highlight NotesBad guifg=#cd5c5c guibg=NONE guisp=NONE gui=NONE ctermfg=167 ctermbg=NONE cterm=NONE
  highlight NotesGood term=bold ctermfg=114 gui=italic guifg=#7ccd7c

  " filepath
  highlight default link uniteSource__NotesPath Comment
  highlight default link uniteSource__NotesTag Define
  highlight default link uniteSource__NotesTag Type
endfunction"}}}

function! s:source.gather_candidates(args, context) "{{{
  return rails_notes#get_results(expand('%:p'))
endfunction"}}}
