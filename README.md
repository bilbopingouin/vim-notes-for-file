# vim-notes-for-file

Note taking utility for reviewing a file (or set of files)

## Intended use

When doing code review locally, I want to be able to collect notes. Those could then be uploaded to various plaforms (e.g. gitlab/github). It is a single buffer, containing the file and line to which the note refer to. The note can then be saved to a given file later, or completely discarded.

## Commands

It uses several commands

- `:Note`.        This is intended to enter a new note. It could be used in two ways:
  - `:Note`       without parameter opens the buffer. The user can manually enter the note.
  - `:Note some comments` will insert the 'some comments' into the buffer and close it automatically.
- `:NoteOpen`     shows the note buffer
- `:NoteDiscard`  delete the note (careful, it is based on `:bd`, so no recovery possible)
- `:NoteSave`     save the note to a file. 
  - `:NoteSave filename.txt` will save the note to the file `filename.txt`
  - `:NoteSave` will save the note to the file in `g:notes#file_name`
- `:NoteLoad`     loads the notes from a file and prepend it to the current buffer
  - `:NoteLoad filename.txt` will take it from the file `filename.txt`
  - `:NoteLoad` will take it from the file in `g:notes#file_name`
