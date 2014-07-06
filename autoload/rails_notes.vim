function! rails_notes#get_results(path) "{{{
  let notes = system(g:rails_note#command_prefix . ' rake notes')
  let results = []

  let root_path = s:get_rootpath()
  let current_file = ''

  for line in split(notes, '\n')
    if line =~ '^\s*\* \[\s*\d\+\] \[\([^\]]\+\)\] \(.*\)'
      " * [line] [TAG NAME] comment
      let line_no = substitute(line, '^\s*\* \[\s*\(\d\+\)\].*', '\1', '')
      let tagname = substitute(line, '^\s*\* \[\s*\d\+\] \[\([^\]]\+\)\].*', '\1', '')
      let comment = substitute(line, '^\s*\* \[\s*\d\+\] \[[^\]]\+\] \(.*\)', '\1', '')
      let word = printf("%s (%s:%d)\n%s", tagname, current_file, line_no, comment)
      call add(results, {
            \ 'word' : word,
            \ 'is_multiline' : 1,
            \ 'action__comment' : comment,
            \ 'action__tag' : tagname,
            \ 'action__line' : str2nr(line_no),
            \ 'action__path' : root_path . current_file,
            \ })
    elseif line =~ '^\(.*\):$'
      "path/to/file:
      let current_file = substitute(line, '^\(.*\):$', '\1', '')
    else
      " blank line
      continue
    endif
  endfor

  return results
endfunction"}}}

function! s:get_rootpath()
  if exists('b:rails_root')
    return b:rails_root . '/'
  elseif
    return ''
  endif
endfunction
