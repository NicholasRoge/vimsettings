function! s:CreateDirIfNotExists()
    let dir = expand("%:p:h")
    if !isdirectory(dir)
        call mkdir(dir, 'p')
    endif
endfunction

:augroup CreateDirOnWrite
    autocmd!
    autocmd BufWritePre * :call s:CreateDirIfNotExists()
augroup END
