function! neoformat#formatters#go#enabled() abort
    return ['gofmt']
endfunction

function! neoformat#formatters#go#gofmt() abort
    return {
        \ 'exe': 'go fmt',
        \ 'args': ['-s 4', '-q'],
        \ 'stdin': 1
        \ }
endfunction
