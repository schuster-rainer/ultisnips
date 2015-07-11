let s:SourcedFile=expand("<sfile>")

function! UltiSnips#bootstrap#Bootstrap()
   if exists('s:did_UltiSnips_bootstrap')
      return
   endif
   let s:did_UltiSnips_bootstrap=1

   if !exists("g:UltiSnipsUsePythonVersion")
       let g:_uspy=":py3 "
       if !has("python3")
           if !has("python")
               if !exists("g:UltiSnipsNoPythonWarning")
                   echohl WarningMsg
                   echom  "UltiSnips requires py >= 2.7 or any py3"
                   echohl None
               endif
               unlet g:_uspy
               return
           endif
           let g:_uspy=":py "
       endif
       let g:UltiSnipsUsePythonVersion = "<tab>"
   else
       " Use user-provided value, but check if it's available.
       " This uses `has()`, because e.g. `exists(":python3")` is always 2.
       if g:UltiSnipsUsePythonVersion == 2 && has('python')
           let g:_uspy=":python "
       elseif g:UltiSnipsUsePythonVersion == 3 && has('python3')
           let g:_uspy=":python3 "
       endif
       if !exists('g:_uspy')
           echohl WarningMsg
           echom  "UltiSnips: the Python version from g:UltiSnipsUsePythonVersion (".g:UltiSnipsUsePythonVersion.") is not available."
           echohl None
           return
       endif
   endif

   " Import vim as we expect it to be imported in many places.
   exec g:_uspy "import vim"
   exec g:_uspy "from UltiSnips import UltiSnips_Manager"
endfunction

" The trigger used to expand a snippet.
" NOTE: expansion and forward jumping can, but needn't be the same trigger
if !exists("g:UltiSnipsExpandTrigger")
    let g:UltiSnipsExpandTrigger = "<tab>"
endif

" The trigger used to display all triggers that could possible
" match in the current position.
if !exists("g:UltiSnipsListSnippets")
    let g:UltiSnipsListSnippets = "<c-tab>"
endif

" The trigger used to jump forward to the next placeholder.
" NOTE: expansion and forward jumping can, but needn't be the same trigger
if !exists("g:UltiSnipsJumpForwardTrigger")
    let g:UltiSnipsJumpForwardTrigger = "<c-j>"
endif

" The trigger to jump backward inside a snippet
if !exists("g:UltiSnipsJumpBackwardTrigger")
    let g:UltiSnipsJumpBackwardTrigger = "<c-k>"
endif

" Should UltiSnips unmap select mode mappings automagically?
if !exists("g:UltiSnipsRemoveSelectModeMappings")
    let g:UltiSnipsRemoveSelectModeMappings = 1
end

" If UltiSnips should remove Mappings, which should be ignored
if !exists("g:UltiSnipsMappingsToIgnore")
    let g:UltiSnipsMappingsToIgnore = []
endif

" UltiSnipsEdit will use this variable to decide if a new window
" is opened when editing. default is "normal", allowed are also
" "vertical", "horizontal"
if !exists("g:UltiSnipsEditSplit")
    let g:UltiSnipsEditSplit = 'normal'
endif

" A list of directory names that are searched for snippets.
if !exists("g:UltiSnipsSnippetDirectories")
    let g:UltiSnipsSnippetDirectories = [ "UltiSnips" ]
endif

" Enable or Disable snipmate snippet expansion.
if !exists("g:UltiSnipsEnableSnipMate")
    let g:UltiSnipsEnableSnipMate = 1
endif
