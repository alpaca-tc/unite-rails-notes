let s:source = {
      \ 'name' : 'rails/notes',
      \ 'hooks' : {},
      \ 'is_multiline' : 1,
      \ 'description' : '',
      \ 'default_kind' : 'jump_list',
      \ }
      " \ 'syntax' : 'uniteSource__WatsonDefault',

function! unite#sources#notes#define() "{{{
  return s:source
endfunction"}}}

function! s:source.hooks.on_syntax(args, context) "{{{
  syntax case ignore
  syntax region uniteSource__WatsonLine start=' ' end='$'
  " -- Second line
  " \ start='  |     \w\+ - ' end='$'
  " syntax region uniteSource__WatsonSecondLine
  "       \ start='\zs  |     \w\+ - ' end='$'
  "       \ containedin=uniteSource__WatsonDefault
  " syntax match uniteSource__WatsonTag /^\s\+|\s\+\w - /
  "       \ containedin=uniteSource__WatsonSecondLine

  " -- First line
  " g.u
  " [o] Rakefile
  " [x] review (watson.gemspec:2)
  syntax region uniteSource__WatsonFirstLine
        \ start='\s*\[\(o\|x\)]' end='$'
        \ containedin=uniteSource__WatsonLine
  syntax match uniteSource__WatsonBracket /\[\(o\|x\)]/
        \ contained containedin=uniteSource__WatsonFirstLine
  syntax match uniteSource__WatsonResultGood /o/ contained containedin=uniteSource__WatsonBracket
  syntax match uniteSource__WatsonResultBad /x/ contained containedin=uniteSource__WatsonBracket
  syntax match uniteSource__WatsonTag / \(\w\+\) (/ms=s+1,me=e-2
        \ containedin=uniteSource__WatsonFirstLine

  " syntax match uniteSource__WatsonTagName
  "       \ "\<\%(fix\|todo\|review\)\>[?!]\@!"
  "       \ containedin=uniteSource__WatsonTag

  " filepath
  syntax match uniteSource__WatsonPath /([^)]\+)/ contained
        \ containedin=uniteSource__WatsonFirstLine

  highlight WatsonBracket cterm=NONE gui=bold cterm=bold
  highlight WatsonBad guifg=#cd5c5c guibg=NONE guisp=NONE gui=NONE ctermfg=167 ctermbg=NONE cterm=NONE
  highlight WatsonGood term=bold ctermfg=114 gui=italic guifg=#7ccd7c

  " [o], [x]
  highlight default link uniteSource__WatsonBracket WatsonBracket
  highlight default link uniteSource__WatsonResultBad WatsonBad
  highlight default link uniteSource__WatsonResultGood WatsonGood

  " filepath
  highlight default link uniteSource__WatsonPath Directory

  " highlight default link uniteSource__WatsonFirstLine Error
  " highlight default link uniteSource__WatsonTagName Type
  highlight default link uniteSource__WatsonTag Type
endfunction"}}}

function! s:source.gather_candidates(args, context) "{{{
  return rails_notes#get_results(expand('%:p'))
endfunction"}}}
