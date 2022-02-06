function! neoformat#formatters#html#enabled() abort
    return ['htmlbeautify']
endfunction

function! neoformat#formatters#html#htmlbeautify() abort
    return {
        \ 'exe': 'html-beautify',
        \ 'args': ['-s 4', '-q'],
        \ 'stdin': 1
        \ }
endfunction
