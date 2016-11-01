" *****************************************************************
" command used to auto check file type
function CheckFileType()
    if exists("b:countCheck") == 0
	let b:countCheck = 0
    endif
    
    let b:countCheck += 1

    if &filetype == "" && b:countCheck>20 && b:countCheck<200
	filetype detect
    elseif &filetype != "" || b:countCheck>200
	autocmd! newFileDectection
    endif
endfunction


augroup newFileDectection
    autocmd CursorMovedI * call CheckFileType()
augroup END 
" *****************************************************************



" *****************************************************************
""" command used to udpate laste modify mark in file 
"autocmd BufWritePre,FileWritePre *.h,*.c  mark s | call LastMod() | `s
"VIKING autocmd BufWritePre,FileWritePre * call LastMod()
"VIKING function LastMod()
"VIKING     " save current cursor position
"VIKING     let curPos = getpos(".")
"VIKING 
"VIKING     let maxLine = line("$")
"VIKING     if maxLine > 45
"VIKING 	let maxLine = 45
"VIKING     endif
"VIKING 
"VIKING     exec " 1," . maxLine . "g/Last modified/s/Last modified: 2016-09-06 14:48
"VIKING 
"VIKING     " restore cursor position
"VIKING     call setpos(".", curPos)
"VIKING endfunction
" *****************************************************************



" *****************************************************************
" below are function used to sort lines accoring to they length
function! s:MyCmp(s1,s2) range
    return strlen(a:s1)-strlen(a:s2)
endfunction

function! s:SortByLength() range
    let line_start = line("'<")
    let line_end = line("'>")

    echo line_start . "\t" . line_end

    let l=map(range(line_start,line_end),"getline(v:val)")

    call sort(l,"s:MyCmp")
    for i in range(line_start,line_end)
	call setline(i,l[i-line_start])
    endfor
endfunction

command! -range=% Sort call s:SortByLength()
" *****************************************************************
