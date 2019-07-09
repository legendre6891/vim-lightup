hi clear HighlightZero
hi clear HighlightOne
hi clear HighlightTwo
hi clear HighlightThree
hi clear HighlightFour

hi HighlightZero  guibg='#f5ca47' guifg=bg gui=bold ctermbg=214 ctermfg=bg cterm=bold
hi HighlightOne   guibg='#ca47f5' guifg=bg gui=bold ctermbg=171 ctermfg=bg cterm=bold
hi HighlightTwo   guibg='#72F547' guifg=bg gui=bold ctermbg=83  ctermfg=bg cterm=bold
hi HighlightThree guibg='#F54772' guifg=bg gui=bold ctermbg=203 ctermfg=bg cterm=bold
hi HighlightFour  guibg='#4772F5' guifg=bg gui=bold ctermbg=63  ctermfg=bg cterm=bold


let s:YellowDict = {}
let s:GreenDict = {}
let s:PurpleDict = {}
let s:BlueDict = {}
let s:RedDict = {}

function! HighlightYellow(regex)
    if has_key(s:YellowDict, a:regex)
        call matchdelete(s:YellowDict[a:regex])
        unlet s:YellowDict[a:regex]
    else
        let s:YellowDict[a:regex] = matchadd("HighlightZero", a:regex)
    endif
endfunction

function! HighlightGreen(regex)
    if has_key(s:GreenDict, a:regex)
        call matchdelete(s:GreenDict[a:regex])
        unlet s:GreenDict[a:regex]
    else
        let s:GreenDict[a:regex] = matchadd("HighlightTwo", a:regex)
    endif
endfunction

function! HighlightPurple(regex)
    if has_key(s:PurpleDict, a:regex)
        call matchdelete(s:PurpleDict[a:regex])
        unlet s:PurpleDict[a:regex]
    else
        let s:PurpleDict[a:regex] = matchadd("HighlightOne", a:regex)
    endif
endfunction

function! HighlightRed(regex)
    if has_key(s:RedDict, a:regex)
        call matchdelete(s:RedDict[a:regex])
        unlet s:RedDict[a:regex]
    else
        let s:RedDict[a:regex] = matchadd("HighlightThree", a:regex)
    endif
endfunction

function! HighlightBlue(regex)
    if has_key(s:BlueDict, a:regex)
        call matchdelete(s:BlueDict[a:regex])
        unlet s:BlueDict[a:regex]
    else
        let s:BlueDict[a:regex] = matchadd("HighlightFour", a:regex)
    endif
endfunction

function! ClearHighlight_()
    let s:YellowDict = {}
    let s:GreenDict = {}
    let s:PurpleDict = {}
    let s:BlueDict = {}
    let s:RedDict = {}
    call clearmatches()
endfunction

command! ClearHighlight call ClearHighlight_()
command! -nargs=1 Yellow call HighlightYellow(<f-args>)
command! -nargs=1 Green call HighlightGreen(<f-args>)
command! -nargs=1 Purple call HighlightPurple(<f-args>)
command! -nargs=1 Red call HighlightRed(<f-args>)
command! -nargs=1 Blue call HighlightBlue(<f-args>)


function! s:CycleHighlight(regex)
    let l:yellow = has_key(s:YellowDict, a:regex)
    let l:green = has_key(s:GreenDict, a:regex)
    let l:blue = has_key(s:BlueDict, a:regex)
    let l:red = has_key(s:RedDict, a:regex)
    let l:purple = has_key(s:PurpleDict, a:regex)

    if l:yellow
        call HighlightYellow(a:regex)
        call HighlightGreen(a:regex)
        return
    endif

    if l:green
        call HighlightGreen(a:regex)
        call HighlightBlue(a:regex)
        return
    endif

    if l:blue
        call HighlightBlue(a:regex)
        call HighlightRed(a:regex)
        return
    endif

    if l:red
        call HighlightRed(a:regex)
        call HighlightPurple(a:regex)
        return
    endif

    if l:purple
        call HighlightPurple(a:regex)
        return
    endif

    call HighlightYellow(a:regex)
endfunction

nnoremap <script> <Plug>CycleHighlight <SID>CycleHighlight
nnoremap <SID>CycleHighlight  :call <SID>CycleHighlight("\\<" . expand("<cword>") . "\\>")<CR>
