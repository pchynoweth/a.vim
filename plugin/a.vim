" Copyright (c) 1998-2006
" Michael Sharpe <feline@irendi.com>
"
" We grant permission to use, copy modify, distribute, and sell this
" software for any purpose without fee, provided that the above copyright
" notice and this text are not removed. We make no guarantee about the
" suitability of this software for any purpose and we are not liable
" for any damages resulting from its use. Further, we are under no
" obligation to maintain or extend this software. It is provided on an
" "as is" basis without any expressed or implied warranty.

" Directory & regex enhancements added by Bindu Wavell who is well known on
" vim.sf.net
"
" Patch for spaces in files/directories from Nathan Stien (also reported by
" Soeren Sonnenburg)

" Do not load a.vim if is has already been loaded.
if exists("g:loaded_alternateFile")
    finish
endif
if (v:progname == "ex")
   finish
endif
let g:loaded_alternateFile = 1

" If this is 0, if a buffer for the alternate file in the same directory as
" the current file is not currently open, other buffers with the same basename
" but different directories will be used.  This allows adaptability in the
" event of an unusual file structure, provided that you have actually loaded
" the alternate file already.  This may work as expected for some, but for
" others this behavior may be undesired.
"
" To force matching to only work for alternates in the same folder and
" alternates in g:alternateSearchPath, set this value to 1
if (!exists('g:strictAlternateMatching'))
	let g:strictAlternateMatching = 0
endif

let alternateExtensionsDict = {}

" This variable will be increased when an extension with greater number of dots
" is added by the AddAlternateExtensionMapping call.
let g:alternateMaxDotsInExtension = 1

" Setup default search path, unless the user has specified
" a path in their [._]vimrc.
if (!exists('g:alternateSearchPath'))
  let g:alternateSearchPath = 'sfr:../source,sfr:../src,sfr:../include,sfr:../inc,sfr:../tests'
  " vimrc instead of doing it here.
  "  let g:alternateSearchPath .= ',reg:/src/lib/,reg:|src/|,reg:#\v(lib|test)#src/\1#'
endif

" If this variable is true then a.vim will not alternate to a file/buffer which
" does not exist. E.g while editing a.c and the :A will not swtich to a.h
" unless it exists.
if (!exists('g:alternateNoDefaultAlternate'))
   " by default a.vim will alternate to a file which does not exist
   let g:alternateNoDefaultAlternate = 0
endif

" If this variable is true then a.vim will convert the alternate filename to a
" filename relative to the current working directory.
" Feature by Nathan Huizinga
if (!exists('g:alternateRelativeFiles'))
   " by default a.vim will not convert the filename to one relative to the
   " current working directory
   let g:alternateRelativeFiles = 1
endif

comm! -nargs=? -bang IH call a#AlternateOpenFileUnderCursor("n<bang>", <f-args>)
comm! -nargs=? -bang IHS call a#AlternateOpenFileUnderCursor("h<bang>", <f-args>)
comm! -nargs=? -bang IHV call a#AlternateOpenFileUnderCursor("v<bang>", <f-args>)
comm! -nargs=? -bang IHT call a#AlternateOpenFileUnderCursor("t<bang>", <f-args>)
comm! -nargs=? -bang IHN call a#AlternateOpenNextFile("<bang>")

comm! -nargs=? -bang A call a#AlternateFile("n<bang>", <f-args>)
comm! -nargs=? -bang AS call a#AlternateFile("h<bang>", <f-args>)
comm! -nargs=? -bang AV call a#AlternateFile("v<bang>", <f-args>)
comm! -nargs=? -bang AT call a#AlternateFile("t<bang>", <f-args>)
comm! -nargs=? -bang AN call a#NextAlternate("<bang>")
