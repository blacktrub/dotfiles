function! neoformat#formatters#javascript#enabled() abort
    return ['pr']
endfunction

function! neoformat#formatters#javascript#pr() abort
    return {
        \ 'exe': 'prettier',
        \ 'args': ['-s 4', '-q','--parser typescript'],
        \ 'stdin': 1
        \ }
endfunction
