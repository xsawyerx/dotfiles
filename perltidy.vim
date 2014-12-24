if exists('g:perltidy')
    finish
en

function! s:TrimEndLines()
    let save_cursor = getpos(".")
    :silent! %s#\($\n\s*\)\+\%$##
    call setpos('.', save_cursor)
endfunction


function!s:PerlTidy()
    let old_shell = &shell
    let &shell = old_shell
    let b:firstline = a:firstline
    let b:lastline = a:lastline
    if b:firstline == b:lastline
      let b:firstline = 1
      let b:lastline = line('$')
    endif
    let lines = join(getline(b:firstline, b:lastline), "\n")
    let b:perltidy_output = system('perltidy -q ', lines)
    let &shell = old_shell
    let prevcur = getpos(".")
    let prevx = getpos("'x")
    let prevy = getpos("'y")
    call setpos("'x", [0, b:firstline, 0, 0])
    call setpos("'y", [0, b:lastline, 0, 0])
    exec "'x,'yd"
    set paste
    call setpos(".", [0, b:firstline, 0, 0])
    exec ":normal i" . b:perltidy_output
    call s:TrimEndLines()
    call setpos(".", prevcur)
    call setpos("'x", prevx)
    call setpos("'y", prevy)
endfunction

command! -nargs=* -range -bang PerlTidy <line1>,<line2>call s:PerlTidy()

vnoremap :call PerlTidy() t
au BufWritePre *.p[lm],*.t call s:PerlTidy()

let g:perltidy = 1
