"------------------------------------------------
" Configuration
"------------------------------------------------
function! notes#init()
  if !exists('g:notes#buffer_name')
    :let curDate=strftime('%Y%m%d_%H%M%S')
    :let g:notes#buffer_name='notes_to_file_'.curDate
  endif

  if !exists('g:notes#file_name')
    :let g:notes#file_name='notes.txt'
  endif
endfunction

"------------------------------------------------
" Re-open the notes taking buffer
"------------------------------------------------
function! notes#openBuffer()
  :call notes#init()
  :let v = bufwinnr(g:notes#buffer_name)
  if v>0
    :echo v
    :sb v
  else
    :execute 'new '.g:notes#buffer_name
    :set hidden
  endif
endfunction

"------------------------------------------------
" Re-open the notes taking buffer
"------------------------------------------------
function! notes#tagEntry()
  :let filename=expand('%')
  :let fileline=line('.')
  :return filename.','.fileline
endfunction

"------------------------------------------------
" Open note and enter tag
"------------------------------------------------
function! notes#openAndTag()
  :let tag=notes#tagEntry()
  :call notes#openBuffer()
  :call append(line('$'), '* '.tag.':  ')
endfunction

"------------------------------------------------
" Re-open the notes taking buffer
"------------------------------------------------
function! notes#makeEntry(text)
  ":let tag=notes#tagEntry()
  :let noteText=a:text
  ":call notes#openBuffer()
  :call notes#openAndTag()
  :call append(line('$'),'   '.noteText)
  :quit
endfunction

"------------------------------------------------
" Note command handling
"------------------------------------------------
function! notes#noteCommand(...)
  if a:0 > 0
    if len(a:1)>0
      :call notes#makeEntry(a:1)
    else
      ":call notes#openBuffer()
      :call notes#openAndTag()
      :execute 'normal GA'
    endif
  else
    ":call notes#openBuffer()
    :call notes#openAndTag()
    :execute 'normal GA'
  endif
endfunction

"------------------------------------------------
" Save the note file to a given filename
"------------------------------------------------
function! notes#noteSave(name)
  :let filename=a:name
  :call notes#openBuffer()
  if len(a:name)>0
    :execute 'write! '.a:name
  else
    :execute ':write! '.g:notes#file_name
    :let filename=g:notes#file_name
  endif
  :quit
  :echo filename.' written.'
endfunction

"------------------------------------------------
" Save the note file to a given filename
"------------------------------------------------
function! notes#noteLoad(name)
  :let filename=a:name
  if len(a:name)==0
    :let filename=g:notes#file_name
  endif

  if filereadable(filename)
    :call notes#openBuffer()
    :execute ':0r!cat '.filename
    :echo filename.' loaded.'
  else
    :echo filename.' not found.'
  endif
endfunction

"------------------------------------------------
" Commands
"------------------------------------------------

:command! -nargs=*  Note        :call notes#noteCommand(<q-args>)

:command! -nargs=0  NoteOpen    :call notes#openBuffer()

:command! -nargs=*  NoteSave    :call notes#noteSave(<q-args>)

:command! -nargs=*  NoteLoad    :call notes#noteLoad(<q-args>)

:command! -nargs=0  NoteDiscard :execute ':bd! '.g:notes#buffer_name
